import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytracker/Helper/Preferences.dart';
import 'package:moneytracker/HomeController/home_controller.dart';
import 'package:moneytracker/globals.dart' as globals;
import 'package:moneytracker/widgets/neumorphic_container.dart';
import 'package:moneytracker/widgets/widgets.dart';

import '../Helper/database_helper.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  HomeController homeController = Get.put(HomeController());
  String selectedValue = "-";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globals.backgroundTheme,
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 85),
        children: [
          const Center(
            child: Text(
              "Settings",
              style: TextStyle(
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.bold,
                  color: globals.textTheme,
                  fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () => showDialog(
              context: context,
              builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: NeumorphicContainer(
                    child: DropdownButton(
                      value: homeController.defaultOp.value,
                      items: homeController.op
                          .map((element) => DropdownMenuItem(
                              value: element,
                              child: CustomText(
                                text: element,
                              )))
                          .toList(),
                      onChanged: (value) {
                        Preferences.write(homeController.defaultOp.value, homeController.currency.value);
                        setState(() {
                          homeController.defaultOp.value = value.toString();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  )),
            ),
            child: const NeumorphicContainer(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Default Operation",
                    ))),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () => showDialog(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: NeumorphicContainer(
                    child: DropdownButton(
                  value: homeController.currency.value,
                  items: homeController.currencySymbols
                      .map((element) => DropdownMenuItem(
                          value: element,
                          child: CustomText(
                            text: element,
                          )))
                      .toList(),
                  onChanged: (value) {
                    Preferences.write(homeController.defaultOp.value, homeController.currency.value);
                    setState(() {
                      homeController.currency.value = value.toString();
                    });
                    Navigator.pop(context);
                  },
                )),
              ),
            ),
            child: const NeumorphicContainer(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(text: 'Change Currency'))),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: globals.mainTheme,
                title: const CustomText(
                  text: "Delete All Expenses",
                  color: Colors.white,
                ),
                content: const CustomText(
                  text: "Are you sure you want to delete all expenses?",
                  color: Colors.white,
                  fontSize: 15,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        DatabaseHelper.db.deleteAllData();
                        Navigator.pop(context);
                      },
                      child: const CustomText(
                        text: "Yes",
                        color: Colors.white,
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const CustomText(
                        text: "No",
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            child: const NeumorphicContainer(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(text: 'Delete all Expenses'))),
          )
        ],
      ),
    );
  }
}
