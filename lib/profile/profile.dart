import 'dart:developer';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:plmbr/services/auth.dart';
import 'package:plmbr/shared/shared.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              child: Text('signout'),
              onPressed: () async {
                await AuthService().signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              }),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 26),
                  margin: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Text(
                    'Choose language',
                    style: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                _SwitchListTileMenuItem(title: 'Dutch', subtitle: 'Dutch', locale: context.supportedLocales[1]),
                _Divider(),
                _SwitchListTileMenuItem(title: 'English', subtitle: 'English', locale: context.supportedLocales[0]),
                _Divider(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Divider(
        color: Colors.grey,
      ),
    );
  }
}

class _SwitchListTileMenuItem extends StatelessWidget {
  const _SwitchListTileMenuItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.locale,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Locale locale;

  bool isSelected(BuildContext context) => locale == context.locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
      decoration: BoxDecoration(
        border: isSelected(context) ? Border.all(color: Colors.blueAccent) : null,
      ),
      child: ListTile(
          dense: true,
          title: Text(
            title,
          ),
          subtitle: Text(
            subtitle,
          ),
          onTap: () async {
            log(locale.toString(), name: toString());
            await context.setLocale(locale); //BuildContext extension method
          }),
    );
  }
}
