import 'package:intl/intl.dart';
import 'package:moneytracker/Helper/saved_preferences.dart';
import 'package:moneytracker/main.dart';

class Preferences{
  static void write(String defaultOp,String currency){
    box.put('preferences', SavedPreferences(defaultOp, currency));
  }
  static String readDefaultOp(){
    SavedPreferences sp =box.get('preferences');
    if(sp.defaultOp.isNotEmpty){
      return sp.defaultOp;
    }
    return '-';
  }

  static String readCurrency(){
    SavedPreferences sp =box.get('preferences');
    if(sp.currency.isNotEmpty){
      return sp.currency;
    }
    return '\$';
  }
}