import 'package:carrypill/data/dataproviders/firebase_provider/auth_provider.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/models/patient_uid.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PatientUid? _patientFromFirebase(User? user) {
    return PatientUid(uid: user!.uid);
  }

  Stream<PatientUid?> get patient {
    return _auth.authStateChanges().map(_patientFromFirebase);
  }

  Future register(Patient patient, String email, String password) async {
    dynamic result =
        await AuthProvider().registerWithEmailAndPassword(email, password);

    if (result == null || result is String) {
      return result;
    } else {
      String uid = (result as UserCredential).user!.uid;
      await FirestoreRepo(uid: uid).updateAllPatientData(patient);
    }
  }

  Future login(String email, String password) async {
    dynamic result = AuthProvider().signInWithEmailAndPassword(email, password);
    if (result == null || result is String) {
      return result;
    } else {
      //todo  firestore
      return result;
    }
  }

  Future logout() async {
    dynamic result = AuthProvider().signOut();
    if (result == null || result is String) {
      return result;
    } else {
      //todo
    }
  }
}
