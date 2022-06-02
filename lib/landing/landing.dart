import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plmbr/shared/bottom_nav.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("homepage")),
        actions: <Widget>[IconButton(onPressed: () => {}, icon: Icon(Icons.search))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          children: [
            Image.asset("assets/PLMBR.png"),
            Image.asset("assets/placeholder_logo.png"),
            Hero(
                tag: "calendar",
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/calendar");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: SizedBox(child: Image.asset("assets/calendar.png"))),
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                          child: Text(tr("calendar")),
                        ))
                      ],
                    ),
                  ),
                )),
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
                        Flexible(child: SizedBox(child: Image.asset("assets/Klantenbestand.png"))),
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: Text(tr("CRM")),
                        ))
                      ],
                    ),
                  ),
                )),
            Hero(
                tag: "knowledgebase",
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/knowledgebase");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: SizedBox(child: Image.asset("assets/knowledgebase.png"))),
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                          child: Text(tr("knowledge-base")),
                        ))
                      ],
                    ),
                  ),
                )),
            Hero(
                tag: "administration",
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/administration");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: SizedBox(child: Image.asset("assets/admin.png"))),
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                          child: Text(tr("administration")),
                        ))
                      ],
                    ),
                  ),
                )),
            Hero(
                tag: "dashboard",
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/dashboard");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: SizedBox(child: Image.asset("assets/dashboard.png"))),
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                          child: Text(tr("dashboard")),
                        ))
                      ],
                    ),
                  ),
                )),
            Hero(
                tag: "profile",
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/profile");
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: SizedBox(child: Image.asset("assets/profile.png"))),
                        Flexible(
                            child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                          child: Text(tr("profile")),
                        ))
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
