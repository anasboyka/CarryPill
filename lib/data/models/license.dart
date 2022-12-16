import 'package:cloud_firestore/cloud_firestore.dart';

class License {
  final DateTime? licenseExpirationDate;
  final String? licenseClass;
  final String? licenseType;
  final String? licenseImageUrl;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  License({
    this.licenseExpirationDate,
    this.licenseClass,
    this.licenseType,
    this.licenseImageUrl,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory License.fromFirestore(DocumentSnapshot snapshot) {
    dynamic map = snapshot.data();

    return License(
      licenseExpirationDate: map['licenseExpirationDate'],
      licenseClass: map['licenseClass'],
      licenseType: map['licenseType'],
      licenseImageUrl: map['licenseImageUrl'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory License.fromMap(Map<String, dynamic> map) {
    return License(
      licenseExpirationDate: map['licenseExpirationDate'],
      licenseClass: map['licenseClass'],
      licenseType: map['licenseType'],
      licenseImageUrl: map['licenseImageUrl'],
    );
  }

  Map<String, dynamic> toMap() => {
        'licenseExpirationDate': licenseExpirationDate,
        'licenseClass': licenseClass,
        'licenseType': licenseType,
        'licenseImageUrl': licenseImageUrl,
      };

  @override
  String toString() {
    return '${licenseExpirationDate.toString()}, ${licenseClass.toString()}, ${licenseType.toString()}, ${licenseImageUrl.toString()}, ';
  }

  @override
  bool operator ==(other) => other is License && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
