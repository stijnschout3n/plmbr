import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plmbr/services/firestore.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.home,
            size: 20,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.stream,
            size: 20,
          ),
          label: 'Apps',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.userCircle,
            size: 20,
          ),
          label: tr("profile"),
        ),
      ],
      fixedColor: Colors.deepOrange[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            Navigator.popAndPushNamed(context, '/landing');
            break;
          case 1:
            Navigator.popAndPushNamed(context, '/apps');
            break;
          case 2:
            Navigator.popAndPushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
