import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class CalendarDateObject {
  String type;
  String partType;
  String label;
  String startTimeStamp;
  String uid;
  String project;
  String customer;
  String fid;

  CalendarDateObject(
      {this.type = "",
      this.partType = "",
      this.label = "",
      this.startTimeStamp = "",
      this.project = "",
      this.uid = "",
      this.customer = "",
      this.fid = ""});
  factory CalendarDateObject.fromJson(Map<String, dynamic> json) => _$CalendarDateObjectFromJson(json);
  Map<String, dynamic> toJson() => _$CalendarDateObjectToJson(this);
}

@JsonSerializable()
class UserProfile {
  String uid;
  String fid;
  String firstname;
  String lastname;
  String street;
  String housenumber;
  String zipcode;
  String town;
  String companyName;
  String kvk;
  String btw;
  String email;
  String logoRef;

  UserProfile(
      {this.uid = '',
      this.fid = '',
      this.firstname = '',
      this.lastname = '',
      this.street = '',
      this.housenumber = '',
      this.zipcode = '',
      this.town = '',
      this.companyName = '',
      this.kvk = '',
      this.btw = '',
      this.email = '',
      this.logoRef = ''});
  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class Project {
  String customer;
  String fid;
  String label;
  String cause;
  String timeCreated;
  String timeCompleted;
  bool invoiceSend;
  String invoiceReminders;
  double hours;
  String status;

  Project({
    this.customer = '',
    this.fid = '',
    this.cause = '',
    this.label = '',
    this.timeCreated = '',
    this.timeCompleted = '',
    this.invoiceSend = false,
    this.invoiceReminders = '',
    this.hours = 0.0,
    this.status = '',
  });
  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}

@JsonSerializable()
class Customer {
  String fid;
  String firstname;
  String lastname;
  String uid;
  String email;
  String phone;
  String street;
  String housenumber;
  String zipcode;
  String town;
  String notes;

  Customer({
    this.fid = '',
    this.firstname = '',
    this.lastname = '',
    this.uid = '',
    this.email = '',
    this.phone = '',
    this.street = '',
    this.housenumber = '',
    this.zipcode = '',
    this.town = '',
    this.notes = '',
  });
  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
