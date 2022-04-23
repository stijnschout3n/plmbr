import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:plmbr/services/auth.dart';
import 'package:plmbr/services/models.dart';
import 'package:table_calendar/table_calendar.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Reads all documents from the customers collection
  Future<List<Customer>> getCustomersRelatedToUser() async {
    var ref = _db.collection('customers').where('uid', isEqualTo: AuthService().user!.uid.toString());
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var customers = data.map((d) => Customer.fromJson(d));
    return customers.toList();
  }

  /// Creates a new customer to the firestore database
  Future<void> addCustomer(Customer customer) async {
    DocumentReference doc = _db.collection('customers').doc();
    customer.fid = doc.id;
    doc.set(customer.toJson());
  }

  /// Edits an existing customer in the firestore database
  Future<void> editCustomer(Customer customer, {bool delete = false}) async {
    if (delete) {
      _db.collection('customers').doc(customer.fid).delete();
    } else {
      _db.collection('customers').doc(customer.fid).set(customer.toJson());
    }
  }

  /// Save a project to the firestore database
  Future<void> saveProject(Project project) async {
    _db.collection('projects').doc(project.fid).set(project.toJson());
  }

  /// Adds and returns a new project
  Future<Project> addProject() async {
    Project project = Project();
    DocumentReference doc = _db.collection('projects').doc();
    project.fid = doc.id;
    return project;
  }

  /// Reads all documents from the customers collection
  Future<List<Project>> getProjectsRelatedToCustomer(Customer customer) async {
    var ref = _db.collection('projects').where('customer', isEqualTo: customer.fid);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var projects = data.map((d) => Project.fromJson(d));
    return projects.toList();
  }

  /// Streams a project object
  Stream<Project> streamProject(Project project) {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('projects').doc(project.fid);
        return ref.snapshots().map((doc) => Project.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Project()]);
      }
    });
  }

  /// Fetches appointments of current user
  Future<List<CalendarDateObject>> getAppointmentsRelatedToUser() async {
    var ref = _db.collection('dates').where('uid', isEqualTo: AuthService().user!.uid.toString());
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var appointments = data.map((d) => CalendarDateObject.fromJson(d));
    return appointments.toList();
  }

  Future<void> saveAppointments(List<CalendarDateObject> appointments) async {
    var user = AuthService().user!.uid.toString();
    for (var i = 0; i < appointments.length; i++) {
      DocumentReference doc = _db.collection('dates').doc();
      appointments[i].fid = doc.id;
      appointments[i].uid = user;
      doc.set(appointments[i].toJson());
    }
  }
}
