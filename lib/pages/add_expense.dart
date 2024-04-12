import 'dart:math';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytracker/Helper/database_helper.dart';
import 'package:moneytracker/globals.dart' as globals;
import 'package:moneytracker/pages/view_expense.dart';

// ignore: must_be_immutable
class AddExpense extends StatefulWidget {
  bool isOpen;

  AddExpense({super.key, required this.isOpen});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

late TextEditingController e;
late TextEditingController r;
late TextEditingController d;

void initialize() {
  e.text = "";
  r.text = "";
  d.text = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
}

class _AddExpenseState extends State<AddExpense> with TickerProviderStateMixin {
  List category = ["Food", "Travel", "Shopping", "Entertainment", "Other"];
  List op = ["-", "+", "~"];
  late String selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    e = TextEditingController();
    r = TextEditingController();
    d = TextEditingController();
    selectedValue = "Food";
    initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    e.dispose();
    r.dispose();
    d.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: AnimatedContainer(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white38.withAlpha(100).withOpacity(0.7),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: widget.isOpen ? 4 : 0,
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.5))
                ]),
            duration: const Duration(milliseconds: 500),
            height:
                widget.isOpen ? MediaQuery.of(context).size.height / 0.5 : 0,
            child: SlideTransition(
                position:
                    Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
                        .animate(CurvedAnimation(
                            parent: AnimationController(
                                duration: const Duration(milliseconds: 0),
                                vsync: this)
                              ..forward(),
                            curve: Curves.easeInOut)),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                          child: IntrinsicWidth(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Expense",
                                      style: TextStyle(
                                          color: globals.textTheme,
                                          fontSize: 20,
                                          fontFamily: "Nunito"),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                  DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding:
                                    EdgeInsets.only(left: 14, right: 14),
                                  ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 200,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.white,
                                      ),
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                        MaterialStateProperty.all<double>(
                                            6),
                                        thumbVisibility:
                                        MaterialStateProperty.all<bool>(
                                            true),
                                      ),
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                      height: 50,
                                      width: 50,
                                      padding: const EdgeInsets.only(
                                          left: 14, right: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        color: Colors.white70,
                                      ),
                                      elevation: 2,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        homeController.defaultOp.value = value.toString();
                                      });
                                    },
                                    value: homeController.defaultOp.value,
                                    items: op
                                        .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                            color: globals.textTheme
                                                .withAlpha(210),
                                            fontFamily: "Nunito"),
                                      ),
                                    ))
                                        .toList()),
                        ),
                                      SizedBox(width: 20,),
                                      SizedBox(
                                        width: 200,
                                        child: Material(
                                          elevation: 3,
                                          color: Colors.white70.withOpacity(0.55),
                                          borderRadius: BorderRadius.circular(14),
                                          child: TextField(
                                            controller: e,
                                            maxLength: 7,
                                            style: TextStyle(
                                                color:
                                                    globals.textTheme.withAlpha(210),
                                                fontFamily: "Nunito"),
                                            decoration: InputDecoration(
                                              counterText: '',
                                                fillColor: Colors.transparent,
                                                filled: true,
                                                contentPadding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 15, 15, 15),
                                                isCollapsed: true,
                                                constraints: const BoxConstraints(
                                                    minWidth: 200, minHeight: 0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black26),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  borderSide: const BorderSide(
                                                      color: Colors.black26),
                                                )),
                                            onTapOutside: (event) => FocusManager
                                                .instance.primaryFocus
                                                ?.unfocus(),
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Category",
                                      style: TextStyle(
                                          color: globals.textTheme,
                                          fontSize: 20,
                                          fontFamily: "Nunito"),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                      menuItemStyleData: const MenuItemStyleData(
                                        height: 40,
                                        padding:
                                            EdgeInsets.only(left: 14, right: 14),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      buttonStyleData: ButtonStyleData(
                                        height: 50,
                                        width: 200,
                                        padding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          border: Border.all(
                                            color: Colors.black26,
                                          ),
                                          color: Colors.white70,
                                        ),
                                        elevation: 2,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value!;
                                        });
                                      },
                                      value: selectedValue,
                                      items: category
                                          .map((e) => DropdownMenuItem<String>(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: TextStyle(
                                                      color: globals.textTheme
                                                          .withAlpha(210),
                                                      fontFamily: "Nunito"),
                                                ),
                                              ))
                                          .toList()),
                                )),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Remarks",
                                      style: TextStyle(
                                          color: globals.textTheme,
                                          fontSize: 20,
                                          fontFamily: "Nunito"),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 200,
                                    child: Material(
                                      elevation: 3,
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(14),
                                      child: TextField(
                                        controller: r,
                                        style: TextStyle(
                                            color:
                                                globals.textTheme.withAlpha(210),
                                            fontFamily: "Nunito"),
                                        decoration: InputDecoration(
                                            fillColor:
                                                Colors.white70.withOpacity(0.55),
                                            filled: true,
                                            contentPadding: const EdgeInsets.all(15),
                                            isCollapsed: true,
                                            constraints: const BoxConstraints(
                                                minWidth: 200, minHeight: 0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                  color: Colors.black26),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                  color: Colors.black26),
                                            )),
                                        onTapOutside: (event) => FocusManager
                                            .instance.primaryFocus
                                            ?.unfocus(),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Date",
                                      style: TextStyle(
                                          color: globals.textTheme,
                                          fontSize: 20,
                                          fontFamily: "Nunito"),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 200,
                                    child: Material(
                                      elevation: 3,
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(14),
                                      child: TextField(
                                        controller: d,
                                        style: TextStyle(
                                            color:
                                                globals.textTheme.withAlpha(210),
                                            fontFamily: "Nunito"),
                                        decoration: InputDecoration(
                                            suffix: InkWell(
                                                onTap: () {
                                                  showDatePicker(
                                                          context: context,
                                                          builder:
                                                              (context, child) {
                                                            return Theme(
                                                                data: Theme.of(context).copyWith(
                                                                    colorScheme: const ColorScheme.light(
                                                                        primary:
                                                                            globals
                                                                                .mainTheme,
                                                                        onPrimary:
                                                                            Colors
                                                                                .white,
                                                                        onSurface:
                                                                            globals
                                                                                .textTheme),
                                                                    textButtonTheme:
                                                                        TextButtonThemeData(
                                                                            style:
                                                                                TextButton.styleFrom(foregroundColor: globals.textTheme))),
                                                                child: child!);
                                                          },
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime(
                                                              DateTime.now()
                                                                      .year -
                                                                  50),
                                                          lastDate:
                                                              DateTime.now())
                                                      .then((pickerDate) {
                                                    if (pickerDate == null) {
                                                      return;
                                                    } else {
                                                      d.text =
                                                          DateFormat("dd-MM-yyyy")
                                                              .format(pickerDate)
                                                              .toString();
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.date_range,
                                                  color: globals.textTheme,
                                                )),
                                            fillColor:
                                                Colors.white70.withOpacity(0.55),
                                            filled: true,
                                            contentPadding: const EdgeInsets.fromLTRB(
                                                15, 15, 15, 15),
                                            isCollapsed: true,
                                            constraints: const BoxConstraints(
                                                minWidth: 200, minHeight: 0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                  color: Colors.black26),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: const BorderSide(
                                                  color: Colors.black26),
                                            )),
                                        onTapOutside: (event) => FocusManager
                                            .instance.primaryFocus
                                            ?.unfocus(),
                                        keyboardType: TextInputType.datetime,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                globals.mainTheme),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    color: Colors.black26),
                                                borderRadius:
                                                    BorderRadius.circular(14))),
                                        elevation: const MaterialStatePropertyAll(6)),
                                    onPressed: () async {
                                      DatabaseHelper.db.insertData(
                                          expense: int.parse(e.text),
                                          operation: homeController.defaultOp.value,
                                          category: selectedValue!,
                                          dateofexp: d.text,
                                          remarks: r.text);
                                      AddExpense(isOpen: false);
                                      setState(() {
                                        globals.getTotalExpense();
                                      });
                                    },
                                    child: const Text(
                                      "ADD",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: "Nunito"),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
