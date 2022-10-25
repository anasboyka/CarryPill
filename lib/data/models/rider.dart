import 'package:cloud_firestore/cloud_firestore.dart';

class Rider {
  final String firstName;
  final String lastName;
  final String phoneNum;
  final String vehicleType;
  final String workingStatus;
  final bool isWorking;
  final bool autoAccept;
  final GeoPoint? currrentLocation;
  final bool? isProfileComplete;
  final String? currentCustomerId;
  final DateTime? startWorkingDate;
  final List<String>? orderCancelId;
  final DocumentSnapshot? snapshot;
  final DocumentReference? reference;
  final String? documentID;

  Rider({
    required this.firstName,
    required this.lastName,
    required this.phoneNum,
    required this.vehicleType,
    required this.workingStatus,
    required this.isWorking,
    required this.autoAccept,
    this.currrentLocation,
    this.isProfileComplete,
    this.startWorkingDate,
    this.currentCustomerId,
    this.orderCancelId,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory Rider.fromFirestore(DocumentSnapshot snapshot) {
    dynamic map = snapshot.data();
    return Rider(
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNum: map['phoneNum'],
      vehicleType: map['vehicleType'],
      workingStatus: map['workingStatus'],
      isWorking: map['isWorking'],
      autoAccept: map['autoAccept'],
      currrentLocation: map['currrentLocation'],
      isProfileComplete: map['isProfileComplete'],
      startWorkingDate: map['startWorkingDate'],
      currentCustomerId: map['currentCustomerId'],
      orderCancelId:
          map['orderCancelId'] != null ? List.from(map['orderCancelId']) : null,
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  // factory Rider.fromMap(Map<String, dynamic> map) {
  //   return Rider(
  //     firstName: map['firstName'],
  //     lastName: map['lastName'],
  //     phoneNum: map['phoneNum'],
  //     vehicleType: map['vehicleType'],
  //     workingStatus: map['workingStatus'],
  //     isWorking: map['isWorking'],
  //     currrentLocation: map['currrentLocation'],
  //   );
  // }

  Map<String, dynamic> toMap() => {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNum': phoneNum,
        'vehicleType': vehicleType,
        'workingStatus': workingStatus,
        'isWorking': isWorking,
        'currrentLocation': currrentLocation,
        'isProfileComplete': isProfileComplete,
        'autoAccept': autoAccept,
        'startWorkingDate': startWorkingDate,
        'currentCustomerId': currentCustomerId,
        'orderCancelId': orderCancelId,
      };

  @override
  String toString() {
    return '${firstName.toString()}, ${lastName.toString()}, ${phoneNum.toString()}, ${vehicleType.toString()}, ${workingStatus.toString()}, ${isWorking.toString()}, ${currrentLocation.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Rider && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
