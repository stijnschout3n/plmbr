import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plmbr/services/services.dart';
import 'package:plmbr/shared/shared.dart';

class ProjectPicker extends StatefulWidget {
  ProjectPicker({Key? key, required this.customer}) : super(key: key);

  final Customer customer;
  @override
  State<ProjectPicker> createState() => _ProjectPickerState();
}

class _ProjectPickerState extends State<ProjectPicker> {
  double hrs = 0.0;

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
            projects = _restructureProjectList(projects);
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
                          // start of listview
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.house,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            //label of the project
                            SizedBox(
                              width: 100,
                              child: Text(
                                projects[index].label,
                                style: TextStyle(color: Colors.black),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 120,
                                  //hours button
                                  child: ElevatedButton.icon(
                                    onPressed: () => {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            hrs = projects[index].hours;
                                            return StatefulBuilder(
                                              builder: (BuildContext context, setState) {
                                                return SimpleDialog(
                                                  title: Row(
                                                    children: [
                                                      Text(tr("hours") + ": $hrs"),
                                                      IconButton(
                                                        onPressed: () => {Navigator.pop(context)},
                                                        icon: Icon(Icons.close),
                                                        color: Colors.red,
                                                      )
                                                    ],
                                                  ),
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        ElevatedButton(
                                                            onPressed: () => {
                                                                  setState(() {
                                                                    hrs += 1;
                                                                    projects[index].hours += 1;
                                                                    _updateProjectHours(projects[index]);
                                                                  })
                                                                },
                                                            child: Text("+1")),
                                                        ElevatedButton(
                                                            onPressed: () => {
                                                                  setState(() {
                                                                    hrs -= 1;
                                                                    projects[index].hours -= 1;
                                                                    _updateProjectHours(projects[index]);
                                                                  })
                                                                },
                                                            child: Text("-1")),
                                                        ElevatedButton(
                                                            onPressed: () => {
                                                                  setState(() {
                                                                    hrs += 0.5;
                                                                    projects[index].hours += 0.5;
                                                                    _updateProjectHours(projects[index]);
                                                                  })
                                                                },
                                                            child: Text("+0.5")),
                                                        ElevatedButton(
                                                            onPressed: () => {
                                                                  setState(() {
                                                                    hrs -= 0.5;
                                                                    projects[index].hours -= 0.5;
                                                                    _updateProjectHours(projects[index]);
                                                                  })
                                                                },
                                                            child: Text("-0.5")),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            );
                                          })
                                    },
                                    icon: Icon(FontAwesomeIcons.adjust),
                                    label: Text(tr("hours")),
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  //status button
                                  child: ElevatedButton.icon(
                                    onPressed: () => {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SimpleDialog(
                                              //status dialog
                                              title: Row(
                                                children: [
                                                  Text("Status: " + projects[index].status),
                                                  IconButton(
                                                    onPressed: () => {Navigator.pop(context)},
                                                    icon: Icon(Icons.close),
                                                    color: Colors.red,
                                                  )
                                                ],
                                              ),
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.arrow_forward_ios,
                                                            color: Helpers().getColorBasedOnStatusText("Open")),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: ElevatedButton(
                                                            onPressed: () => {_updateProject("Open", projects[index])},
                                                            child: Text(tr("open")),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.arrow_forward_ios,
                                                            color: Helpers().getColorBasedOnStatusText("In Progress")),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: ElevatedButton(
                                                              onPressed: () =>
                                                                  {_updateProject("In Progress", projects[index])},
                                                              child: Text(tr("in-progress"))),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.arrow_forward_ios,
                                                            color: Helpers().getColorBasedOnStatusText("Ready")),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: ElevatedButton(
                                                              onPressed: () =>
                                                                  {_updateProject("Ready", projects[index])},
                                                              child: Text(tr("ready"))),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(Icons.arrow_forward_ios,
                                                            color: Helpers().getColorBasedOnStatusText("Closed")),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: ElevatedButton(
                                                              onPressed: () =>
                                                                  {_updateProject("Closed", projects[index])},
                                                              child: Text(tr("closed"))),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          })
                                    },
                                    icon: Icon(FontAwesomeIcons.bolt),
                                    label: Text("Status"),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
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

  _updateProject(String status, Project p) async {
    p.status = status;
    await FirestoreService().editProject(p);
    Navigator.pop(context);
    setState(() {});
  }

  _updateProjectHours(Project p) async {
    await FirestoreService().editProject(p);
  }

  _restructureProjectList(List<Project> projects) {
    List<Project> newList = [];
    for (var i = 0; i < projects.length; i++) {
      if (projects[i].status == "Open") {
        newList.add(projects[i]);
      }
    }
    for (var i = 0; i < projects.length; i++) {
      if (projects[i].status == "In Progress") {
        newList.add(projects[i]);
      }
    }
    for (var i = 0; i < projects.length; i++) {
      if (projects[i].status == "Ready") {
        newList.add(projects[i]);
      }
    }
    for (var i = 0; i < projects.length; i++) {
      if (projects[i].status == "Closed") {
        newList.add(projects[i]);
      }
    }
    return newList;
  }
}
