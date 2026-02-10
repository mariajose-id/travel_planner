import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_planner/core/logging/app_logger.dart';
import 'package:travel_planner/core/result/result.dart';
import 'package:travel_planner/core/error/error_mapper.dart';

class ResultHandler {
  ResultHandler._();

  static void handleResult(BuildContext context, Result result) {
    if (result.isFailure) {
      final error = result.error!;
      var backgroundColor = Colors.red;
      var textColor = Colors.white;

      if (error is ValidationError) {
        backgroundColor = Colors.orange;
        textColor = Colors.black;
      }

      final localizedMessage = error.toLocalizedMessage(context);

      AppLogger.error('Result Failure: [${error.code}] ${error.message}');

      Fluttertoast.showToast(
        msg: localizedMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: backgroundColor,
        textColor: textColor,
      );
    }
  }

  static void handleError(BuildContext context, String error) {
    AppLogger.ui('Error: $error');
    Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static void showSuccessToast(BuildContext context, String message) {
    AppLogger.ui('Success: $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  static void showErrorToast(BuildContext context, String message) {
    AppLogger.ui('Error Toast: $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  static void showWarningToast(BuildContext context, String message) {
    AppLogger.ui('Warning: $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orange,
      textColor: Colors.black,
    );
  }

  static void showInfoToast(BuildContext context, String message) {
    AppLogger.ui('Info: $message');
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }
}
