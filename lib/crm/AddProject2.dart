import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plmbr/services/services.dart';
import 'package:flutter/material.dart';
import 'package:plmbr/services/services.dart';
import 'package:plmbr/shared/shared.dart';
import 'package:table_calendar/table_calendar.dart';

class AddProject2 extends StatefulWidget {
  AddProject2({Key? key, required this.customer, required this.appointments, required this.project}) : super(key: key);
  final Customer customer;
  final List<CalendarDateObject> appointments;
  final Project project;

  @override
  State<AddProject2> createState() => _AddProject2State();
}

enum AppointmentType { part, full }
enum PartType { morning, midday, afternoon }

class _AddProject2State extends State<AddProject2> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _labelFocusNode = FocusNode();
  final FocusNode _causeFocusNode = FocusNode();
  final FocusNode _dateLabelFocusNode = FocusNode();

  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _causeController = TextEditingController();
  final TextEditingController _dateLabelController = TextEditingController();

  late ValueNotifier<List<CalendarDateObject>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();
  final DateTime _startOfCalendar = DateTime.now().subtract(Duration(days: 365));
  final DateTime _endOfCalendar = DateTime.now().add(Duration(days: 730));
  List<DateTime> _selectedDays = [];
  List<CalendarDateObject> _selectedAppointments = [];

  DateTime? _selectedDay;
  AppointmentType? _appointmentType;
  PartType? _partType;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getAppointmentsOfDay(_selectedDay!, widget.appointments));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("register-project")),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              TextFormField(
                focusNode: _labelFocusNode,
                controller: _labelController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: tr("label"), hintText: tr("label-the-project")),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr("please-fill-in-label");
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return tr("please-fill-in-cause");
                  }
                  return null;
                },
              ),
              TableCalendar(
                availableGestures: AvailableGestures.horizontalSwipe,
                focusedDay: _focusedDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                firstDay: _startOfCalendar,
                lastDay: _endOfCalendar,
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
                    _selectedEvents.value = _getAppointmentsOfDay(selectedDay, widget.appointments);
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(tr("appointments-on-day") +
                    " " +
                    _selectedDay!.day.toString() +
                    "-" +
                    _selectedDay!.month.toString() +
                    ":"),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1), borderRadius: BorderRadius.circular(12)),
                height: 125,
                child: ValueListenableBuilder<List<CalendarDateObject>>(
                  valueListenable: _selectedEvents,
                  builder: (BuildContext context, List<CalendarDateObject> value, Widget? child) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(value[index].fid),
                          textColor: Colors.white,
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_selectedDays.length.toString()),
              ),
              TextFormField(
                  controller: _dateLabelController,
                  focusNode: _dateLabelFocusNode,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done),
              RadioListTile<AppointmentType>(
                  value: AppointmentType.full,
                  title: Text(tr("full-day")),
                  subtitle: Text(tr("full-day-subtitle")),
                  groupValue: _appointmentType,
                  onChanged: (AppointmentType? value) {
                    setState(() {
                      _appointmentType = value;
                    });
                  }),
              RadioListTile<AppointmentType>(
                  value: AppointmentType.part,
                  title: Text(tr("part-day")),
                  subtitle: Text(tr("part-day-subtitle")),
                  groupValue: _appointmentType,
                  onChanged: (AppointmentType? value) {
                    setState(() {
                      _appointmentType = value;
                    });
                  }),
              if (_appointmentType == AppointmentType.part)
                RadioListTile<PartType>(
                    title: Text(tr("morning")),
                    subtitle: Text(tr("morning-subtitle")),
                    value: PartType.morning,
                    groupValue: _partType,
                    onChanged: (PartType? value) {
                      setState(() {
                        _partType = value;
                      });
                    }),
              if (_appointmentType == AppointmentType.part)
                RadioListTile<PartType>(
                    title: Text(tr("midday")),
                    subtitle: Text(tr("midday-subtitle")),
                    value: PartType.midday,
                    groupValue: _partType,
                    onChanged: (PartType? value) {
                      setState(() {
                        _partType = value;
                      });
                    }),
              if (_appointmentType == AppointmentType.part)
                RadioListTile<PartType>(
                    value: PartType.afternoon,
                    title: Text(tr("afternoon")),
                    subtitle: Text(tr("afternoon-subtitle")),
                    groupValue: _partType,
                    onChanged: (PartType? value) {
                      setState(() {
                        _partType = value;
                      });
                    })
            ]),
          ),
        ),
      ),
      floatingActionButton: Wrap(direction: Axis.vertical, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () => _addSelectedDay(),
            heroTag: "button2",
            child: Icon(FontAwesomeIcons.plus),
            backgroundColor: Colors.blue[400],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () => _clearSelectedDays(),
            heroTag: "button3",
            child: Icon(FontAwesomeIcons.cross),
            backgroundColor: Colors.red,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            heroTag: "button1",
            child: Icon(FontAwesomeIcons.save),
            backgroundColor: Colors.green[800],
            onPressed: () => _submitForm(),
          ),
        ),
      ]),
    );
  }

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      Project p = widget.project;

      p.customer = widget.customer.fid;
      DateTime dateTime = DateTime.now();
      p.timeCreated = dateTime.toString();
      p.label = _labelController.text;
      p.cause = _causeController.text;

      FirestoreService().saveProject(p);
      FirestoreService().saveAppointments(_selectedAppointments);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr("registration-sent"))));
      Navigator.pop(context);
    }
  }

  _nextFocus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
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

  _addSelectedDay() {
    if (!_selectedDays.contains(_selectedDay)) {
      if (_appointmentType != null ||
          (_appointmentType == AppointmentType.part && _partType != null) && _dateLabelController.text != "") {
        _selectedDays.add(_selectedDay!);
        CalendarDateObject c = CalendarDateObject();

        c.customer = widget.customer.fid;
        c.label = _dateLabelController.text;
        c.type = _appointmentType.toString();
        if (_appointmentType == AppointmentType.part) {
          c.partType = _partType.toString();
        }
        c.startTimeStamp = _selectedDay.toString();
        c.project = widget.project.fid;
        _selectedAppointments.add(c);

        _dateLabelController.text = "";
        _appointmentType = null;
        _partType = null;
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr("please-fill-in-form"))));
      }
    }
  }

  _clearSelectedDays() {
    _selectedDays = [];
    _selectedAppointments = [];
    setState(() {});
  }
}
