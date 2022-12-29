import 'dart:io';

import 'package:carrypill/business_logic/provider/patient_provider.dart';
import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/constants/constant_widget.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/models/patient_uid.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill/data/repositories/firebase_repo/storage_repo.dart';
import 'package:carrypill/data/repositories/map_repo/location_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:image/image.dart' as img;

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
  String? filePath, fileName;
  File? file;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    // print('init profile info');
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
    Patient? patient = widget.arg!['patient'];
    return Stack(
      children: [
        Scaffold(
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
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 2.0,
                                ),
                              ],
                              image: DecorationImage(
                                  image: patient?.profileImageUrl != null &&
                                          file == null
                                      ? NetworkImage(patient!.profileImageUrl!)
                                      : file != null
                                          ? FileImage(file!)
                                          : const AssetImage(
                                                  'assets/images/profile.png')
                                              as ImageProvider)),
                          // child: file != null
                          //     ? Image.file(file!)
                          //     : Image.asset(
                          //         'assets/images/profile.png',
                          //         height: 115,
                          //       ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Material(
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            elevation: 0,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });
                                final results =
                                    await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.image,
                                  // type: FileType.custom,
                                  // allowedExtensions: ['jpg', 'png', 'jpeg'],
                                  // allowCompression: true,
                                );

                                if (results != null) {
                                  // final path = results.path;
                                  final path = results.files.single.path!;
                                  File pickedfile = File(path);
                                  Image(image: FileImage(pickedfile))
                                      .image
                                      .resolve(const ImageConfiguration())
                                      .addListener(
                                    ImageStreamListener(
                                      (ImageInfo info, bool syncCall) {
                                        int width = info.image.width;
                                        int height = info.image.height;
                                        print(width);
                                        print(height);
                                      },
                                    ),
                                  );
                                  final img.Image? image = img.decodeImage(
                                      await File(path).readAsBytes());
                                  final img.Image orientedImage =
                                      img.bakeOrientation(image!);
                                  File newfile = await File(path).writeAsBytes(
                                      img.encodeJpg(orientedImage));

                                  setState(() {
                                    file = newfile;
                                    filePath = path;
                                    //fileName = results.name;
                                    fileName = results.files.single.name;
                                    loading = false;
                                  });
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                              borderRadius: BorderRadius.circular(50),
                              splashColor:
                                  Colors.grey.shade300.withOpacity(0.8),
                              highlightColor:
                                  Colors.grey.shade800.withOpacity(0.2),
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
                  cardTextFieldDesign(addresscon, 'Address', nodeaddress,
                      'Insert phone number', 4),
                  gaphr(h: 30),
                  MaterialButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        GeoPoint geo;
                        if (addresscon.text.isEmpty) {
                          Position pos =
                              await LocationRepo().getCurrentLocation();
                          geo = GeoPoint(pos.latitude, pos.longitude);
                        } else {
                          var addresses =
                              await locationFromAddress(addresscon.text);
                          // print(addresses.first);
                          var address = addresses.first;
                          geo = GeoPoint(address.latitude, address.longitude);
                        }

                        final String? url = await StorageRepo(
                                uid: useraccount.uid)
                            .uploadPatientProfileImage(filePath!, fileName!);
                        // print(url);

                        Provider.of<PatientProvider>(context, listen: false)
                            .updatePatientInfo(
                          name: namecon.text,
                          icNum: icNumcon.text,
                          phoneNum: phoneNumcon.text,
                          address: addresscon.text,
                          patientId: patientIdcon.text,
                          geoPoint: geo,
                          profileImageUrl: url,
                        );
                        //GeoPoint geoPoint = GeoPoint(pos.latitude, pos.longitude);
                        await FirestoreRepo(uid: useraccount.uid)
                            .updatePatientInfo(
                          name: namecon.text,
                          icNum: icNumcon.text,
                          phoneNum: phoneNumcon.text,
                          address: addresscon.text,
                          patientId: patientIdcon.text,
                          geoPoint: geo,
                          profileImageUrl: url,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Update Saved'),
                          ),
                        );
                      } on Exception catch (e) {
                        setState(() {
                          loading = false;
                        });
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Update Failed due to error ${e.toString()}'),
                          ),
                        );
                      }
                      setState(() {
                        loading = false;
                      });
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
        ),
        loading
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400.withOpacity(0.7),
                ),
                child: loadingPillriveR(100),
              )
            : const SizedBox(),
      ],
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
