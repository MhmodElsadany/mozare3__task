import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilies/app_strings.dart';

class TextCentWidgetComp extends StatelessWidget {
  final double padding;
  final String text;

  const TextCentWidgetComp({Key? key, this.padding = 12,this.text=AppStrings.notAvalable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
      ),
    );
  }
}
