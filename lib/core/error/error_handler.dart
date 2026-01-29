import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel_planner/core/exceptions/app_exceptions.dart';
class ErrorHandler {
  static void handleException(BuildContext context, Exception exception) {
    if (exception is ValidationException) {
      Fluttertoast.showToast(
        msg: exception.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.black,
      );
    } else if (exception is AuthException) {
      Fluttertoast.showToast(
        msg: exception.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (exception is NotFoundException) {
      Fluttertoast.showToast(
        msg: exception.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.black,
      );
    } else if (exception is StorageException) {
      Fluttertoast.showToast(
        msg: exception.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (exception is NetworkException) {
      Fluttertoast.showToast(
        msg: exception.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (exception is ServerException) {
      Fluttertoast.showToast(
        msg: exception.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'An unexpected error occurred',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
  static void handleError(BuildContext context, String error) {
    Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
  static void showSuccessToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
  static void showErrorToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
  static void showWarningToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orange,
      textColor: Colors.black,
    );
  }
  static void showInfoToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }
}
