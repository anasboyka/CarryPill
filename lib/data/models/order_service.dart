import 'package:carrypill/data/models/clinic.dart';
import 'package:carrypill/data/models/all_enum.dart';
import 'package:carrypill/data/models/facility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderService {
  //List<Clinic> clinicList;
  Facility? facility;
  StatusOrder statusOrder;
  ServiceType? serviceType;
  PaymentMethod? paymentMethod;
  double totalPay;
  DateTime? orderDate;
  DateTime? orderDateComplete;
  String? orderQueryStatus;
  String? patientRef;
  String? riderRef;
  DocumentSnapshot? snapshot;
  DocumentReference? reference;
  String? documentID;

  OrderService({
    //required this.clinicList,
    this.statusOrder = StatusOrder.noOrder,
    this.serviceType,
    this.paymentMethod,
    this.totalPay = 0,
    this.orderDate,
    this.orderDateComplete,
    this.orderQueryStatus,
    this.patientRef,
    this.riderRef,
    this.snapshot,
    this.reference,
    this.documentID,
  });

  factory OrderService.fromFirestore(DocumentSnapshot snapshot) {
// if(snapshot == null) return null;
    dynamic map = snapshot.data();

    return OrderService(
      // clinicList:
      //     map['clinicList'] != null ? List<Clinic>.from(map['clinicList']) : [],
      statusOrder: map['statusOrder'] != null
          ? StatusOrder.values.byName(map['statusOrder'])
          : StatusOrder.noOrder,
      serviceType: map['serviceType'] != null
          ? ServiceType.values.byName(map['serviceType'])
          : null,
      paymentMethod: map['paymentType'] != null
          ? PaymentMethod.values.byName(map['paymentType'])
          : null,
      totalPay: map['totalPay'],
      orderDate: map['orderDate']?.toDate(),
      orderDateComplete: map['orderDateComplete']?.toDate(),
      orderQueryStatus: map['orderQueryStatus'],
      patientRef: map['patientRef'],
      riderRef: map['riderRef'],
      snapshot: snapshot,
      reference: snapshot.reference,
      documentID: snapshot.id,
    );
  }

  factory OrderService.fromMap(Map<String, dynamic> map) {
    return OrderService(
      // clinicList: map['clinicList'] != null
      //     ? map['clinicList']
      //         .map<Clinic>((mapString) => Clinic.fromMap(mapString))
      //         .toList()
      //     : [],
      statusOrder: map['statusOrder'] != null
          ? StatusOrder.values.byName(map['statusOrder'])
          : StatusOrder.noOrder,
      serviceType: map['serviceType'] != null
          ? ServiceType.values.byName(map['serviceType'])
          : null,
      paymentMethod: map['paymentMethod'] != null
          ? PaymentMethod.values.byName(map['paymentMethod'])
          : null,
      totalPay: map['totalPay'],
      orderDate: (map['orderDate']?.toDate()),
      orderDateComplete: map['orderDateComplete']?.toDate(),
      orderQueryStatus: map['orderQueryStatus'],
      patientRef: map['patientRef'],
      riderRef: map['riderRef'],
    );
  }

  Map<String, dynamic> toMap() => {
        // 'clinicList': clinicList.map((e) => e.toMap()).toList(),
        'statusOrder': statusOrder.name,
        'serviceType': serviceType?.name,
        'paymentMethod': paymentMethod?.name,
        'totalPay': totalPay,
        'orderDate': orderDate,
        'orderDateComplete': orderDateComplete,
        'orderQueryStatus': orderQueryStatus,
        'patientRef': patientRef,
        'riderRef': riderRef,
      };

  // OrderService copyWith({
  //   required final List<Clinic> clinicList,
  //   final StatusOrder? statusOrder,
  //   final ServiceType? serviceType,
  //   final PaymentMethod? paymentMethod,
  //   final double? totalPay,
  //   final DateTime? orderDate,
  //   final DateTime? orderDateComplete,
  //   final DateTime? appointment,
  //   final String? patientRef,
  // }) {
  //   return OrderService(
  //     // clinicList: clinicList,
  //     statusOrder: statusOrder ?? this.statusOrder,
  //     serviceType: serviceType ?? this.serviceType,
  //     paymentMethod: paymentMethod ?? this.paymentMethod,
  //     totalPay: totalPay ?? this.totalPay,
  //     orderDate: orderDate ?? this.orderDate,
  //     orderDateComplete: orderDateComplete ?? this.orderDateComplete,
  //     patientRef: patientRef ?? this.patientRef,
  //     // appointment: appointment ?? this.appointment,
  //   );
  // }

  @override
  String toString() {
    return '{clinicList.toString()}, ${statusOrder.toString()}, ${orderDate.toString()}, ${orderDateComplete.toString()},${totalPay.toString()},${paymentMethod.toString()},${orderDate.toString()},${serviceType.toString()},${patientRef.toString()} ';
  }

  @override
  bool operator ==(other) =>
      other is OrderService && documentID == other.documentID;

  int get hashCode => documentID.hashCode;
}
