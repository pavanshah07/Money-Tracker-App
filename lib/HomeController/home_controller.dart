import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController{
  RxList<Map> dataList = <Map>[].obs;
  RxString currency = NumberFormat.simpleCurrency(locale: Intl.getCurrentLocale().toString()).currencySymbol.obs;
  RxString totalExpense = "0".obs;
  RxList category = ["Food", "Travel", "Shopping", "Entertainment", "Other"].obs;
  RxList op = ["-", "+", "~"].obs;
  RxString defaultOp = '+'.obs;
  RxList<String> currencySymbols = <String>[].obs;
}