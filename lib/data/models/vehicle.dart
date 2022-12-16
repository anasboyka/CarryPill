import 'package:cloud_firestore/cloud_firestore.dart';

class Vehicle {
  final String? vehiclePlateNum;
  final String? riderLicense;
  final String? vehicleBrand;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Vehicle({
    this.vehiclePlateNum,
    this.riderLicense,
    this.vehicleBrand,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Vehicle.fromFirestore(DocumentSnapshot snapshot) {
    dynamic map = snapshot.data();

    return Vehicle(
      vehiclePlateNum: map['vehiclePlateNum'],
      riderLicense: map['riderLicense'],
      vehicleBrand: map['vehicleBrand'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      vehiclePlateNum: map['vehiclePlateNum'],
      riderLicense: map['riderLicense'],
      vehicleBrand: map['vehicleBrand'],
    );
  }

  Map<String, dynamic> toMap() => {
        'vehiclePlateNum': vehiclePlateNum,
        'riderLicense': riderLicense,
        'vehicleBrand': vehicleBrand,
      };

  @override
  String toString() {
    return '${vehiclePlateNum.toString()}, ${riderLicense.toString()}, ${vehicleBrand.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Vehicle && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
