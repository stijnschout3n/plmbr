// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarDateObject _$CalendarDateObjectFromJson(Map<String, dynamic> json) =>
    CalendarDateObject(
      type: json['type'] as String? ?? "",
      partType: json['partType'] as String? ?? "",
      label: json['label'] as String? ?? "",
      startTimeStamp: json['startTimeStamp'] as String? ?? "",
      project: json['project'] as String? ?? "",
      uid: json['uid'] as String? ?? "",
      customer: json['customer'] as String? ?? "",
      fid: json['fid'] as String? ?? "",
    );

Map<String, dynamic> _$CalendarDateObjectToJson(CalendarDateObject instance) =>
    <String, dynamic>{
      'type': instance.type,
      'partType': instance.partType,
      'label': instance.label,
      'startTimeStamp': instance.startTimeStamp,
      'uid': instance.uid,
      'project': instance.project,
      'customer': instance.customer,
      'fid': instance.fid,
    };

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      uid: json['uid'] as String? ?? '',
      fid: json['fid'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      street: json['street'] as String? ?? '',
      housenumber: json['housenumber'] as String? ?? '',
      zipcode: json['zipcode'] as String? ?? '',
      town: json['town'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      kvk: json['kvk'] as String? ?? '',
      btw: json['btw'] as String? ?? '',
      email: json['email'] as String? ?? '',
      logoRef: json['logoRef'] as String? ?? '',
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'fid': instance.fid,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'street': instance.street,
      'housenumber': instance.housenumber,
      'zipcode': instance.zipcode,
      'town': instance.town,
      'companyName': instance.companyName,
      'kvk': instance.kvk,
      'btw': instance.btw,
      'email': instance.email,
      'logoRef': instance.logoRef,
    };

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      customer: json['customer'] as String? ?? '',
      fid: json['fid'] as String? ?? '',
      cause: json['cause'] as String? ?? '',
      label: json['label'] as String? ?? '',
      timeCreated: json['timeCreated'] as String? ?? '',
      timeCompleted: json['timeCompleted'] as String? ?? '',
      invoiceSend: json['invoiceSend'] as bool? ?? false,
      invoiceReminders: json['invoiceReminders'] as String? ?? '',
      hours: (json['hours'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'customer': instance.customer,
      'fid': instance.fid,
      'label': instance.label,
      'cause': instance.cause,
      'timeCreated': instance.timeCreated,
      'timeCompleted': instance.timeCompleted,
      'invoiceSend': instance.invoiceSend,
      'invoiceReminders': instance.invoiceReminders,
      'hours': instance.hours,
      'status': instance.status,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      fid: json['fid'] as String? ?? '',
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      street: json['street'] as String? ?? '',
      housenumber: json['housenumber'] as String? ?? '',
      zipcode: json['zipcode'] as String? ?? '',
      town: json['town'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'fid': instance.fid,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'uid': instance.uid,
      'email': instance.email,
      'phone': instance.phone,
      'street': instance.street,
      'housenumber': instance.housenumber,
      'zipcode': instance.zipcode,
      'town': instance.town,
      'notes': instance.notes,
    };
