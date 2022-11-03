import 'package:carrypill/business_logic/provider/patient_provider.dart';
import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/data/models/clinic.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/models/patient_uid.dart';
import 'package:carrypill/data/repositories/firebase_repo/auth_repo.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill/presentations/custom_widgets/radio_list_clinic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../constants/constant_widget.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  Patient patient;
  ProfileTab({
    Key? key,
    required this.patient,
  }) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  // final namecon = TextEditingController();
  final icNumcon = TextEditingController();
  final phoneNumcon = TextEditingController();

  // FocusNode nodename = FocusNode();
  FocusNode nodeicNum = FocusNode();
  FocusNode nodephoneNum = FocusNode();

  // List<bool> enabled = List.filled(2, false);
  late List<Clinic> clinicList;
  // List<Clinic> clinicList = [
  //   Clinic(clinicName: 'MOPD', status: false),
  //   Clinic(clinicName: 'ORL/ENT', status: false),
  //   Clinic(clinicName: 'Paediatric', status: false),
  //   Clinic(clinicName: 'Orthopedik', status: false),
  //   Clinic(clinicName: 'Skin', status: false),
  //   Clinic(clinicName: 'Psychiatric', status: false),
  //   Clinic(clinicName: 'Eye', status: false),
  // ];

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Patient patient;

  // bool statusComplete = false;

  @override
  void initState() {
    // TODO: implement initState
    //print('init profile tab');
    patient = widget.patient;
    clinicList = widget.patient.clinicList;
    _selectedDay = widget.patient.appointment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('build profile tab');
    PatientUid auth = Provider.of<PatientUid>(context);
    // var patientProvider = Provider.of<PatientProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () async {
              AuthRepo().logout();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body:
          // FutureBuilder<Patient?>(
          //   future: FirestoreRepo(uid: auth.uid).futurePatient,
          //   builder: (_, AsyncSnapshot snapshot) {
          //     if (snapshot.hasData) {
          //       Patient patient = snapshot.data;
          //       return
          SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              gaphr(),
              Material(
                elevation: 1,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                child: InkWell(
                  splashColor: Colors.grey.shade300.withOpacity(0.8),
                  highlightColor: Colors.grey.shade800.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.r),
                  onTap: () async {
                    Navigator.of(context).pushNamed('/profileinfo',
                        arguments: {'patient': patient}).whenComplete(() async {
                      Patient? patientpop =
                          await FirestoreRepo(uid: auth.uid).futurePatient;
                      setState(() {
                        patient = patientpop!;
                        // _selectedDay = patientpop.appointment;
                        // clinicList = patientpop.clinicList;
                      });
                    });
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: kcWhite,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(10, 24),
                          blurRadius: 54,
                          color: kcboxshadow,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: SizedBox(
                        height: 90,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 90.h,
                              width: 90.h,
                              child: Image.asset(
                                'assets/images/profile.png',
                                height: 90,
                              ),
                            ),
                            gapwr(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    patient.name, //'Name',
                                    style: kwtextStyleRD(
                                      c: kcBlack,
                                      fs: 18,
                                      fw: FontWeight.w500,
                                    ),
                                  ),
                                  gaphr(h: 10),
                                  Text(
                                    patient.patientId ??
                                        'Patient ID required', //'Patient ID',
                                    style: kwtextStyleRD(
                                      c: kcsubtitleListTile2,
                                      fs: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              size: 25,
                              color: kcsubtitleListTile2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              gaphr(h: 10),
              Column(
                children: [
                  // cardTextFieldDesign(
                  //     icNumcon, 'IC number', 'Insert full name as per IC', 0),
                  // gaphr(),
                  // cardTextFieldDesign(phoneNumcon, 'Phone Number',
                  //     'Insert full name as per IC', 1),
                  // gaphr(),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: cornerR(r: 15.r),
                      elevation: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          children: [
                            gaphr(h: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pharmacy Appointment Date',
                                  style: kwtextStyleRD(
                                    c: kcPrimary,
                                    fs: 17,
                                    fw: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                _selectedDay != null
                                    ? const SizedBox()
                                    : Text(
                                        '(Required)',
                                        style: kwtextStyleRD(
                                          c: Colors.red,
                                          fs: 10,
                                          fw: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                              ],
                            ),
                            //gaphr(h: 12),
                            TableCalendar(
                              onCalendarCreated: (pageController) {
                                if (patient.appointment != null) {
                                  _selectedDay = patient.appointment;
                                }
                              },
                              headerStyle: const HeaderStyle(
                                titleCentered: true,
                                formatButtonVisible: false,
                                headerPadding: EdgeInsets.all(0),
                                headerMargin: EdgeInsets.all(0),
                              ),
                              focusedDay: _focusedDay,
                              firstDay: DateTime(1998),
                              lastDay: DateTime(2023),
                              calendarFormat: CalendarFormat.twoWeeks,
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                // print('_selected ${_selectedDay}');
                                // print(' selected${selectedDay}');

                                if (!isSameDay(_selectedDay, selectedDay)) {
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });
                                }
                              },
                              onPageChanged: (focusedDay) {
                                _focusedDay = focusedDay;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  gaphr(h: 5),
                  Card(
                    color: kcWhite,
                    shape: cornerR(r: 25),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          gaphr(h: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Follow Up Clinic',
                                style: kwtextStyleRD(
                                  c: kcPrimary,
                                  fs: 17,
                                  fw: FontWeight.w600,
                                ),
                              ),
                              !clinicList
                                      // !(Provider.of<PatientProvider>(context)
                                      //             .patient!
                                      //             .clinicList)
                                      .every(
                                          (element) => element.status == false)
                                  ? const SizedBox()
                                  : Text(
                                      '(Required)',
                                      style: kwtextStyleRD(
                                        c: Colors.red,
                                        fs: 10,
                                        fw: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                            ],
                          ),
                          gaphr(h: 15),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: clinicList.length,
                            itemBuilder: (_, index) {
                              // List<Clinic>? listClinic =
                              //     Provider.of<PatientProvider>(
                              //   context,
                              // ).patient?.clinicList;
                              // if (listClinic != null) {}
                              return Padding(
                                padding: EdgeInsets.only(bottom: 11.h),
                                child: RadioListChoice(
                                    choiceName: clinicList[index].clinicName,
                                    index: index,
                                    status: clinicList[index].status,
                                    // Provider.of<PatientProvider>(
                                    //       context,
                                    //     )
                                    //         .patient
                                    //         ?.clinicList[index]
                                    //         .status ??
                                    //     clinicList[index].status,
                                    radioToggle: (int index) {
                                      setState(() {
                                        clinicList[index].status =
                                            !clinicList[index].status;
                                      });
                                      // radioToggle(
                                      //     index, patientProvider);
                                      // Provider.of<PatientProvider>(
                                      //         context,
                                      //         listen: false)
                                      //     .updateStatus(index);
                                    }
                                    // radioToggle: radioToggle,
                                    ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  gaphr(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: MaterialButton(
                      onPressed: () async {
                        // print(clinicList[0].status);
                        // print(clinicList
                        //     .every((element) => element.status == false));
                        if (_selectedDay != null &&
                            !clinicList
                                // !(Provider.of<PatientProvider>(context,
                                //             listen: false)
                                //         .patient!
                                //         .clinicList)
                                .every((element) => element.status == false)) {
                          // print('here');
                          // clinicList = Provider.of<PatientProvider>(
                          //         context,
                          //         listen: false)
                          //     .patient!
                          //     .clinicList;
                          // print(clinicList);
                          await FirestoreRepo(uid: auth.uid)
                              .updateAppointment(_selectedDay!);
                          // await Provider.of<PatientProvider>(context,
                          //         listen: false)
                          //     .updatePatient(
                          //   auth.uid,
                          //   patient: patient,
                          // );
                          // await Provider.of<PatientProvider>(context,
                          //         listen: false)
                          //     .updateClinic(clinicList, auth.uid);

                          await FirestoreRepo(uid: auth.uid)
                              .updateClinic(clinicList);
                        } else {
                          // print('else');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_selectedDay != null
                                  ? 'Follow Up Clinic is required'
                                  : 'Please select a date for appointment'),
                            ),
                          );
                        }
                      },
                      shape: cornerR(r: 8),
                      height: 44.h,
                      minWidth: double.infinity,
                      color: kcPrimary,
                      child: textBtn15('Save Profile'),
                    ),
                  ),
                  gaphr(),
                ],
              )
            ],
          ),
        ),
      ),
    );
    //       } else {
    //         return const Center(
    //           child: SizedBox(
    //             width: 150,
    //             height: 150,
    //             child: CircularProgressIndicator.adaptive(
    //               backgroundColor: kcPrimary,
    //             ),
    //           ),
    //         );
    //       }
    //     },
    //   ),
    // );
  }

  void radioToggle(int index, PatientProvider patientProvider) {
    setState(() {
      patientProvider.patient!.clinicList[index].status =
          !patientProvider.patient!.clinicList[index].status;
    });
    //print(clinicList[index].status);
  }
}
