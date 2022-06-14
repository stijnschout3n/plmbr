import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:plmbr/services/auth.dart';
import 'package:plmbr/services/services.dart';
import 'package:plmbr/shared/language_picker.dart';
import 'package:plmbr/shared/shared.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.userprofile}) : super(key: key);

  final UserProfile userprofile;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _firstnameController = TextEditingController();
    TextEditingController _lastnameController = TextEditingController();
    TextEditingController _streetController = TextEditingController();
    TextEditingController _housenumberController = TextEditingController();
    TextEditingController _zipcodeController = TextEditingController();
    TextEditingController _townController = TextEditingController();
    TextEditingController _companyNameController = TextEditingController();
    TextEditingController _kvkController = TextEditingController();
    TextEditingController _btwController = TextEditingController();
    TextEditingController _emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(tr("profile")),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ElevatedButton(
                child: Text(tr("sign-out")),
                onPressed: () async {
                  await AuthService().signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                }),
            LanguagePicker(),
            Text(tr("profile")),
            Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _firstnameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(labelText: tr("first-name")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("please-fill-in-first-name");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _lastnameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(labelText: tr("last-name")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("please-fill-in-last-name");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _streetController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(labelText: tr("street")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("please-fill-in-street");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _housenumberController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(labelText: tr("house-number")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("please-fill-in-house-number");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _zipcodeController,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(labelText: tr("zipcode")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("please-fill-in-zipcode");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _townController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(labelText: tr("town")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("please-fill-in-town");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _companyNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(labelText: tr("company-name")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("please-fill-in-company-name");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _kvkController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: tr("kvk")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("please-fill-in-kvk");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _btwController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: tr("btw")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr("please-fill-in-btw");
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: tr("email")),
                          validator: (value) {
                            if (RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value.toString())) {
                              return null;
                            }
                            return tr("please-fill-in-email");
                          }),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
