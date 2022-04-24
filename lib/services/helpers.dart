import 'package:flutter/material.dart';

import 'services.dart';

enum AppointmentType { part, full }
enum PartType { morning, midday, afternoon }

class Helpers {
  getColorBasedOnStatus(dynamic object) {
    Color c = Colors.black;

    if (object is Project) {
      var status = object.status;

      switch (status) {
        case "Open":
          {
            c = Colors.amber;
            break;
          }
        case "In Progress":
          {
            c = Colors.blue;
            break;
          }
        case "Ready":
          {
            c = Colors.deepPurple;
            break;
          }
        case "Closed":
          {
            c = Colors.green;
            break;
          }
      }
    }
    return c;
  }
}
