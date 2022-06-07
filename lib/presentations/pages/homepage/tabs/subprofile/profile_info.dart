import 'package:carrypill/business_logic/provider/patient_provider.dart';
import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/constants/constant_widget.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/models/patient_uid.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill/data/repositories/map_repo/location_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ProfileInfo extends StatefulWidget {
  Map<String, dynamic>? arg = {};
  ProfileInfo({Key? key, required this.arg}) : super(key: key);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late TextEditingController namecon; // = TextEditingController();
  late TextEditingController icNumcon; // = TextEditingController();
  late TextEditingController phoneNumcon; // = TextEditingController();
  late TextEditingController patientIdcon; // = TextEditingController();
  late TextEditingController addresscon; // = TextEditingController();

  FocusNode nodename = FocusNode();
  FocusNode nodeicNum = FocusNode();
  FocusNode nodephoneNum = FocusNode();
  FocusNode nodepatientId = FocusNode();
  FocusNode nodeaddress = FocusNode();

  List<bool> enabled = List.filled(5, false);

  @override
  void initState() {
    // TODO: implement initState
    print('init profile info');
    Patient? patient = widget.arg!['patient'];
    if (patient != null) {
      // print(patient.name);
      namecon = TextEditingController(text: patient.name);
      icNumcon = TextEditingController(text: patient.icNum);
      phoneNumcon = TextEditingController(text: patient.phoneNum);
      patientIdcon = patient.patientId != null
          ? TextEditingController(text: patient.patientId)
          : TextEditingController();
      addresscon = patient.address != null
          ? TextEditingController(text: patient.address)
          : TextEditingController();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PatientUid useraccount = Provider.of<PatientUid>(context);
    // var patientprovider = Provider.of<PatientProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Info'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              gaphr(),
              SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/profile.png',
                        height: 115,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: Material(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        elevation: 0,
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(50),
                          splashColor: Colors.grey.shade300.withOpacity(0.8),
                          highlightColor: Colors.grey.shade800.withOpacity(0.2),
                          child: Ink(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: kcWhite,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add_a_photo_rounded,
                                color: kcWhite,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              gaphr(),
              cardTextFieldDesign(namecon, 'Full Name', nodename,
                  'Insert full name as per IC', 0),
              gaphr(),
              cardTextFieldDesign(patientIdcon, 'Patient ID', nodepatientId,
                  'Insert patient ID', 1),
              gaphr(),
              cardTextFieldDesign(icNumcon, 'IC Number', nodeicNum,
                  'Insert IC number Ex: 123456789012', 2),
              gaphr(),
              cardTextFieldDesign(phoneNumcon, 'Phone Number', nodephoneNum,
                  'Insert phone number', 3),
              gaphr(),
              cardTextFieldDesign(
                  addresscon, 'Address', nodeaddress, 'Insert phone number', 4),
              gaphr(h: 30),
              MaterialButton(
                onPressed: () async {
                  // Patient patient = Patient(
                  //     name: namecon.text,
                  //     icNum: icNumcon.text,
                  //     phoneNum: phoneNumcon.text,
                  //     address: addresscon.text,
                  //     patientId: patientIdcon.text);
                  try {
                    GeoPoint geo;
                    if (addresscon.text.isEmpty) {
                      Position pos = await LocationRepo().getCurrentLocation();
                      geo = GeoPoint(pos.latitude, pos.longitude);
                    } else {
                      var addresses =
                          await locationFromAddress(addresscon.text);
                      print(addresses.first);
                      var address = addresses.first;
                      geo = GeoPoint(address.latitude, address.longitude);
                    }
                    Provider.of<PatientProvider>(context, listen: false)
                        .updatePatientInfo(
                            name: namecon.text,
                            icNum: icNumcon.text,
                            phoneNum: phoneNumcon.text,
                            address: addresscon.text,
                            patientId: patientIdcon.text,
                            geoPoint: geo);
                    //GeoPoint geoPoint = GeoPoint(pos.latitude, pos.longitude);
                    await FirestoreRepo(uid: useraccount.uid).updatePatientInfo(
                      name: namecon.text,
                      icNum: icNumcon.text,
                      phoneNum: phoneNumcon.text,
                      address: addresscon.text,
                      patientId: patientIdcon.text,
                      geoPoint: geo,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Update Saved'),
                      ),
                    );
                  } on Exception catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Update Failed due to error ${e.toString()}'),
                      ),
                    );
                  }
                },
                shape: cornerR(r: 8),
                height: 44.h,
                minWidth: double.infinity,
                color: kcPrimary,
                child: textBtn15('Update Profile Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardTextFieldDesign(TextEditingController controller, String label,
      FocusNode node, String hintText, int index) {
    return Card(
      shape: cornerR(),
      color: Colors.white,
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: node,
                style: enabled[index] ? kwstyleb16 : kwstyleHint16,
                controller: controller,
                enabled: enabled[index],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  floatingLabelStyle: kwtextStyleRD(
                    c: kcLabelColor,
                    fs: 16,
                    fw: FontWeight.w500,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: label,
                  labelStyle: kwtextStyleRD(
                    c: kcLabelColor,
                    fs: 16,
                    fw: FontWeight.w500,
                  ),
                  // hintText: hintText,
                  // hintStyle: kwstyleHint16,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  enabled[index] = !enabled[index];
                });
              },
              splashRadius: 24,
              iconSize: 24,
              icon: Icon(
                enabled[index] ? Icons.check_rounded : Icons.edit_rounded,
                size: 24,
                color: kcPrimary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
