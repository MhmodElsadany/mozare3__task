import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilies/app_colors.dart';

class Btn extends StatelessWidget {
  String text;
  double height;
  VoidCallback? onPressed;
  Color color = AppColors.primary, textColor = AppColors.white;

  final double verticalMargin, horizontal;
  final double borderRadius;
  final bool isBorder;

  Btn(
      this.text, {
        super.key,
        this.height = 52.0,
        this.verticalMargin = 10,
        this.horizontal = 20,
        this.color = AppColors.secondary,
        this.textColor = Colors.white,
        this.onPressed,
        this.borderRadius = 32.0,
        this.isBorder = false,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius.sp)),
            border: Border.all(color: color, width: 1.0.w)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text(
              text,
              style:TextStyle(
                  color: textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
