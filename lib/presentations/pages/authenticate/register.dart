import 'dart:ui';

import 'package:carrypill/data/models/clinic.dart';
import 'package:carrypill/data/models/patient.dart';
import 'package:carrypill/data/repositories/firebase_repo/auth_repo.dart';

import '../../../constants/constant_color.dart';
import '../../../constants/constant_widget.dart';
import '../../custom_widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with InputValidationMixin {
  final namecon = TextEditingController();
  final emailcon = TextEditingController();
  final pass1con = TextEditingController();
  final pass2con = TextEditingController();
  final icNumcon = TextEditingController();
  final phoneNumcon = TextEditingController();

  FocusNode nodename = FocusNode();
  FocusNode nodeemail = FocusNode();
  FocusNode nodepass1 = FocusNode();
  FocusNode nodepass2 = FocusNode();
  FocusNode nodeicNum = FocusNode();
  FocusNode nodephoneNum = FocusNode();

  List<Clinic> clinicList = [
    Clinic(clinicName: 'MOPD', status: false),
    Clinic(clinicName: 'ORL/ENT', status: false),
    Clinic(clinicName: 'Paediatric', status: false),
    Clinic(clinicName: 'Orthopedik', status: false),
    Clinic(clinicName: 'Skin', status: false),
    Clinic(clinicName: 'Psychiatric', status: false),
    Clinic(clinicName: 'Eye', status: false),
  ];

  String error = '';

  bool isHidden1 = true, isHidden2 = true, loading = false;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldMessengerKey, //widget.scaffoldMessengerKey,
        backgroundColor: kcPrimary,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: loading
                  ? BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    )
                  : null,
            ),
            Opacity(
              opacity: loading ? 0.6 : 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    gaphr(h: 56),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Create Account',
                        style: kwstyleHeaderw35,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    gaphr(h: 25),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            textInputField('Full Name', namecon, nodename),
                            gaphr(),
                            textInputField(
                                'Email Address', emailcon, nodeemail),
                            gaphr(),
                            textInputField('Password', pass1con, nodepass1,
                                isHidden: isHidden1, isPassword: true),
                            gaphr(),
                            textInputField(
                                'Confirm Password', pass2con, nodepass2,
                                isHidden: isHidden2, isPassword: true),
                            gaphr(),
                            textInputField('IC Number', icNumcon, nodeicNum),
                            gaphr(),
                            textInputField(
                                'Phone Number', phoneNumcon, nodephoneNum),
                            gaphr(),
                            // TextInputForm(
                            //   controller: pass2con,
                            //   node: nodepass2,
                            //   hintText: 'Confirm Password',
                            //   isPassword: true,
                            //   // validator: (value) {
                            //   //   if (!isConfPasswordValid(pass1con.text, value)) {
                            //   //     return 'password must be same';
                            //   //   }
                            //   //   return null;
                            //   // },
                            // ),
                            // gaphr(h: 15),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Text(
                            //     'Forgot Password?',
                            //     style: textStyleRD(
                            //       c: Colors.white,
                            //       fs: 16,
                            //       fw: FontWeight.w600,
                            //     ),
                            //     textAlign: TextAlign.left,
                            //   ),
                            // ),
                            gaphr(h: 28),
                            MaterialButton(
                              height: 55.h,
                              minWidth: double.infinity,
                              color: kcLightYellow,
                              shape: cornerR(),
                              child: Text(
                                'Sign Up',
                                style: kwtextStyleRD(
                                  fs: 16,
                                  c: kcSignIn,
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  Patient patient = Patient(
                                    name: namecon.text,
                                    icNum: icNumcon.text,
                                    phoneNum: phoneNumcon.text,
                                    clinicList: clinicList,
                                  );
                                  setState(() => loading = true);
                                  dynamic result = await AuthRepo().register(
                                      patient, emailcon.text, pass1con.text);
                                  if (result == null) {
                                    if (mounted) {
                                      setState(() {
                                        error = "please supply a valid email";
                                        loading = false;
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(error)),
                                      );
                                    }
                                  } else if (result is String) {
                                    if (mounted) {
                                      setState(() {
                                        error = result;
                                        loading = false;
                                      });

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(error)),
                                      );
                                    }
                                  } else {
                                    if (mounted) {
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  }
                                }
                              },
                            ),
                            gaphr(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have account?',
                                  style: kwstylew16,
                                ),
                                InkWell(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: kcWhite,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onTap: () {
                                    //print('toggle');
                                    widget.toggleView();
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            loading
                ? Center(
                    child: SizedBox(
                      height: 40.h,
                      width: 40.h,
                      child: const CircularProgressIndicator.adaptive(
                        backgroundColor: kcWhite,
                      ),
                    ),
                  )
                : gapw(w: 0),
          ],
        ));
  }

  //ToDo change to widget for code reuse
  Widget textInputField(
      String hintText, TextEditingController controller, FocusNode node,
      {bool isHidden = false, bool isPassword = false}) {
    return TextFormField(
      validator: (value) {
        if (hintText == 'Full Name') {
          if (!isNameValid(value)) {
            return 'Full Name required';
          }
        } else if (hintText == 'Email Address') {
          if (!isEmailValid(value)) {
            return 'Email is required';
          }
        } else if (hintText == 'Password') {
          if (!isPasswordValid(value)) {
            return 'password is required';
          }
          if (!isPasswordValidLength(value)) {
            return 'password must be more than 5 word';
          }
        } else if (hintText == 'Confirm Password') {
          if (!isConfPasswordValid(pass1con.text, value)) {
            return 'password must be same';
          }
        } else if (hintText == 'IC Number') {
          if (!isIcNumValid(value)) {
            return 'IC Number is required';
          }
        } else if (hintText == 'Phone Number') {
          if (!isphoneNumValid(value)) {
            return 'Phone Number is required';
          }
        }
        return null;
      },
      controller: controller,
      focusNode: node,
      style: kwstyleb16,
      obscureText: isHidden,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: kcOutlineTextField),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: kcOutlineTextField),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: kcLightYellow, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: kcOutlineTextField),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 24, 12, 16),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: kwstyleHint16,
        suffixIcon: isPassword
            ? Material(
                color: Colors.transparent,
                child: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    setState(() {
                      if (hintText == "Password") {
                        isHidden1 = !isHidden1;
                      } else {
                        isHidden2 = !isHidden2;
                      }
                    });
                  },
                  icon: isHidden
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              )
            : null,
      ),
    );
  }
}
