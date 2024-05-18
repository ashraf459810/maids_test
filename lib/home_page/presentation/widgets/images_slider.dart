import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => { 
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}final ScrollController controller = ScrollController();

class ImagesSlider extends StatelessWidget {

  final List<String> images;
  const ImagesSlider({Key? key, required this.images})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
          child: ListView.builder(
            controller: controller,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
                child: Card(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        images[index],
                        fit: BoxFit.fill,
                        height: 220.h,
                        width: 200.h,
                        errorBuilder: (context, error, stackTrace) => Image.network(
                            'https://cdn-icons-png.flaticon.com/512/1998/1998627.png'),
                      )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
