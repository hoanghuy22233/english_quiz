// ignore: import_of_legacy_library_into_null_safe
import 'package:utils_libs/utils_libs.dart';
import 'package:flutter/material.dart';

class AccountController{

  TextEditingController username = TextEditingController(text: MESSAGES.NOT_SETUP);
  TextEditingController email = TextEditingController(text: MESSAGES.NOT_SETUP);
  TextEditingController loginCode = TextEditingController(text: MESSAGES.NOT_SETUP);
  TextEditingController phone = TextEditingController(text: MESSAGES.NOT_SETUP);
  TextEditingController birthday = TextEditingController(text: MESSAGES.NOT_SETUP);
  TextEditingController address = TextEditingController(text: MESSAGES.NOT_SETUP);
  TextEditingController notSetup = TextEditingController(text: MESSAGES.NOT_SETUP);

  void onChangeInput(String input, int inputType) {
    switch (inputType) {
      case 0:
        username.text = input;
        break;
      case 1:
        loginCode.text = input;
        break;
      case 2:
        phone.text = input;
        break;
      case 3:
        birthday.text = input;
        break;
      case 4:
        address.text = input;
        break;
      case 5:
        email.text = input;
        break;

      default:
        break;
    }
  }
}
