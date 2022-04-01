import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                      Flexible(child: SizedBox(child: Icon(FontAwesomeIcons.personBooth))),
                      Flexible(
                          child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text(tr("CRM")),
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
