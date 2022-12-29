import 'package:carrypill/data/models/all_enum.dart';
import 'package:carrypill/data/models/clinic.dart';
import 'package:carrypill/data/models/facility.dart';
import 'package:carrypill/data/models/order_service.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/models/rider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  final String? uid;
  FirestoreProvider({this.uid});

  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patients');

  final CollectionReference followUpClinicCollection =
      FirebaseFirestore.instance.collection('followupclinics');

  final CollectionReference facilityCollection =
      FirebaseFirestore.instance.collection('healthcare_facilities');

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orders');

  final CollectionReference riderCollection =
      FirebaseFirestore.instance.collection('riders');

  //update doc
  Future updateAllPatientInfoData(Patient patient) async {
    return await patientCollection.doc(uid).set(patient.toMap());
  }

  Future updatePatientInfoData(
      String name,
      String patientId,
      String icNum,
      String phoneNum,
      String address,
      GeoPoint? geoPoint,
      String? profileImageUrl) async {
    return await patientCollection.doc(uid).update({
      'name': name,
      'phoneNum': phoneNum,
      'patientId': patientId,
      'address': address,
      'geoPoint': geoPoint,
      'profileImageUrl': profileImageUrl,
    });
  }

  //update field
  Future updatePatientAppointmentDate(DateTime appointment) async {
    return await patientCollection.doc(uid).update({
      'appointment': appointment,
    });
  }

  Future updateClinicList(List<Clinic> clinicList) async {
    return await patientCollection.doc(uid).update({
      'clinicList': clinicList.map((e) => e.toMap()).toList(),
    });
  }

  //read data stream
  Stream<Patient?> get streamPatientInfoData {
    return patientCollection
        .doc(uid)
        .snapshots()
        .map((doc) => Patient.fromFirestore(doc));
  }

  //read data future
  Future<Patient?> get futurePatientInfoData {
    return patientCollection
        .doc(uid)
        .get()
        .then((doc) => Patient.fromFirestore(doc));
  }

  //up clinic

  //add clinic
  Future addFollowUpClinic(Clinic clinic) async {
    await followUpClinicCollection.add(clinic.toMap());
  }

  //down clinic

  //up facility

  Future addFacility(Facility facility) async {
    await facilityCollection.add(facility.toMap());
  }

  List<Facility> _facilityListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Facility.fromFirestore(doc);
    }).toList();
  }

  Future<List<Facility>> get facilityList async {
    return await facilityCollection.get().then(_facilityListFromSnapshot);
  }

  //down facility

  //up order

  Future addOrderService(OrderService orderService) async {
    return await orderCollection.add(orderService.toMap());
  }

  Future updateOrderStatus(StatusOrder statusOrder, String id) async {
    return await orderCollection.doc(id).update({
      'statusOrder': statusOrder.name,
    });
  }

  Future updateRiderPending(String riderId, String orderId) async {
    await riderCollection.doc(riderId).update({
      'workingStatus': 'Pending',
      'currentOrderId': orderId,
    });
    await orderCollection.doc(orderId).update({
      'riderPending': true,
    });
  }

  Future updateOrderDateComplete(DateTime dateTime, String id) async {
    return await orderCollection.doc(id).update({
      'orderDateComplete': dateTime,
    });
  }

  Future<OrderService> getOrderService() async {
    return await orderCollection
        .where('patientRef', isEqualTo: uid)
        .orderBy('orderDate', descending: true)
        .limit(1)
        .get()
        .then((data) => OrderService.fromFirestore(data.docs.first));
  }

//in progress
  // Future<Rider> getRider() async {
  //   return await riderCollection
  //       .where('currentCustomerId', isEqualTo: uid)
  //       .limit(1)
  //       .get()
  //       .then(
  //         (data) => Rider.fromFirestore(data.docs.first),
  //       );
  // }

  Future updateOrderQueryStatus(String orderQueryStatus, String orderId) async {
    return await orderCollection.doc(orderId).update({
      'orderQueryStatus': orderQueryStatus,
    });
  }

  // Future updateRiderPending() async {
  //   return await riderCollection.doc(uid).update({'workingStatus': 'Pending'});
  // }

  Future updateRiderWorkingStatus(String status) async {
    return await riderCollection.doc(uid).update({'workingStatus': status});
  }

  Stream<OrderService> streamUserCurrentOrder({bool descending = true}) {
    var snap = orderCollection
        .where('patientRef', isEqualTo: uid)
        .orderBy('orderDate', descending: descending)
        .limit(1)
        .snapshots();
    return snap.map((event) => OrderService.fromFirestore(event.docs.first));
  }

  Stream<List<OrderService>> getOrderListStream(bool descending) {
    return orderCollection
        .where('patientRef', isEqualTo: uid)
        .orderBy('orderDate', descending: descending)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<OrderService>> getOrderListStreamDelivery(bool descending) {
    return orderCollection
        .where('patientRef', isEqualTo: uid)
        .where('serviceType', isEqualTo: 'requestDelivery')
        .orderBy('orderDate', descending: descending)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  Stream<List<OrderService>> getOrderListStreamPickup(bool descending) {
    return orderCollection
        .where('patientRef', isEqualTo: uid)
        .where('serviceType', isEqualTo: 'requestPickup')
        .orderBy('orderDate', descending: descending)
        .snapshots()
        .map(_orderListFromSnapshot);
  }

  List<OrderService> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => OrderService.fromFirestore(doc)).toList();
  }

  //down order

  //up rider

  Future getCurrentRider(String riderId) async {
    return riderCollection
        .doc(riderId)
        .get()
        .then((doc) => Rider.fromFirestore(doc));
  }

  Stream<Rider?> getCurrentRiderStream(String riderId) {
    return riderCollection
        .doc(riderId)
        .snapshots()
        .map((doc) => Rider.fromFirestore(doc));
  }

  Stream<Rider> getRiderAvailable(bool descending) {
    var snap = riderCollection
        .where('workingStatus', isEqualTo: 'isWaitingForOrder')
        .orderBy('startWorkingDate', descending: descending)
        .limit(1)
        .snapshots();
    return snap.map((event) {
      // print('debugggggggggg');
      // print(Rider.fromFirestore(event.docs.first).toString());
      return Rider.fromFirestore(event.docs.first);
    });
  }

  Stream<Rider> getRiderPendingStatus(String riderId) {
    var snap = riderCollection.doc(riderId).snapshots();
    return snap.map((event) => Rider.fromFirestore(event));
  }

  Stream<List<Rider>?> getRiderListAvailableStream(bool descending) {
    return riderCollection
        .where('workingStatus', isEqualTo: 'isWaitingForOrder')
        .orderBy('startWorkingDate', descending: descending)
        .snapshots()
        .map(_riderListFromSnapshot);
  }

  List<Rider> _riderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Rider.fromFirestore(doc)).toList();
  }
  //down rider
}
