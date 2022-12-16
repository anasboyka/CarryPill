import 'package:cloud_firestore/cloud_firestore.dart';

class IcCard {
  final String? icFrontImageUrl;
  final String? icBackImageUrl;
  final String? icNumber;
  final String? address;
  final String? race;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  IcCard({
    this.icFrontImageUrl,
    this.icBackImageUrl,
    this.icNumber,
    this.address,
    this.race,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory IcCard.fromFirestore(DocumentSnapshot snapshot) {
    dynamic map = snapshot.data();

    return IcCard(
      icFrontImageUrl: map['icFrontImageUrl'],
      icBackImageUrl: map['icBackImageUrl'],
      icNumber: map['icNumber'],
      address: map['address'],
      race: map['race'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  Map<String, dynamic> toMap() => {
        'icFrontImageUrl': icFrontImageUrl,
        'icBackImageUrl': icBackImageUrl,
        'icNumber': icNumber,
        'address': address,
        'race': race,
      };

  @override
  String toString() {
    return '${icFrontImageUrl.toString()}, ${icBackImageUrl.toString()}, ${icNumber.toString()}, ${address.toString()}, ${race.toString()}, ';
  }

  @override
  bool operator ==(other) => other is IcCard && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
