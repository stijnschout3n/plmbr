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
      body: ElevatedButton(
          child: Text('signout'),
          onPressed: () async {
            await AuthService().signOut();
            Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
          }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
