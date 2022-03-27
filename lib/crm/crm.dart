import 'package:plmbr/crm/AddCustomer.dart';
import 'package:plmbr/crm/ViewCustomer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plmbr/services/services.dart';
import 'package:plmbr/shared/shared.dart';
import 'package:searchable_listview/searchable_listview.dart';

class CrmScreen extends StatefulWidget {
  const CrmScreen({Key? key}) : super(key: key);

  @override
  State<CrmScreen> createState() => _CrmScreenState();
}

class _CrmScreenState extends State<CrmScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Customer>>(
        future: FirestoreService().getCustomersRelatedToUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var customers = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: const Text("CRM"),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                        onTap: () =>
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddCustomerScreen()))
                                .then((value) => setState(() {})),
                        child: Row(children: <Widget>[Text('Add'), Icon(Icons.contacts)])),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SearchableList(
                    initialList: customers,
                    filter: (value) => customers
                        .where(
                          (element) =>
                              element.firstname.toLowerCase().contains(value) ||
                              element.firstname.toLowerCase().contains(value) ||
                              element.street.toLowerCase().contains(value) ||
                              element.town.toLowerCase().contains(value),
                        )
                        .toList(),
                    emptyWidget: EmptyView(),
                    inputDecoration: InputDecoration(
                        labelText: "Search Customer",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    builder: (dynamic item) => CustomerItem(customer: item)),
              ),
            );
          } else {
            return const Text('No Customers found in Firestore. Check database');
          }
        });
  }
}

class CustomerItem extends StatelessWidget {
  final Customer customer;

  const CustomerItem({
    Key? key,
    required this.customer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCustomerScreen(customer: customer)));
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.person,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    customer.firstname + " " + customer.lastname,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Address: ${customer.street} ${customer.housenumber}, ${customer.town}',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('no customers found'),
      ],
    );
  }
}
