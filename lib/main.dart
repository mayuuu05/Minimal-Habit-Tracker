import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:habit_tracker/view/home_screen/home_screen.dart';
import 'package:habit_tracker/view/intro_screen/intro_screen.dart';
import 'package:habit_tracker/view/splash_screen/splash_screen.dart';
import 'package:habit_tracker/view/track_report_page/track_report_page.dart';
import 'package:provider/provider.dart';

import 'database/habit_database.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDataBase.initialize();
  await HabitDataBase().saveFirstLaunchDate();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => HabitDataBase()),
    ],
    child: const HabitTracker(),
  ));
}

class HabitTracker extends StatelessWidget {
  const HabitTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/intro',
          page: () => const IntroScreen(),
        ),
        GetPage(
          name: '/home',
          page: () =>  HomePage(),
        ),
        GetPage(
          name: '/report',
          page: () =>  TrackReportPage(),
        ),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
