import 'package:carrypill/data/models/clinic.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PatientProvider with ChangeNotifier {
  Patient? patient;
  PatientProvider({
    this.patient,
  });

  void updatePatient(Patient patient) async {
    this.patient = patient;
    notifyListeners();
  }

  void updatePatientInfo(
      {required String name,
      required String patientId,
      required String icNum,
      required String phoneNum,
      required String address,
      GeoPoint? geoPoint}) async {
    patient?.name = name;
    patient?.patientId = patientId;
    patient?.icNum = icNum;
    patient?.phoneNum = phoneNum;
    patient?.address = address;
    notifyListeners();
  }

  void updateClinic(List<Clinic> clinicList) async {
    patient?.clinicList = clinicList;
    notifyListeners();
  }

  void updateAppointment(DateTime dateTime) async {
    patient?.appointment = dateTime;
    notifyListeners();
  }

  Future<void> updatePatientDB(String uid, {required Patient patient}) async {
    await FirestoreRepo(uid: uid).updateAllPatientData(patient);
    this.patient = patient;
    notifyListeners();
  }

  Future<void> updateAppointmentDB(DateTime dateTime, String uid) async {
    await FirestoreRepo(uid: uid).updateAppointment(dateTime);
    patient?.appointment = dateTime;
    notifyListeners();
  }

  Future<void> updateClinicDB(List<Clinic> clinicList, String uid) async {
    await FirestoreRepo(uid: uid).updateClinic(clinicList);
    patient?.clinicList = clinicList;
    notifyListeners();
  }

  Future<void> updateStatus(int index) async {
    patient?.clinicList[index].status = !patient!.clinicList[index].status;
    notifyListeners();
  }
}
