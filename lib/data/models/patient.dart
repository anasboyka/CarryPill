import 'dart:convert';

import 'package:carrypill/data/models/clinic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Patient {
  String name;
  String icNum;
  String phoneNum;
  String? patientId;
  String? address;
  List<Clinic> clinicList;
  DateTime? appointment;
  GeoPoint? geoPoint;
  DocumentSnapshot? snapshot;
  DocumentReference? reference;
  String? documentID;

  Patient({
    required this.name,
    required this.icNum,
    required this.phoneNum,
    this.patientId,
    this.address,
    this.clinicList = const [],
    this.appointment,
    this.geoPoint,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Patient.fromFirestore(DocumentSnapshot snapshot) {
    // if (snapshot == null) return null;
    dynamic map = snapshot.data();

    return Patient(
      name: map['name'],
      icNum: map['icNum'],
      phoneNum: map['phoneNum'],
      patientId: map['patientId'],
      address: map['address'],
      clinicList: map['clinicList'] != null
          ? map['clinicList']
              .map<Clinic>((mapString) => Clinic.fromMap(mapString))
              .toList()
          : [],
      appointment: map['appointment']?.toDate(),
      geoPoint: map['geoPoint'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    return Patient(
        name: map['name'],
        icNum: map['icNum'],
        phoneNum: map['phoneNum'],
        patientId: map['patientId'],
        address: map['address'],
        clinicList: map['clinicList'] != null
            ? List<Clinic>.from(map['clinicList'])
            : [],
        appointment: map['appointment']?.toDate(),
        geoPoint: map['geoPoint']);
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'icNum': icNum,
        'phoneNum': phoneNum,
        'patientId': patientId,
        'address': address,
        'clinicList': clinicList.map((e) => e.toMap()).toList(),
        'appointment': appointment,
        'geoPoint': geoPoint,
      };

  String toJson() => json.encode(toMap());

  factory Patient.fromJson(String source) =>
      Patient.fromMap(json.decode(source));

  Patient copyWith({
    required String name,
    required String icNum,
    required String phoneNum,
    required String patientId,
    required String address,
    required List<Clinic> clinicList,
    required DateTime appointment,
  }) {
    return Patient(
        name: name,
        icNum: icNum,
        phoneNum: phoneNum,
        patientId: patientId,
        address: address,
        clinicList: clinicList,
        appointment: appointment);
  }

  @override
  String toString() {
    return '${name.toString()}, ${icNum.toString()}, ${phoneNum.toString()}, ${patientId.toString()}, ${address.toString()}, ${clinicList.toString()}, ${appointment.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Patient && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
