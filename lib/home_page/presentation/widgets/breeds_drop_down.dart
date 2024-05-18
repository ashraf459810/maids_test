import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BreedsDropdown extends StatefulWidget {
  final Function onSelect;
  final List<String> items;

  const BreedsDropdown({
    super.key,
    required this.items,
    required this.onSelect,
  });

  @override
  State<BreedsDropdown> createState() => _BreedsDropdownState();
}

class _BreedsDropdownState extends State<BreedsDropdown> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(     
      width: 220.w,
      height: 20.h,
      child: DropdownButton<String>(
     menuMaxHeight: 300.h,
        focusNode: FocusNode(canRequestFocus: false),
        hint: Text(
          widget.items.isEmpty
              ? 'no sub for selected breed'
              : 'select a sub breed',
          style: TextStyle(fontSize: 7.sp),
        ),
        isExpanded: true,
        isDense: true,
        value: dropdownValue,
        onChanged: (newValue) {
          setState(() {
            dropdownValue = newValue;
            widget.onSelect(newValue);
          });
        },
        style: TextStyle(fontSize: 7.sp, color: Colors.black),
        items: widget.items.map((String breed) {
          return DropdownMenuItem<String>(
            value: breed,
            child: Text(breed),
          );
        }).toList(),
      ),
    );
  }
}
