import 'package:flutter/material.dart';

Widget container({
  BoxShape? boxShape,
  double? hight,
  double? width,
  double? borderRadius,
  Color? color,
  Color ?bordercolor,
  Widget? child,
  bool ?shadow,
  Alignment ?alignment
}) {
  return Container(
    
      alignment: alignment?? Alignment.center,
    height: hight,
    width: width,
    decoration: BoxDecoration(
      shape: boxShape?? BoxShape.rectangle,
      borderRadius : boxShape ==null?  BorderRadius.all(
        Radius.circular(borderRadius ?? 0),
      ):null,
      border: Border.all(color: bordercolor ?? Colors.transparent),
      boxShadow: [
        shadow ?? false
            ? BoxShadow(
                color: Colors.grey[400]!.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 6,
                offset: const Offset(0, 1), // changes position of shadow
              )
            : const BoxShadow(color: Colors.transparent)
      ],
      color: color ?? Colors.white,
    ),
    child: child,
  );
}
