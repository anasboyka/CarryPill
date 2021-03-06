import 'package:carrypill/data/models/all_enum.dart';
import 'package:carrypill/data/models/clinic.dart';
import 'package:carrypill/data/models/facility.dart';
import 'package:carrypill/data/models/order_service.dart';
import 'package:carrypill/data/models/patient.dart';
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

  //update doc
  Future updateAllPatientInfoData(Patient patient) async {
    return await patientCollection.doc(uid).set(patient.toMap());
  }

  Future updatePatientInfoData(String name, String patientId, String icNum,
      String phoneNum, String address, GeoPoint? geoPoint) async {
    return await patientCollection.doc(uid).update({
      'name': name,
      'phoneNum': phoneNum,
      'patientId': patientId,
      'address': address,
      'geoPoint': geoPoint,
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

  Future updateOrderCompleteDate(DateTime dateTime, String id) async {
    return await orderCollection.doc(id).update({
      'orderComplete': dateTime,
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

  List<OrderService> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => OrderService.fromFirestore(doc)).toList();
  }

  //down order
}
