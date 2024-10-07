import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Custombutton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Color color;
  final void Function() onTap;
  const Custombutton({super.key, required this.title,required this.height,required this.width,required this.onTap,required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
       duration: const Duration(milliseconds: 300),
      width: width,
      height: height,
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color
       ),
       alignment: Alignment.center,
      
       child: Text(title,style:  TextStyle(color: Colors.white,fontSize: 14.sp),),
      
      ),
    );
  }
}