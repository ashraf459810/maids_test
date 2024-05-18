import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterSelection extends StatefulWidget {
  final String option1;
  final String option2;
  final Function getOption;
  const FilterSelection(
      {super.key,
      required this.option1,
      required this.option2,
      required this.getOption});
  @override
  State<FilterSelection> createState() => _FilterSelectionState();
}

class _FilterSelectionState extends State<FilterSelection> {
  bool switchValue = false; // Tracks the selected option

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              switchValue = false;
              widget.getOption(widget.option1);
            });
          },
          child: Container(
            key: const Key('oneImageFilter'),
            height: 40.h,
            width: 120.w,
            color: switchValue
                ? Colors.grey
                : Colors.blueAccent, // Change color based on selection
            child: Center(
                child: Text(widget.option1,
                    style: TextStyle(color: Colors.white, fontSize: 6.sp))),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              switchValue = true;
              widget.getOption(widget.option2);
            });
          },
          child: Container(
               key: const Key('multiImageFilter'),
            height: 40.h,
            width: 120.w,

            color: switchValue
                ? Colors.blueAccent
                : Colors.grey, // Change color based on selection
            child: Center(
                child: Text(widget.option2,
                    style: TextStyle(color: Colors.white, fontSize: 6.sp))),
          ),
        ),
      ],
    );
  }
}
