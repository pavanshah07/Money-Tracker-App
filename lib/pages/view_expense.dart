import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneytracker/HomeController/home_controller.dart';
import 'package:moneytracker/globals.dart' as globals;
import 'package:moneytracker/widgets/neumorphic_container.dart';
import 'package:moneytracker/widgets/widgets.dart';

import '../Helper/database_helper.dart';

class ViewExpense extends StatefulWidget {
  const ViewExpense({super.key});

  const ViewExpense._();

  static final ve = const ViewExpense._();

  @override
  State<ViewExpense> createState() => _ViewExpenseState();
}

HomeController homeController = Get.put(HomeController());

class _ViewExpenseState extends State<ViewExpense> {
  Future<void> getData() async {
    var list = await DatabaseHelper.db.readData();
    globals.getTotalExpense();
    setState(() {
      homeController.dataList.value = list;
    });
  }

  Widget updateList() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 85),
      itemCount: homeController.dataList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: -10,
                      blurRadius: 17,
                      offset: Offset(-5, -5),
                      color: Colors.white),
                  BoxShadow(
                      spreadRadius: -2,
                      blurRadius: 10,
                      offset: Offset(7, 7),
                      color: Color.fromRGBO(166, 146, 216, 1.0)),
                ],
                borderRadius: BorderRadius.circular(14),
                color: const Color.fromRGBO(198, 193, 233, 1.0)),
            child: ExpansionTile(
              collapsedBackgroundColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              maintainState: false,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              trailing: const SizedBox.shrink(),
              title: ListTile(
                horizontalTitleGap: 20,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: homeController.dataList[index]['category'],
                        fontSize: 15,
                        color: Colors.black54),
                    CustomText(
                        text:
                            "${homeController.currency.value} ${homeController.dataList[index]["expense"]}",
                        color: homeController.dataList[index]["operation"] ==
                                "+"
                            ? Colors.green
                            : homeController.dataList[index]["operation"] == "-"
                                ? Colors.red
                                : globals.textTheme),
                  ],
                ),
                subtitle: Text(
                    homeController.dataList[index]["dateofexp"].toString(),
                    style: const TextStyle(
                        fontFamily: "Nunito", color: Colors.black54)),
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: globals.mainTheme,
                            child: Container(
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    CustomText(text: 'Hello',color: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: Container(
                          // width: MediaQuery.of(context).size.width / 2.1,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.8),
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(14))),
                          child: Center(
                            child: CustomText(
                              color: Colors.black87.withAlpha(150),
                              text: 'Edit',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            // backgroundColor: globals.mainTheme,
                            backgroundColor:
                                Colors.white.withOpacity(0).withAlpha(0),
                            child: IntrinsicWidth(
                              child: IntrinsicHeight(
                                child: Container(
                                  // upperShadowColor: Colors.black38,
                                  // lowerShadowColor: Color.fromARGB(255, 184, 176, 252),
                                  decoration: BoxDecoration(
                                      color: globals.mainTheme,
                                      borderRadius: BorderRadius.circular(21)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(21.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            color: Colors.white,
                                            text:
                                                "Expense: ${homeController.dataList[index]['expense'].toString()}"),
                                        CustomText(
                                            color: Colors.white,
                                            text:
                                                "Category: ${homeController.dataList[index]['category']}"),
                                        CustomText(
                                            color: Colors.white,
                                            text:
                                                "Date: ${homeController.dataList[index]['dateofexp']}"),
                                        homeController.dataList[index]
                                                    ['remarks'] ==
                                                ""
                                            ? SizedBox.shrink()
                                            : Expanded(
                                                child: CustomText(
                                                    color: Colors.white,
                                                    text:
                                                        "Remarks: ${homeController.dataList[index]['remarks']}"),
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: Container(
                          // width: MediaQuery.of(context).size.width / 2.1,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.8),
                          ),
                          child: Center(
                            child: CustomText(
                              color: Colors.black87.withAlpha(150),
                              text: 'View',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: globals.mainTheme,
                            title: const CustomText(
                              text: "Delete Expense",
                              color: Colors.white,
                            ),
                            content: const CustomText(
                              text:
                                  "Are you sure you want to delete this expense?",
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    DatabaseHelper.db.deleteData(
                                        id: homeController.dataList[index]
                                            ['id']);
                                    getData();
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
                        child: Container(
                            // width: MediaQuery.of(context).size.width / 2.1,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.8),
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(14))),
                            child: Center(
                                child: CustomText(
                                    color: Colors.black87.withAlpha(150),
                                    text: 'Delete'))),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  getDialog(int id) {
    // return showDialog(context: context, builder: (context) {
    //   return Column(
    //     children: [
    //       const CustomText(text: "Are you sure you want to delete this expense?"),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           TextButton(onPressed: (){}, child: const CustomText(text: 'Yes')),
    //           TextButton(onPressed: (){}, child: const CustomText(text: 'No')),
    //         ],
    //       )
    //     ],
    //   );
    // },);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // SizedBox(width: double.infinity,height: MediaQuery.of(context).size.height/1.5,child: Center(child: Image.asset("assets/icons/icon.ico"),)),
      homeController.dataList.isEmpty
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: globals.backgroundTheme,
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 55.0),
                child: CustomText(text: "No Expenses", fontSize: 20),
              )))
          : Container(
              color: globals.backgroundTheme,
              child: updateList(),
            ),
    ]);
  }
}
