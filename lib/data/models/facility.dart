import 'package:cloud_firestore/cloud_firestore.dart';

class Facility {
  final String facilityName;
  final GeoPoint geoPoint;
  final String fullAddress;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Facility({
    required this.facilityName,
    required this.geoPoint,
    required this.fullAddress,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Facility.fromFirestore(DocumentSnapshot snapshot) {
    // if (snapshot == null) return null;
    dynamic map = snapshot.data();

    return Facility(
      facilityName: map['facilityName'],
      geoPoint: map['geoPoint'],
      fullAddress: map['fullAddress'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Facility.fromMap(Map<String, dynamic> map) {
    //if (map == null) return null;

    return Facility(
      facilityName: map['facilityName'],
      geoPoint: map['geoPoint'],
      fullAddress: map['fullAddress'],
    );
  }

  Map<String, dynamic> toMap() => {
        'facilityName': facilityName,
        'geoPoint': geoPoint,
        'fullAddress': fullAddress,
      };

  Facility copyWith({
    String? facilityName,
    GeoPoint? geoPoint,
    String? fullAddress,
  }) {
    return Facility(
        facilityName: facilityName ?? this.facilityName,
        geoPoint: geoPoint ?? this.geoPoint,
        fullAddress: fullAddress ?? this.fullAddress);
  }

  @override
  String toString() {
    return '${facilityName.toString()}, ${geoPoint.toString()}, ';
  }

  @override
  bool operator ==(other) =>
      other is Facility && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
