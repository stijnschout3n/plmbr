import 'package:easy_localization/easy_localization.dart';
import 'package:plmbr/services/services.dart';
import 'package:flutter/material.dart';
import 'package:plmbr/services/services.dart';
import 'package:plmbr/shared/shared.dart';
import 'package:table_calendar/table_calendar.dart';

class AddProject2 extends StatefulWidget {
  AddProject2({Key? key, required this.customer}) : super(key: key);
  final Customer customer;
  final List<CalendarDateObject> appointmentsofToday = [CalendarDateObject()];

  @override
  State<AddProject2> createState() => _AddProject2State();
}

class _AddProject2State extends State<AddProject2> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _labelFocusNode = FocusNode();
  final FocusNode _causeFocusNode = FocusNode();

  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _causeController = TextEditingController();

  late ValueNotifier<List<CalendarDateObject>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(widget.appointmentsofToday);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CalendarDateObject>>(
      //idee -> bouw een knopje die alleen de kalender heeft en dus wel async kan
      future: FirestoreService().getAppointmentsRelatedToUserOnDay(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(child: ErrorMessage(message: snapshot.error.toString()));
        } else if (snapshot.hasData) {
          var appointments = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(tr("register-project")),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      focusNode: _labelFocusNode,
                      controller: _labelController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: tr("label"), hintText: tr("label-the-project")),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String value) {
                        _nextFocus(_causeFocusNode);
                      },
                    ),
                    TextFormField(
                        focusNode: _causeFocusNode,
                        controller: _causeController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(labelText: tr("cause"), hintText: tr("cause-of-the-project")),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (String value) => _submitForm()),
                    TableCalendar(
                      availableGestures: AvailableGestures.horizontalSwipe,
                      focusedDay: _focusedDay,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      firstDay: DateTime(2019, 1, 1),
                      lastDay: DateTime(2023, 1, 1),
                      locale: context.locale.toString(),
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        if (!isSameDay(_selectedDay, selectedDay)) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                          _selectedEvents.value = _getAppointmentsOfDay(selectedDay, appointments);
                        }
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                    Container(
                      height: 100.0,
                      child: ValueListenableBuilder<List<CalendarDateObject>>(
                        valueListenable: _selectedEvents,
                        builder: (BuildContext context, List<CalendarDateObject> value, Widget? child) {
                          return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: ListTile(
                                  title: Text(value[index].label),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Text(tr("no-customers-found"));
      },
    );
  }

  _nextFocus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      Project p = Project();

      p.customer = widget.customer.fid;
      DateTime dateTime = DateTime.now();
      p.timeCreated = dateTime.toString();
      p.label = _labelController.text;
      p.cause = _causeController.text;

      FirestoreService().addProject(p);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr("registration-sent"))));
      Navigator.pop(context);
    }
  }

  List<CalendarDateObject> _getAppointmentsOfDay(DateTime day, List<CalendarDateObject> appointments) {
    List<CalendarDateObject> appointmentsOfDay = [];
    for (CalendarDateObject appointment in appointments) {
      var parsedDate = DateTime.tryParse(appointment.startTimeStamp);
      if (parsedDate != null) {
        if (isSameDay(day, parsedDate)) {
          appointmentsOfDay.add(appointment);
        }
      }
    }
    return appointmentsOfDay;
  }
}
