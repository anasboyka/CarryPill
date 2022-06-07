import 'package:carrypill/business_logic/provider/order_provider.dart';
import 'package:carrypill/business_logic/provider/patient_provider.dart';
import 'package:carrypill/constants/constant_color.dart';
import 'package:carrypill/constants/constant_widget.dart';
import 'package:carrypill/data/models/clinic.dart';
import 'package:carrypill/data/models/facility.dart';
import 'package:carrypill/data/models/order_service.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/repositories/firebase_repo/firestore_repo.dart';
import 'package:carrypill/data/repositories/map_repo/location_repo.dart';
import 'package:carrypill/presentations/custom_widgets/radio_list_clinic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointmentTab extends StatefulWidget {
  final void Function(int index) changePage;
  Patient patient;
  BookAppointmentTab(
      {Key? key, required this.changePage, required this.patient})
      : super(key: key);

  @override
  _BookAppointmentTabState createState() => _BookAppointmentTabState();
}

class _BookAppointmentTabState extends State<BookAppointmentTab> {
  TextEditingController fullNameCon = TextEditingController();
  TextEditingController icCon = TextEditingController();
  TextEditingController patientIdCon = TextEditingController();
  TextEditingController addressCon = TextEditingController();
  TextEditingController phoneNumCon = TextEditingController();
  // TextEditingController searchcon = TextEditingController();
  // String query = '';

  final fullNameNode = FocusNode();
  final icNode = FocusNode();
  final patientIdNode = FocusNode();
  final addressNode = FocusNode();
  final phoneNumNode = FocusNode();
  // final searchNode = FocusNode();

  int? selectedValue1, selectedValue2;

  late List<Clinic> clinicList;
  //   Clinic(clinicName: 'MOPD', status: false),
  //   Clinic(clinicName: 'ORL/ENT', status: false),
  //   Clinic(clinicName: 'Paediatric', status: false),
  //   Clinic(clinicName: 'Orthopedik', status: false),
  //   Clinic(clinicName: 'Skin', status: false),
  //   Clinic(clinicName: 'Psychiatric', status: false),
  //   Clinic(clinicName: 'Eye', status: false),
  // ];

  //calendar
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Facility? facility;

