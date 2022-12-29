import 'package:carrypill/data/dataproviders/firebase_provider/firestore_provider.dart';
import 'package:carrypill/data/models/all_enum.dart';
import 'package:carrypill/data/models/clinic.dart';
import 'package:carrypill/data/models/facility.dart';
import 'package:carrypill/data/models/order_service.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/models/rider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreRepo {
  final String? uid;
  FirestoreRepo({
    this.uid,
  });

  //update
  Future updateAllPatientData(Patient patient) async {
    await FirestoreProvider(uid: uid).updateAllPatientInfoData(patient);
  }

  Future updatePatientInfo(
      {required String name,
      required String patientId,
      required String icNum,
      required String phoneNum,
      required String address,
      GeoPoint? geoPoint,
      String? profileImageUrl}) async {
    await FirestoreProvider(uid: uid).updatePatientInfoData(
        name, patientId, icNum, phoneNum, address, geoPoint, profileImageUrl);
  }

  //update field
  Future updateAppointment(DateTime dateTime) async {
    await FirestoreProvider(uid: uid).updatePatientAppointmentDate(dateTime);
  }

  Future updateClinic(List<Clinic> clinicList) async {
    await FirestoreProvider(uid: uid).updateClinicList(clinicList);
  }

  //read stream
  Stream<Patient?> get streamPatient {
    return FirestoreProvider(uid: uid).streamPatientInfoData;
  }

  //read future
  Future<Patient?> get futurePatient {
    return FirestoreProvider(uid: uid).futurePatientInfoData;
  }

  //up clinic
  Future addClinic(Clinic clinic) async {
    return FirestoreProvider(uid: uid).addFollowUpClinic(clinic);
  }
  //down clinic

  //up facility
  Future<List<Facility>> get facilityList async {
    return await FirestoreProvider().facilityList;
  }
  //down facility

  //up order
  Future addOrder(OrderService orderService) async {
    return await FirestoreProvider().addOrderService(orderService);
  }

  Future updateStatusOrder(StatusOrder statusOrder, String orderId) async {
    return await FirestoreProvider().updateOrderStatus(statusOrder, orderId);
  }

  Future updateOrderDateComplete(DateTime dateTime, String id) async {
    return await FirestoreProvider().updateOrderDateComplete(dateTime, id);
  }

  Future getOrderService() async {
    return await FirestoreProvider(uid: uid).getOrderService();
  }

  Future updateOrderQueryStatus(String orderQueryStatus, String orderId) async {
    return await FirestoreProvider()
        .updateOrderQueryStatus(orderQueryStatus, orderId);
  }

  Stream<OrderService> streamCurrentOrder({bool descending = true}) {
    return FirestoreProvider().streamUserCurrentOrder(descending: descending);
  }

  Stream<List<OrderService>> streamListOrder({bool descending = true}) {
    return FirestoreProvider(uid: uid).getOrderListStream(descending);
  }

  Stream<List<OrderService>> streamListOrderDelivery({bool descending = true}) {
    return FirestoreProvider(uid: uid).getOrderListStreamDelivery(descending);
  }

  Stream<List<OrderService>> streamListOrderPickup({bool descending = true}) {
    return FirestoreProvider(uid: uid).getOrderListStreamPickup(descending);
  }

  //down order

  //up rider

  Future getRider(String riderId) async {
    return await FirestoreProvider().getCurrentRider(riderId);
  }

  Stream<Rider?> getRiderStream(String riderId) {
    return FirestoreProvider().getCurrentRiderStream(riderId);
  }

  Future updateRiderPending(String riderId, String orderId) async {
    return await FirestoreProvider(uid: uid)
        .updateRiderPending(riderId, orderId);
  }

  Future updateRiderWorkingStatus(String status) async {
    return await FirestoreProvider(uid: uid).updateRiderWorkingStatus(status);
  }

  Stream<Rider> streamRiderPendingStatus(String riderId) {
    return FirestoreProvider().getRiderPendingStatus(riderId);
  }

  Stream<Rider> streamFindRiderAvailable({bool descending = true}) {
    return FirestoreProvider().getRiderAvailable(descending);
  }

  Stream<List<Rider>?> streamFindRidersAvailable({bool descending = true}) {
    return FirestoreProvider().getRiderListAvailableStream(descending);
  }

  //down rider
}
