import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  final String? profileImageUrl;
  final DateTime? birthDate;
  final String? gender;
  final String? icNum;
  final String? address;
  final String? race;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Profile({
    this.profileImageUrl,
    this.birthDate,
    this.gender,
    this.icNum,
    this.address,
    this.race,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Profile.fromFirestore(DocumentSnapshot snapshot) {
    dynamic map = snapshot.data();

    return Profile(
      profileImageUrl: map['profileImageUrl'],
      birthDate: map['birthDate']?.toDate(),
      gender: map['gender'],
      icNum: map['icNum'],
      address: map['address'],
      race: map['race'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      profileImageUrl: map['profileImageUrl'],
      birthDate: map['birthDate']?.toDate(),
      gender: map['gender'],
      icNum: map['icNum'],
      address: map['address'],
      race: map['race'],
    );
  }

  Map<String, dynamic> toMap() => {
        'profileImageUrl': profileImageUrl,
        'birthDate': birthDate,
        'gender': gender,
        'icNum': icNum,
        'address': address,
        'race': race,
      };

  // Profile copyWith({
  //   String? profileImageUrl,
  //   DateTime? birthDate,
  //   String? gender,
  // }) {
  //   return Profile(
  //     profileImageUrl: profileImageUrl ?? this.profileImageUrl,
  //     birthDate: birthDate ?? this.birthDate,
  //     gender: gender ?? this.gender,
  //   );
  // }

  @override
  String toString() {
    return '${profileImageUrl.toString()}, ${birthDate.toString()}, ${gender.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Profile && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
