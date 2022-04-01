import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:plmbr/login/login.dart';
import 'package:plmbr/services/auth.dart';
import 'package:plmbr/landing/landing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(tr("loading"));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(tr("error")),
          );
        } else if (snapshot.hasData) {
          return const LandingScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
