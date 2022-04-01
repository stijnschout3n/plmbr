import 'package:easy_localization/easy_localization.dart';
import 'package:plmbr/services/services.dart';
import 'package:flutter/material.dart';
import 'package:plmbr/services/services.dart';
import 'package:table_calendar/table_calendar.dart';

//todo make the form better with validation and button etc

class AddProject extends StatefulWidget {
  AddProject({Key? key, required this.customer}) : super(key: key);

  final Customer customer;

  @override
  State<AddProject> createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _labelFocusNode = FocusNode();
  final FocusNode _causeFocusNode = FocusNode();

  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _causeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("register-project")),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                TableCalendar(focusedDay: DateTime.now(), firstDay: DateTime(2019, 1, 1), lastDay: DateTime(2023, 1, 1))
              ],
            ),
          ),
        ),
      ),
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
}
