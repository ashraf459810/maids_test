import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids_test/core/styles/styles.dart';


class AppButton extends StatelessWidget {
  final String value;
  final Function onClick;
  final Color ? color;
  const AppButton({super.key,  required this.value, required this.onClick,this.color  }) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      onClick();
    },
      child: Container(
        height: 60.h,
        width: 340.w,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),  color:color?? Colors.black,),
      
        child: Center(
          child: Text(
            value,
            style: Styles. buttonTextStyle
          ),
        ),
      ),
    );
  }
}
