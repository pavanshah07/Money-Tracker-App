import 'package:hive/hive.dart';

//Generated Hive TypeAdapter using "flutter packages pub run build_runner build"
part 'saved_preferences.g.dart';

@HiveType(typeId: 1)
class SavedPreferences extends HiveObject {
  SavedPreferences(this.defaultOp,this.currency);

  @HiveField(0)
  late String defaultOp;

  @HiveField(1)
  late String currency;
}
