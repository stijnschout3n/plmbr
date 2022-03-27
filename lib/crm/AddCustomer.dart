// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plmbr/services/services.dart';
import 'package:plmbr/shared/shared.dart';

class AddCustomerScreen extends StatefulWidget {
  AddCustomerScreen({Key? key}) : super(key: key);

  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _firstnameFocusNode = FocusNode();
  final FocusNode _lastnameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _streetFocusNode = FocusNode();
  final FocusNode _housenumberFocusNode = FocusNode();
  final FocusNode _zipcodeFocusNode = FocusNode();
  final FocusNode _townFocusNode = FocusNode();

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _housenumberController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _townController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //firstname
                  TextFormField(
                    focusNode: _firstnameFocusNode,
                    controller: _firstnameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in a first name';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      _nextFocus(_lastnameFocusNode);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter first name',
                      labelText: 'First Name',
                    ),
                  ),
                  //lastname
                  TextFormField(
                    focusNode: _lastnameFocusNode,
                    controller: _lastnameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in a last name';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      _nextFocus(_emailFocusNode);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter last name',
                      labelText: 'Last Name',
                    ),
                  ),
                  //email
                  TextFormField(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value.toString())) {
                        return null;
                      }
                      return 'Please fill in a valid email';
                    },
                    onFieldSubmitted: (String value) {
                      _nextFocus(_phoneFocusNode);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      labelText: 'Email',
                    ),
                  ),
                  //phone
                  TextFormField(
                    focusNode: _phoneFocusNode,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in a phone number';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      _nextFocus(_streetFocusNode);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      labelText: 'Phone',
                    ),
                  ),
                  //street
                  TextFormField(
                    focusNode: _streetFocusNode,
                    controller: _streetController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in a street name';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      _nextFocus(_housenumberFocusNode);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter street',
                      labelText: 'Street',
                    ),
                  ),
                  //housenumber
                  TextFormField(
                    focusNode: _housenumberFocusNode,
                    controller: _housenumberController,
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in a house number';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      _nextFocus(_zipcodeFocusNode);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter house number',
                      labelText: 'House Number',
                    ),
                  ),
                  //zipcode
                  TextFormField(
                    focusNode: _zipcodeFocusNode,
                    controller: _zipcodeController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in a zipcode';
                      }
                      return null;
                    },
                    onFieldSubmitted: (String value) {
                      _nextFocus(_townFocusNode);
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter zipcode',
                      labelText: 'Zipcode',
                    ),
                  ),
                  //town
                  TextFormField(
                    focusNode: _townFocusNode,
                    controller: _townController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill in a town or city';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter a town or city',
                      labelText: 'City or Town',
                    ),
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 16,
                          ),
                          child: ElevatedButton(
                            onPressed: () => _submitForm(),
                            child: Text('Register'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      Customer c = Customer();

      c.uid = AuthService().user!.uid.toString();

      c.firstname = _firstnameController.text;
      c.lastname = _lastnameController.text;
      c.email = _emailController.text;
      c.phone = _phoneController.text;
      c.street = _streetController.text;
      c.housenumber = _housenumberController.text;
      c.zipcode = _zipcodeController.text;
      c.town = _townController.text;

      FirestoreService().addCustomer(c);

      // If the form passes validation, display a Snackbar.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration sent')));
      Navigator.pop(context);
    }
  }

  _nextFocus(FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }
}
