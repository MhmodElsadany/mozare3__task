import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app_colors.dart';

class ToastManager {
  final BuildContext mContext;

  ToastManager(this.mContext);

  static void showToast(String msg) {
    if (msg.isEmpty) {
      return;
    }
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.grey_border,
      textColor: AppColors.primary,
      fontSize: 18.0,
    );
  }
}
