import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitButton extends StatefulWidget {
  final String text;
  final Function onPress;
  const SubmitButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 50.h,
      child: ElevatedButton(
      
        onPressed: () {
          widget.onPress();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Colors.blueAccent, // Set the button's background color
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 8.sp,
            color: Colors.white, // Set the text color to white
          ),
        ),
      ),
    );
  }
}