  @override
  void initState() {
    // TODO: implement initState
    fullNameCon = TextEditingController(text: widget.patient.name);
    icCon = TextEditingController(text: widget.patient.icNum);
    patientIdCon = TextEditingController(text: widget.patient.patientId);
    addressCon = TextEditingController(text: widget.patient.address);
    phoneNumCon = TextEditingController(text: widget.patient.phoneNum);

    clinicList = widget.patient.clinicList;
    _selectedDay = widget.patient.appointment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<PatientProvider>(
    //     builder: (context, patientProvider, child) {
    //   fullNameCon.text = patientProvider.patient!.name;
    //   icCon.text = patientProvider.patient!.icNum;
    print(Provider.of<OrderProvider>(context)
        .orderService
        .serviceType
        .toString());
    return Column(
      children: [
        gaphr(h: 110),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Healthcare Facility',
                      style: kwtextStyleRD(
                        c: kcPrimary,
                        fs: 17,
                        fw: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  gaphr(h: 12.5),
                  FutureBuilder(
                      future: FirestoreRepo().facilityList,
                      builder: (_, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List<Facility> facilities = snapshot.data;
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: kcWhite,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Facility>(
                                  borderRadius: BorderRadius.circular(8.r),
                                  isExpanded: true,
                                  hint: Row(
                                    children: [
                                      const Text("Choose your facility"),
                                      facility == null
                                          ? Text(
                                              '(Required)',
                                              style: kwtextStyleRD(
                                                c: Colors.red,
                                                fs: 10,
                                                fw: FontWeight.w600,
                                              ),
                                            )
                                          : gapw(w: 0),
                                    ],
                                  ),
                                  value: facility,
                                  items: facilities
                                      .map(
                                        (e) => DropdownMenuItem<Facility>(
                                          value: e,
                                          child: Text(
                                            e.facilityName,
                                            style: kwtextStyleRD(
                                              c: kcPrimary,
                                              fs: 14,
                                              fw: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (Facility? facilityy) {
                                    setState(() {
                                      facility = facilityy;
                                      Provider.of<OrderProvider>(context,
                                              listen: false)
                                          .setFacility(facility!);
                                    });
                                  }),
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator.adaptive();
                        }
                      }),
                  gaphr(h: 12.5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Patient Details',
                      style: kwtextStyleRD(
                        c: kcPrimary,
                        fs: 17,
                        fw: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  gaphr(h: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: kcWhite,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          gaphr(),
                          inputTextField(
                            label: 'Full Name',
                            focusNode: fullNameNode,
                            controller: fullNameCon,
                          ),
                          gaphr(h: 25),
                          inputTextField(
                            label: 'IC',
                            focusNode: icNode,
                            controller: icCon,
                            type: TextInputType.number,
                          ),
                          gaphr(h: 25),
                          inputTextField(
                            label: 'Patient ID',
                            focusNode: patientIdNode,
                            controller: patientIdCon,
                            textCapitalization: TextCapitalization.characters,
                          ),
                          gaphr(h: 25),
                          inputTextField(
                            label: 'Phone Number',
                            focusNode: phoneNumNode,
                            controller: phoneNumCon,
                            type: TextInputType.phone,
                          ),
                          gaphr(h: 25),
                          inputTextField(
                            label: 'Address',
                            focusNode: addressNode,
                            controller: addressCon,
                            type: TextInputType.streetAddress,
                          ),
                          gaphr(h: 25),
                          Row(
                            children: [
                              Text(
                                'Follow Up Clinic',
                                style: kwtextStyleRD(
                                  c: kcLabelColor,
                                  fs: 12,
                                  fw: FontWeight.w500,
                                ),
                              ),
                              !clinicList.every(
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
                          gaphr(h: 25),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: clinicList.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 11.h),
                                child: RadioListChoice(
                                  choiceName: clinicList[index].clinicName,
                                  index: index,
                                  status: clinicList[index].status,
                                  radioToggle: radioToggle,
                                ),
                              );
                            },
                          ),
                          //   gaphr(h: 29),
                        ],
                      ),
                    ),
                  ),
                  gaphr(h: 25),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: kcWhite,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          gaphr(h: 11),
                          Row(
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
                            headerStyle: const HeaderStyle(
                              titleCentered: true,
                              formatButtonVisible: false,
                              headerPadding: EdgeInsets.all(0),
                              headerMargin: EdgeInsets.all(0),
                            ),
                            focusedDay: _focusedDay,
                            firstDay: DateTime(1998),
                            lastDay: DateTime(2023),
                            calendarFormat: CalendarFormat.week,
                            selectedDayPredicate: (day) {
                              return isSameDay(_selectedDay, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
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
                  //gaphr(h: 500)
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 95.h,
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 37.5.w),
              child: MaterialButton(
                shape: cornerR(r: 8),
                height: 44.h,
                minWidth: double.infinity,
                color: kcPrimary,
                onPressed: () async {
                  if (fullNameCon.text.isNotEmpty &&
                      icCon.text.isNotEmpty &&
                      patientIdCon.text.isNotEmpty &&
                      phoneNumCon.text.isNotEmpty &&
                      addressCon.text.isNotEmpty &&
                      !clinicList.every((element) => element.status == false) &&
                      _selectedDay != null &&
                      facility != null) {
                    GeoPoint geoAddress;
                    GeoPoint geoFacility;
                    double totalPay;

                    var addresses = await locationFromAddress(addressCon.text);
                    //print(addresses.first);
                    var address = addresses.first;
                    geoAddress = GeoPoint(address.latitude, address.longitude);
                    geoFacility = GeoPoint(facility!.geoPoint.latitude,
                        facility!.geoPoint.longitude);
                    totalPay = LocationRepo()
                        .calculateDeliveryCharge(geoAddress, geoFacility);
                    Patient patient = Patient(
                      name: fullNameCon.text,
                      icNum: icCon.text,
                      phoneNum: phoneNumCon.text,
                      address: addressCon.text,
                      appointment: _selectedDay,
                      clinicList: clinicList,
                      geoPoint: geoAddress,
                      patientId: patientIdCon.text,
                    );
                    Provider.of<OrderProvider>(context, listen: false)
                        .updatePatient(patient);
                    Provider.of<OrderProvider>(context, listen: false)
                        .setFacility(facility!);
                    Provider.of<OrderProvider>(context, listen: false)
                        .setTotalPay(totalPay);

                    widget.changePage(1);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in all required info'),
                      ),
                    );
                  }
                },
                child: textBtn15('Payment Method'),
              ),
            ),
          ),
        )
      ],
    );
    //});
  }

  void radioToggle(int index) {
    setState(() {
      clinicList[index].status = !clinicList[index].status;
    });
    print(clinicList[index].status);
  }

  TextFormField inputTextField({
    required String label,
    required TextEditingController controller,
    FocusNode? focusNode,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputType? type,
  }) {
    return TextFormField(
      textCapitalization: textCapitalization,
      focusNode: focusNode,
      controller: controller,
      keyboardType: type,
      style: kwtextStyleRD(
        c: kcPrimary,
        fs: 14,
        fw: FontWeight.w600,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 8.h),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: kcUnderlineBorder,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: kcUnderlineBorder,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: kcUnderlineBorder,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
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
      ),
    );
  }
}
