import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepo {
  final String? uid;

  StorageRepo({this.uid});

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadPatientProfileImage(
      String filePath, String fileName) async {
    File file = File(filePath);
    final ref = storage.ref().child('patients').child('/$uid/');

    try {
      await ref.child('profilepic').putFile(file);
      return await ref.child('profilepic').getDownloadURL();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> uploadRiderDriverLicenseImage(
      File file, String fileName) async {
    final ref = storage.ref().child('riders').child('/$uid/');

    try {
      await ref.child('driver_license').putFile(file);
      return await ref.child('driver_license').getDownloadURL();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
