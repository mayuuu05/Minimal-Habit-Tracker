import 'package:isar/isar.dart';

part 'habit_modal.g.dart';

@Collection()
class Habit {
  Id id = Isar.autoIncrement;
  late String name;
  List<DateTime> completedDays = [];
}
