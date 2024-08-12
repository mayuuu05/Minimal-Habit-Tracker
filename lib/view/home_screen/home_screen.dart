import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../components/my_habit_tile.dart';
import '../../components/my_heat_map.dart';
import '../../controller/home_controller.dart';
import '../../database/habit_database.dart';
import '../../modal/habit_modal.dart';
import '../../utils/habit_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<HabitDataBase>(context, listen: false).readHabits();
    super.initState();
  }

  final TextEditingController textcontroller = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add new habit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          cursorColor: Colors.black,
          controller: textcontroller,
          decoration:  InputDecoration(
            hintText: "Enter your habit",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black)
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              textcontroller.clear();
            },
            child: const Text('Cancel',style: TextStyle(
                color: Colors.blue
            ),),
          ),
          TextButton(
            onPressed: () {
              String newHabitName = textcontroller.text.trim();
              if (newHabitName.isNotEmpty) {
                context.read<HabitDataBase>().addHabit(newHabitName);
                Navigator.pop(context);
                textcontroller.clear();
              }
            },
            child: const Text('Save',style: TextStyle(
              color: Colors.black
            ),),
          ),

        ],
      ),
    );
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDataBase>().updateHabitCompletion(habit.id, value);
    }
  }

  final HomeController controller = Get.put(HomeController());

  void editHabitBox(Habit habit) {
    textcontroller.text = habit.name;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Habit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: textcontroller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              String newHabitName = textcontroller.text.trim();
              if (newHabitName.isNotEmpty) {
                context
                    .read<HabitDataBase>()
                    .updateHabitName(habit.id, newHabitName);
                Navigator.pop(context);
                textcontroller.clear();
              }
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              textcontroller.clear();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void deleteHabitBox(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Habit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to delete this habit?'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<HabitDataBase>().deleteHabit(habit.id);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff0a0619),
                Color(0xff4ef8e7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hey! Mayuri',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: width * 0.06,
                      child: Icon(
                        Icons.person,
                        color: const Color(0xff0a0619),
                        size: width * 0.06,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(width * 0.04),
                  children: [
                    _buildHeatMap(),
                     SizedBox(height : height * 0.02),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Today, I have : ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildHabitList(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/home');
                        controller.updateSelectedIndex(0);
                      },
                      child: buildContainer(
                        index: 0,
                        icon: Icons.home,
                        width: width,
                        height: height,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.updateSelectedIndex(1);
                        createNewHabit();
                      },
                      child: buildContainer(
                        index: 1,
                        icon: Icons.add_circle,
                        width: width,
                        height: height,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/report');
                        controller.updateSelectedIndex(2);
                      },
                      child: buildContainer(
                        index: 2,
                        icon: Icons.calendar_month,
                        width: width,
                        height: height,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeatMap() {
    final habitDatabase = context.watch<HabitDataBase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;
    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MyHeatMap(
            startDate: snapshot.data!,
            datasets: prepHeatMapDataSet(currentHabits),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildContainer({
    required int index,
    required IconData icon,
    required double width,
    required double height,
  }) {
    return Obx(() {
      bool isSelected = controller.selectedIndex.value == index;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: isSelected ? height * 0.07 : height * 0.06,
        width: width * 0.2,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black45 : null,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Icon(icon, color: Colors.white, size: width * 0.08),
        ),
      );
    });
  }

  Widget _buildHabitList() {
    final habitDatabase = context.watch<HabitDataBase>();
    List<Habit> currentHabits = habitDatabase.currentHabits;

    return ListView.builder(
      itemCount: currentHabits.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final habit = currentHabits[index];
        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        return MyHabitTile(
          isCompleted: isCompletedToday,
          text: habit.name,
          onChanged: (value) => checkHabitOnOff(value, habit),
          editHabit: (context) => editHabitBox(habit),
          deleteHabit: (context) => deleteHabitBox(habit),
        );
      },
    );
  }
}
