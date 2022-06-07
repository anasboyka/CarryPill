import 'package:carrypill/data/repositories/firebase_repo/auth_repo.dart';

import '../../../constants/constant_color.dart';
import '../../../constants/constant_widget.dart';
import '../../custom_widgets/text_input_field.dart';
import 'register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  final Function toggleView;

  Login({
    Key? key,
    required this.toggleView,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with InputValidationMixin {
  final emailcon = TextEditingController();
  final passcon = TextEditingController();

  FocusNode nodeemail = FocusNode();
  FocusNode nodepass = FocusNode();

  bool isHidden = true, loading = false;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldMessengerKey,
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
                      'Welcome Back',
                      style: kwstyleHeaderw35,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  gaphr(h: 8),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign in with email',
                      style: kwstylew18,
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
                          textInputField('Email Address', emailcon, nodeemail),
                          gaph(),
                          textInputField(
                            'Password',
                            passcon,
                            nodepass,
                            isPassword: true,
                          ),
                          gaph(h: 15),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Forgot Password?',
                              style: kwtextStyleRD(
                                c: Colors.white,
                                fs: 16,
                                fw: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          gaphr(h: 28),
                          MaterialButton(
                            height: 55.h,
                            minWidth: double.infinity,
                            color: kcLightYellow,
                            shape: cornerR(),
                            child: Text(
                              'Sign In',
                              style: kwtextStyleRD(
                                fs: 16,
                                c: kcSignIn,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result = await AuthRepo()
                                    .login(emailcon.text, passcon.text);
                                if (result == null) {
                                  if (mounted) {
                                    setState(() {
                                      error = "please supply a valid email";
                                      loading = false;
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error)),
                                    );
                                  }
                                } else if (result is String) {
                                  if (mounted) {
                                    setState(() {
                                      error = result;
                                      loading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                          gaphr(h: 50),
                          Opacity(
                            opacity: !loading ? 0 : 1,
                            child: SizedBox(
                              height: 40.h,
                              width: 40.h,
                              child: const CircularProgressIndicator.adaptive(
                                backgroundColor: kctextDark,
                              ),
                            ),
                          ),
                          gaphr(h: 50),
                          const Text(
                            'or, Sign in with',
                            style: kwstylew16,
                          ),
                          gaphr(h: 28),
                          MaterialButton(
                            height: 55.h,
                            minWidth: double.infinity,
                            shape: cornerR(),
                            color: kcWhite,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/googleButtonIcon.png',
                                  width: 25.w,
                                ),
                                const Expanded(
                                  child: Center(
                                    child: Text(
                                      'Continue with Google',
                                      style: kwstyleb16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25.w,
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                          gaphr(),
                          MaterialButton(
                            height: 55.h,
                            minWidth: double.infinity,
                            shape: cornerR(),
                            color: kcFb,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/fbButtonIcon.png',
                                  width: 25.w,
                                ),
                                const Expanded(
                                  child: Center(
                                    child: Text(
                                      'Continue with Facebook',
                                      style: kwstylew16,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25.w,
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                          gaphr(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'New here? ',
                                style: kwstylew16,
                              ),
                              InkWell(
                                child: Text(
                                  'Create a new one',
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

  Widget textInputField(
      String hintText, TextEditingController controller, FocusNode node,
      {bool isPassword = false}) {
    return TextFormField(
      validator: (value) {
        if (hintText == 'Email Address') {
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
        }
        return null;
      },
      controller: controller,
      focusNode: node,
      style: kwstyleb16,
      obscureText: isPassword ? isHidden : false,
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
                      isHidden = !isHidden;
                      print(isHidden);
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
