import '../../constants/constant_color.dart';
import '../../constants/constant_widget.dart';
import '../pages/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInputForm extends StatefulWidget {
  const TextInputForm({
    Key? key,
    required this.controller,
    required this.node,
    required this.hintText,
    this.isPassword = false,
    //required this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode node;
  final String hintText;
  final bool isPassword;
  //final String? Function(String?) validator;

  @override
  State<TextInputForm> createState() => _TextInputFormState();
}

class _TextInputFormState extends State<TextInputForm>
    with InputValidationMixin {
  late bool isHidden;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isHidden = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator: (value){
      // if (widget.hintText == 'Email address') {
      //     if (!isEmailValid(value)) {
      //       return 'Email is required';
      //     }
      //   } else if (widget.hintText == 'Password') {
      //     if (!isPasswordValid(value)) {
      //       return 'password is required';
      //     }
      //     if (!isPasswordValidLength(value)) {
      //       return 'password must be more than 5 word';
      //     }
      //   } else if (widget.hintText == 'Confirm Password') {
      //     if (!isConfPasswordValid(passcon.text, value)) {
      //       return 'password must be same';
      //     }
      //   }
      // },
      enableSuggestions: !widget.isPassword,
      controller: widget.controller,
      focusNode: widget.node,
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
        hintText: widget.hintText,
        hintStyle: kwstyleHint16,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
                icon: isHidden
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : null,
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isNameValid(String? name) => name != null ? name.isNotEmpty : false;
  bool isUserNameValid(String? userName) =>
      userName != null ? userName.isNotEmpty : false;

  bool isEmailValid(String? email) => email != null ? email.isNotEmpty : false;

  bool isPasswordValid(String? password) =>
      password != null ? password.isNotEmpty : false;
  bool isPasswordValidLength(String? password) => password!.length >= 6;

  bool isConfPasswordValid(String? password, String? confpassword) {
    return password != null && password.isNotEmpty
        ? password == confpassword
        : false;
  }
}
