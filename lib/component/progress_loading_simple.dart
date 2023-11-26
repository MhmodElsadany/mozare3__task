import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utilies/app_colors.dart';

class ProgressLoadingSimple extends StatelessWidget {
  final double padding;

  const ProgressLoadingSimple({Key? key, this.padding = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loadingView();
  }

  Widget loadingView() {
    if (Platform.isIOS) {
      return Container(
        padding: EdgeInsets.all(8.sp),
        child: CupertinoActivityIndicator(
          animating: true,
          radius: 14.sp,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(12),
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      );
    }
  }
}
