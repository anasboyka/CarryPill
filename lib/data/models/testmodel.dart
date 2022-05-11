import 'dart:convert';

import 'package:carrypill/data/models/clinic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Testmodel {
  final String test1;
  final bool test2;
  final List<Clinic> clinicList;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Testmodel({
    required this.test1,
    required this.test2,
    required this.clinicList,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Testmodel.fromFirestore(DocumentSnapshot snapshot) {
    //if (snapshot == null) return null;
    dynamic map = snapshot.data();

    return Testmodel(
      test1: map['test1'],
      test2: map['test2'],
      clinicList: List<Clinic>.from(map['clinicList']),
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Testmodel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Testmodel(
      test1: map['test1'],
      test2: map['test2'],
      clinicList: List<Clinic>.from(map['clinicList']),
    );
  }

  Map<String, dynamic> toMap() => {
        'test1': test1,
        'test2': test2,
        'clinicList': clinicList,
      };

  Testmodel copyWith({
    required String test1,
    required bool test2,
    required List<Clinic> clinicList,
  }) {
    return Testmodel(
      test1: test1,
      test2: test2,
      clinicList: clinicList,
    );
  }

  String toJson() => json.encode(toMap());

  factory Testmodel.fromJson(String source) =>
      Testmodel.fromMap(json.decode(source));

  @override
  String toString() {
    return '${test1.toString()}, ${test2.toString()}, ${clinicList.toString()}, ';
  }

  @override
  bool operator ==(other) =>
      other is Testmodel && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
