import 'package:carrypill/data/models/icCard.dart';
import 'package:carrypill/data/models/license.dart';
import 'package:carrypill/data/models/profile.dart';
import 'package:carrypill/data/models/vehicle.dart';
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
  final String? currentOrderId;
  final DateTime? startWorkingDate;
  final List<String>? orderCancelId;
  final Profile? profile;
  // final IcCard? icCard;
  // final License? license;
  final Vehicle? vehicle;
  // final String? profileImageUrl;
  // final DateTime? birthDate;
  // String? gender;
  // final String? icFrontImageUrl;
  // final String? icBackImageUrl;
  // final String? icNumber;
  // final String? address;
  // final String? race;
  // final DateTime? licenseExpirationDate;
  // final String? licenseClass;
  // final String? licenseType;
  // final String? licenseImageUrl;
  // final String? vehiclePlateNum;
  // final String? vehicleRoadTaxImageUrl;
  final double earning;
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
    this.currentOrderId,
    this.orderCancelId,
    this.profile,
    // this.icCard,
    // this.license,
    this.vehicle,
    // this.profileImageUrl,
    // this.birthDate,
    // this.gender,
    // this.icCard,
    // this.icFrontImageUrl,
    // this.icBackImageUrl,
    // this.icNumber,
    // this.address,
    // this.race,
    // this.licenseExpirationDate,
    // this.licenseClass,
    // this.licenseType,
    // this.licenseImageUrl,
    // this.vehiclePlateNum,
    // this.vehicle
    // vehicleRoadTaxImageUrl
    this.earning = 0,
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
      currentOrderId: map['currentOrderId'],
      orderCancelId:
          map['orderCancelId'] != null ? List.from(map['orderCancelId']) : null,
      profile: map['profile'] != null ? Profile.fromMap(map['profile']) : null,
      vehicle: map['vehicle'] != null ? Vehicle.fromMap(map['vehicle']) : null,
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
        'currentOrderId': currentOrderId,
        'orderCancelId': orderCancelId,
        'profile': profile != null ? profile!.toMap() : null,
        'vehicle': vehicle != null ? vehicle!.toMap() : null,
      };

  @override
  String toString() {
    return '${firstName.toString()}, ${lastName.toString()}, ${phoneNum.toString()}, ${vehicleType.toString()}, ${workingStatus.toString()}, ${isWorking.toString()}, ${currrentLocation.toString()}, ';
  }

  @override
  bool operator ==(other) => other is Rider && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
