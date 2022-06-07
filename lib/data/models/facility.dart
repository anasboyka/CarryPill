import 'package:cloud_firestore/cloud_firestore.dart';

class Facility {
  final String facilityName;
  final GeoPoint geoPoint;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Facility({
    required this.facilityName,
    required this.geoPoint,
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
    );
  }

  Map<String, dynamic> toMap() => {
        'facilityName': facilityName,
        'geoPoint': geoPoint,
      };

  Facility copyWith({
    String? name,
    GeoPoint? geoPoint,
  }) {
    return Facility(
      facilityName: name ?? this.facilityName,
      geoPoint: geoPoint ?? this.geoPoint,
    );
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
