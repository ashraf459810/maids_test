import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        height: 40.h,
        width: 39.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Color.fromARGB(255, 218, 215, 215))),
        child: const Icon(Icons.arrow_back_ios_new,size: 20,),
      ),
    );
  }
}