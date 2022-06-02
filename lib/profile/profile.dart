import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:plmbr/services/auth.dart';
import 'package:plmbr/shared/language_picker.dart';
import 'package:plmbr/shared/shared.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("profile")),
      ),
      body: Column(
        children: [
          ElevatedButton(
              child: Text(tr("sign-out")),
              onPressed: () async {
                await AuthService().signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              }),
          LanguagePicker()
        ],
      ),
    );
  }
}
