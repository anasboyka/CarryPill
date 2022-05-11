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

  FocusNode nodename = FocusNode();
  FocusNode nodeemail = FocusNode();
  FocusNode nodepass1 = FocusNode();
  FocusNode nodepass2 = FocusNode();
  FocusNode nodeicNum = FocusNode();

  bool isHidden1 = true, isHidden2 = true, loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kcPrimary,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  gaphr(h: 76),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Create Account',
                      style: kwstyleHeaderw35,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  gaphr(h: 45),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          textInputField('Full Name', namecon, nodename),
                          gaphr(),
                          textInputField('Email Address', emailcon, nodeemail),
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print(emailcon.text);
                                print(pass1con.text);
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
            )
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
