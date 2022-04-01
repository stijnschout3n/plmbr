import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plmbr/services/services.dart';
import 'package:plmbr/shared/shared.dart';

//todo show list of ongoing projects make a toggle to show finished projects
class ProjectPicker extends StatefulWidget {
  ProjectPicker({Key? key, required this.customer}) : super(key: key);

  final Customer customer;
  @override
  State<ProjectPicker> createState() => _ProjectPickerState();
}

class _ProjectPickerState extends State<ProjectPicker> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
        future: FirestoreService().getProjectsRelatedToCustomer(widget.customer),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var projects = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text(tr("select-project")),
              ),
              body: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 5.0, color: Helpers().getColorBasedOnStatus(projects[index]))),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.house,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              projects[index].label,
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 120,
                                  child: ElevatedButton.icon(
                                    onPressed: () => {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SimpleDialog(
                                              title: Text("hi"),
                                            );
                                          })
                                    },
                                    icon: Icon(FontAwesomeIcons.adjust),
                                    label: Text("Uren"),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: ElevatedButton.icon(
                                    onPressed: () => {},
                                    icon: Icon(FontAwesomeIcons.bolt),
                                    label: Text("Status"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Text(tr("no-projects-found"));
          }
        });
  }
}
