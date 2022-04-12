import 'package:easy_localization/easy_localization.dart';
import 'package:plmbr/archive/crm_archived.dart';
import 'package:plmbr/crm/AddProject2.dart';
import 'package:plmbr/crm/ProjectPicker.dart';
import 'package:plmbr/crm/CreateInvoicePDF.dart';
import 'package:plmbr/crm/crm.dart';
import 'package:flutter/material.dart';
import 'package:plmbr/services/services.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewCustomerScreen extends StatefulWidget {
  const ViewCustomerScreen({Key? key, required this.customer}) : super(key: key);

  final Customer customer;

  @override
  State<ViewCustomerScreen> createState() => _ViewCustomerScreenState();
}

class _ViewCustomerScreenState extends State<ViewCustomerScreen> {
  bool switchstatus = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _firstnameController = TextEditingController(text: widget.customer.firstname);
    TextEditingController _lastnameController = TextEditingController(text: widget.customer.lastname);
    TextEditingController _emailController = TextEditingController(text: widget.customer.email);
    TextEditingController _phoneController = TextEditingController(text: widget.customer.phone);
    TextEditingController _streetController = TextEditingController(text: widget.customer.street);
    TextEditingController _housenumberController = TextEditingController(text: widget.customer.housenumber);
    TextEditingController _zipcodeController = TextEditingController(text: widget.customer.zipcode);
    TextEditingController _townController = TextEditingController(text: widget.customer.town);
    TextEditingController _notesController = TextEditingController(text: widget.customer.notes);

    _submitForm() {
      if (_formKey.currentState!.validate()) {
        Customer c = Customer();
        c.fid = widget.customer.fid;
        c.uid = widget.customer.uid;

        c.firstname = _firstnameController.text;
        c.lastname = _lastnameController.text;
        c.email = _emailController.text;
        c.phone = _phoneController.text;
        c.street = _streetController.text;
        c.housenumber = _housenumberController.text;
        c.zipcode = _zipcodeController.text;
        c.town = _townController.text;
        c.notes = _notesController.text;

        FirestoreService().editCustomer(c);

        // If the form passes validation, display a Snackbar.
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr("registration-sent"))));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CrmScreen(),
          ),
          (route) => false,
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(tr("customer")),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Row(
                children: [
                  Text(tr("edit-mode")),
                  Switch(
                    value: switchstatus,
                    onChanged: (value) {
                      setState(() {
                        switchstatus = value;
                      });
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(context: context, builder: (context) => _deletePopupDialog(context));
                      },
                      child: Row(children: <Widget>[Text(tr("delete")), Icon(Icons.delete)]))
                ],
              ),
            )
          ],
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Row(children: [
                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProject2(
                                    customer: widget.customer,
                                    appointmentsofToday: FirestoreService().getAppointmentsRelatedToUserToday(),
                                  ))),
                      icon: Icon(FontAwesomeIcons.houseDamage),
                      label: Text(tr("register")),
                      style: ElevatedButton.styleFrom(fixedSize: (const Size(120, 50))),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => ProjectPicker(customer: widget.customer))),
                      icon: Icon(FontAwesomeIcons.houseDamage),
                      label: Text(tr("view")),
                      style: ElevatedButton.styleFrom(fixedSize: (const Size(120, 50))),
                    ),
                  ]),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //notes
                        TextFormField(
                          readOnly: !switchstatus,
                          keyboardType: TextInputType.multiline,
                          controller: _notesController,
                          decoration: InputDecoration(labelText: tr("enter-notes")),
                          maxLines: 10,
                        ),

                        //firstname
                        TextFormField(
                          readOnly: !switchstatus,
                          keyboardType: TextInputType.name,
                          controller: _firstnameController,
                          decoration: InputDecoration(labelText: tr("first-name")),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr("please-fill-in-first-name");
                            }
                            return null;
                          },
                        ),
                        //lastname
                        TextFormField(
                          readOnly: !switchstatus,
                          keyboardType: TextInputType.name,
                          controller: _lastnameController,
                          decoration: InputDecoration(labelText: tr("last-name")),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr("please-fill-in-last-name");
                            }
                            return null;
                          },
                        ),
                        //email
                        TextFormField(
                            readOnly: !switchstatus,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(labelText: "Email"),
                            validator: (value) {
                              if (RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value.toString())) {
                                return null;
                              }
                              return tr("please-fill-in-email");
                            }),
                        //phone
                        TextFormField(
                          readOnly: !switchstatus,
                          keyboardType: TextInputType.phone,
                          controller: _phoneController,
                          decoration: InputDecoration(labelText: tr("phone")),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr("please-fill-in-phone");
                            }
                            return null;
                          },
                        ),
                        //street
                        TextFormField(
                          readOnly: !switchstatus,
                          keyboardType: TextInputType.text,
                          controller: _streetController,
                          decoration: InputDecoration(labelText: tr("street")),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr("please-fill-in-street");
                            }
                            return null;
                          },
                        ),
                        //housenumber
                        TextFormField(
                          readOnly: !switchstatus,
                          keyboardType: TextInputType.streetAddress,
                          controller: _housenumberController,
                          decoration: InputDecoration(labelText: tr("house-number")),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr("please-fill-in-housenumber");
                            }
                            return null;
                          },
                        ),
                        //zipcode
                        TextFormField(
                          readOnly: !switchstatus,
                          keyboardType: TextInputType.streetAddress,
                          controller: _zipcodeController,
                          decoration: InputDecoration(labelText: tr("zipcode")),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr("please-fill-in-zipcde");
                            }
                            return null;
                          },
                        ),
                        //town
                        TextFormField(
                          readOnly: !switchstatus,
                          keyboardType: TextInputType.streetAddress,
                          controller: _townController,
                          decoration: InputDecoration(labelText: tr("town")),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return tr("please-fill-in-town");
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            if (switchstatus)
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 16,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () => _submitForm(),
                                    child: Text('Update'),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget _deletePopupDialog(BuildContext context) {
    return AlertDialog(
      title: Text(tr("warning")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(tr("are-you-sure-you-want-to-delete") + "${widget.customer.firstname}?"),
        ],
      ),
      actions: <Widget>[
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(tr("no")),
            ),
            Spacer(),
            ElevatedButton(onPressed: _deleteCustomer, child: Text(tr("yes"))),
          ],
        ),
      ],
    );
  }

  void _deleteCustomer() {
    FirestoreService().editCustomer(widget.customer, delete: true);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CrmScreen(),
      ),
      (route) => false,
    );
  }
}
