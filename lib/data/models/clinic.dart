import 'package:cloud_firestore/cloud_firestore.dart';

class Clinic {
  String clinicName;
  bool status;
  DocumentSnapshot? snapshot;
  DocumentReference? reference;
  String? documentID;

  Clinic({
    required this.clinicName,
    required this.status,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Clinic.fromFirestore(DocumentSnapshot snapshot) {
    //if (snapshot == null) return null;
    dynamic map = snapshot.data();

    return Clinic(
      clinicName: map['clinicName'],
      status: map['status'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Clinic.fromMap(Map<String, dynamic> map) {
    //if (map == null) return null;

    return Clinic(
      clinicName: map['clinicName'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() => {
        'clinicName': clinicName,
        'status': status,
      };

  Clinic copyWith({
    required String clinicName,
    required bool status,
  }) {
    return Clinic(
      clinicName: clinicName,
      status: status,
    );
  }

  @override
  String toString() {
    return '${clinicName.toString()}, ${status.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Clinic && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
