import 'package:carrypill/business_logic/provider/patient_provider.dart';
import 'package:carrypill/constants/constant_widget.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/models/patient_uid.dart';
import 'package:carrypill/data/repositories/firebase_repo/auth_repo.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:provider/provider.dart';

import 'authenticate/authenticate.dart';
import 'homepage/homepage.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  //bool alreadyLogin = true;

  @override
  Widget build(BuildContext context) {
    final patientuid = Provider.of<PatientUid?>(context);
    if (patientuid != null) {
      // AuthRepo().logout();
      return StreamBuilder(
          stream: FirestoreRepo(uid: patientuid.uid).streamPatient,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Patient patient = snapshot.data;
              // Provider.of<PatientProvider>(context)
              //     .updatePatient(patient);

              return HomePage(patient: patient);
            } else {
              return Scaffold(
                body: Center(
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Center(
                      child: loadingPillriveR(100),
                    ),
                  ),
                ),
              );
            }
          });
    } else {
      return const Authenticate();
    }
  }
}
