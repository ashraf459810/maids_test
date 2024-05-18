import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_test/core/const/const.dart';


class InputField extends StatelessWidget {
  final String hint;
  final Function getValue;
  final Widget widget;
  final Widget? tail;
  final String? Function(String?)? validator; // Updated validator type
  final TextInputType? textInputType;
  const InputField(
      {super.key,
      required this.hint,
      required this.widget,
      required this.getValue,
      this.tail,
      required this.textInputType,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: 340.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.lightGrey,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            widget,
            SizedBox(
              width: 23.w,
            ),
            Expanded(
           
              child: TextFormField(
                style: TextStyle(
                  height: 1.1.w,
                ),
                validator: validator, // Set the validator function
                keyboardType: textInputType ?? TextInputType.name,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                
                  alignLabelWithHint:   true, // This will align the label with the hint
                  border: InputBorder.none,
                  hintText: hint,
                  hintTextDirection: TextDirection.rtl,

                ),
                cursorColor: Colors.black,
                onChanged: (value) {
                  getValue(value);
                },
              ),
            ),
            tail ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  return null;
}

String? validateMobile(String? value) {
  if (value == null || value.isEmpty) {
    return 'Mobile number cannot be empty';
  }
  if (value.length < 8) {
    return "more than 8 characters";
  }
  // Add your mobile number validation logic here
  return null;
}

String? validateNotEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}
