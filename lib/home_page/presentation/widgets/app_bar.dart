import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  GeneralAppBar({Key? key,})
      : preferredSize = Size.fromHeight(
          70.h,
        ),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 75.h,
        backgroundColor: Colors.blueAccent,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Dashboard',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp),
        ));
  }
}
