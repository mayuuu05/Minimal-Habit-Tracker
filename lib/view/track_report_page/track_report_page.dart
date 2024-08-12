import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/home_controller.dart';

class TrackReportPage extends StatelessWidget {
  TrackReportPage({super.key});
  final HomeController controller = Get.put(HomeController());

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
                        fontSize: width * 0.05,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: width * 0.06,
                      child: Icon(
                        Icons.person,
                        color: Color(0xff0a0619),
                        size: width * 0.06,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: PageView.builder(
                    controller: PageController(initialPage: DateTime.now().month - 1),
                    onPageChanged: (index) {
                      // Handle month change if needed
                    },
                    itemBuilder: (context, index) {
                      int currentMonth = index + 1;
                      int year = DateTime.now().year;

                      return Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Add functionality for calendar icon button if needed
                            },
                            icon: Icon(Icons.calendar_month, color: Colors.white, size: 40),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: height * 0.02),
                            child: Text(
                              DateFormat('MMMM yyyy').format(DateTime(year, currentMonth)),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: dayNamesRow(),
                          ),
                          SizedBox(height: height * 0.02),
                          Expanded(
                            child: Center(
                              child: Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: height * 0.02),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: calendarGrid(year, currentMonth),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/home');
                      controller.updateSelectedIndex(0);
                    },
                    child: _buildIconContainer(
                      index: 0,
                      icon: Icons.home,
                      width: width,
                      height: height,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.updateSelectedIndex(1);
                      Get.toNamed('/home');
                    },
                    child: _buildIconContainer(
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
                    child: _buildIconContainer(
                      index: 2,
                      icon: Icons.calendar_month,
                      width: width,
                      height: height,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer({
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
        height: isSelected ? height * 0.06 : height * 0.05,
        width: isSelected ? width * 0.2 : width * 0.2,
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

  Widget dayNamesRow() {
    List dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: dayNames
          .map(
            (day) => Expanded(
          child: Center(
            child: Text(
              day,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )
          .toList(),
    );
  }

  Widget calendarGrid(int year, int month) {
    final int currentDay = DateTime.now().day;
    final int currentMonth = DateTime.now().month;
    final int currentYear = DateTime.now().year;
    final int daysInMonth = DateTime(year, month + 1, 0).day;
    final int firstDayOfMonth = DateTime(year, month, 1).weekday;

    int starting = (firstDayOfMonth - 1) % 7;

    return GridView.builder(
      itemCount: 42,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemBuilder: (context, index) {
        int dayNumber = index - starting + 1;
        if (dayNumber > 0 && dayNumber <= daysInMonth) {
          bool isPastDay = (year < currentYear) ||
              (year == currentYear && month < currentMonth) ||
              (year == currentYear && month == currentMonth && dayNumber < currentDay);
          bool isCurrentDay = (year == currentYear && month == currentMonth && dayNumber == currentDay);

          return Container(
            decoration: BoxDecoration(
              color: isCurrentDay ? Colors.green[600] : isPastDay ? Colors.green[200] : Colors.grey[400],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: isPastDay ? Colors.grey : Colors.transparent,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                '$dayNumber',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        } else {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          );
        }
      },
    );
  }
}
