library globals;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytracker/Helper/database_helper.dart';
import 'package:moneytracker/HomeController/home_controller.dart';

HomeController _controller = Get.put(HomeController());

const Color mainTheme = Color.fromARGB(255, 95, 106, 232);
const Color textTheme = Color.fromARGB(255, 1, 41, 112);
const Color backgroundTheme = Color.fromRGBO(198, 193, 233, 1.0);

Future<void> getTotalExpense() async {
  var list = await DatabaseHelper.db.getTotalExpense();
  if (list[0]['totalExp'].toString() != "null") {
    _controller.totalExpense.value = list[0]['totalExp'].toString();
  } else {
    _controller.totalExpense.value = "0";
  }
}
