import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTile extends StatelessWidget {
  final Widget prefix;

  final Widget? suffix;

  final String title;
  final String subTitle;
  const CustomTile({super.key , required this.prefix,required this.subTitle,required this.suffix,required this.title});

  @override
  Widget build(BuildContext context) {
    final ColorSchema=Theme.of(context).colorScheme;
    return Container(
      height: 58.h,
      margin: EdgeInsets.only(bottom: 10.h),
      
      decoration: BoxDecoration(
      color: ColorSchema.secondary,
      borderRadius: BorderRadius.circular(10)

      ),
      
      alignment: Alignment.center,
      child: ListTile(
      
        dense: true,
         selectedTileColor: ColorSchema.primary,
         tileColor: ColorSchema.primary,
         leading: prefix,
         trailing: suffix,
       title: Text(title,style: TextStyle(color: ColorSchema.inverseSurface,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis),
      
       subtitle: Text(subTitle,style:TextStyle(color: ColorSchema.inverseSurface), overflow: TextOverflow.ellipsis,),
      ),
    );



  }
}