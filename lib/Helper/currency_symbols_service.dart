import 'dart:convert';

import 'package:flutter/services.dart';

class CurrencySymbolsService {
  static Future<List<String>> getCurrencySymbols() async {
    final String json = await rootBundle.loadString(
        'assets/json/currency_symbols.json');
    final List<dynamic> data = jsonDecode(json);

    Set<String> uniqueValues = {};


    data.map((e) {
      uniqueValues.add(e['symbol'].toString());
      return e;
    }).toList();

    List<String> values = uniqueValues.toList();

    return values;
  }
}
