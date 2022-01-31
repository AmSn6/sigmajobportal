// To parse this JSON data, do
//
//     final contactTypeModel = contactTypeModelFromJson(jsonString);

import 'dart:convert';

ContactTypeModel contactTypeModelFromJson(String str) => ContactTypeModel.fromJson(json.decode(str));

String contactTypeModelToJson(ContactTypeModel data) => json.encode(data.toJson());

class ContactTypeModel {
  List<Contact> contact;

  ContactTypeModel({
    this.contact,
  });

  factory ContactTypeModel.fromJson(Map<String, dynamic> json) => ContactTypeModel(
    contact: json["contact"] == null ? null : List<Contact>.from(json["contact"].map((x) => Contact.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "contact": contact == null ? null : List<dynamic>.from(contact.map((x) => x.toJson())),
  };
}

class Contact {
  String contactNumberTypeId;
  String contactNumberTypeName;

  Contact({
    this.contactNumberTypeId,
    this.contactNumberTypeName,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    contactNumberTypeId: json["contact_number_type_id"] == null ? null : json["contact_number_type_id"],
    contactNumberTypeName: json["contact_number_type_name"] == null ? null : json["contact_number_type_name"],
  );

  Map<String, dynamic> toJson() => {
    "contact_number_type_id": contactNumberTypeId == null ? null : contactNumberTypeId,
    "contact_number_type_name": contactNumberTypeName == null ? null : contactNumberTypeName,
  };
}
