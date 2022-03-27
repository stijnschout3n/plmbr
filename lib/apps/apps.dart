import 'package:flutter/material.dart';
import 'package:plmbr/shared/shared.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          Hero(
              tag: "crm",
              child: Card(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, "/crm");
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: SizedBox(
                        child: Image.asset(
                          "assets/crm.png",
                          fit: BoxFit.contain,
                        ),
                      )),
                      const Flexible(
                          child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text("CRM"),
                      ))
                    ],
                  ),
                ),
              )),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
