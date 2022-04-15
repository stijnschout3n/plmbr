import 'package:easy_localization/easy_localization.dart';
import 'package:plmbr/services/services.dart';
import 'package:flutter/material.dart';
import 'package:plmbr/services/services.dart';
import 'package:plmbr/shared/shared.dart';
import 'package:table_calendar/table_calendar.dart';

class futurebuilder extends StatefulWidget {
  futurebuilder({Key? key}) : super(key: key);

  @override
  State<futurebuilder> createState() => _futurebuilderState();
}

class _futurebuilderState extends State<futurebuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CalendarDateObject>>(
      future: FirestoreService().getAppointmentsRelatedToUserOnDay(DateTime.now()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(child: ErrorMessage(message: snapshot.error.toString()));
        } else if (snapshot.hasData) {
          var appointments = snapshot.data;
          return Scaffold();
        }
        return Text(tr("no-customers-found"));
      },
    );
  }
}
