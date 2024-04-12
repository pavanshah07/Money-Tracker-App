import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneytracker/Helper/Preferences.dart';
import 'package:moneytracker/Helper/saved_preferences.dart';
import 'package:moneytracker/pages/add_expense.dart';
import 'package:moneytracker/Helper/currency_symbols_service.dart';
import 'package:moneytracker/pages/dashboard.dart';
import 'package:moneytracker/pages/settings.dart';
import 'package:moneytracker/pages/view_expense.dart';
import 'Helper/database_helper.dart';
import 'globals.dart' as globals;

late Box box;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SavedPreferencesAdapter());
  box = await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  bool _isOpen = false;
  final List _pages = [
    const Dashboard(),
    const ViewExpense(),
    const Settings(),
  ];
  int _pageIndex = 0;
  late AnimationController _controller;
  double turns = 0.0;
  double settingsTurns = 0.0;
  bool _isSettings = false;
  PageController pageController = PageController();

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    var list = await DatabaseHelper.db.readData();
    globals.getTotalExpense();
    homeController.currencySymbols.value = await CurrencySymbolsService.getCurrencySymbols();
    var temp = await Preferences.readCurrency();
    var temp1 = await Preferences.readDefaultOp();
    print(homeController.currencySymbols);
    setState(() {
      homeController.dataList.value = list;
      if(Preferences.readDefaultOp()!.isNotEmpty){
        homeController.defaultOp.value = temp1;
      }
      if(Preferences.readCurrency()!.isNotEmpty){
        homeController.currency.value = temp;
        print(homeController.currency.value);
      }
    });
    print(homeController.currencySymbols);
  }

  @override
  void dispose() {
    _controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  void toggleExpense() {
    setState(() {
      if (_isOpen == true) {
        _controller.forward();
        _isOpen = false;
        AddExpense(
          isOpen: _isOpen,
        );
        turns -= 1 / 1.6;
      } else {
        _controller.reverse();
        _isOpen = true;
        initialize();
        AddExpense(
          isOpen: _isOpen,
        );
        turns += 1 / 1.6;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: AnimatedTextKit(repeatForever: false,totalRepeatCount: 1, animatedTexts: [
          WavyAnimatedText(
            'MoneyTracker',
            speed: const Duration(milliseconds: 100),
            textStyle: const TextStyle(
                fontFamily: "Nunito",
                fontWeight: FontWeight.w600,
                fontSize: 30),
          ),
        ]),
        // const Text(
        //   "MoneyTracker",
        //   style: TextStyle(
        //       fontFamily: "Nunito", fontWeight: FontWeight.w600, fontSize: 30),
        // ),
        backgroundColor: const Color.fromARGB(255, 95, 106, 232),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  if (_isOpen) {
                    // _isOpen = false;
                    toggleExpense();
                  }
                  if (_isSettings == true) {
                    _controller.forward();
                    pageController
                        .animateToPage(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn)
                        .then((value) {
                      setState(() {
                        _isSettings = false;
                      });
                    });
                    settingsTurns += 1 / 1.6;
                  } else {
                    _controller.reverse();
                    _isSettings = true;
                    pageController
                        .animateToPage(1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn)
                        .then(
                          (value) {},
                        );
                    settingsTurns += 1 / 1.6;
                  }
                });
              },
              icon: AnimatedRotation(
                turns: settingsTurns,
                duration: const Duration(milliseconds: 500),
                child: const Icon(Icons.settings),
              )),
        ],
      ),
      body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              extendBody: true,
              backgroundColor: globals.backgroundTheme,
              body: Stack(
                children: [
                  _pages[_pageIndex],
                  _isOpen
                      ? AddExpense(isOpen: true)
                      : AddExpense(isOpen: false),
                ],
              ),
              bottomNavigationBar: BottomAppBar(
                height: 55,
                elevation: 20,
                color: globals.mainTheme,
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _pageIndex = 0;
                          });
                        },
                        icon: Icon(
                          Icons.dashboard,
                          color:
                              _pageIndex == 0 ? Colors.white : Colors.white30,
                        )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _pageIndex = 1;
                          });
                        },
                        icon: Icon(
                          Icons.bar_chart,
                          color:
                              _pageIndex == 1 ? Colors.white : Colors.white30,
                        )),
                  ],
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                  onPressed: toggleExpense,
                  backgroundColor: globals.mainTheme,
                  // child: AnimatedIcon(icon: AnimatedIcons.close_menu,progress: _controller,),
                  child: AnimatedRotation(
                    turns: turns,
                    duration: const Duration(milliseconds: 500),
                    child: const Icon(Icons.add),
                  )),
            ),
            _pages[2],
          ]),
    );
  }
}
