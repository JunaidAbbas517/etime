import 'package:etime/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../view/splash_screen.dart';
import '../DB/DB_Helper.dart';
import '../view/dashboard_screen.dart';
import '../view/pages/attendance_screen.dart';
import '../view/pages/home_screen.dart';
import '../view/pages/leaves_screen.dart';
import '../view/pages/od_screen.dart';
import '../view/pages/shift_screen.dart';
import '../view_model/Pie_chat_view_model.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    DateTime now = DateTime.now();
    String presentMonth = DateFormat.MMMM().format(now);
    int presentYear = now.year;
   // final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.dashBoardScreen:
        return MaterialPageRoute(builder: (_) => const DashBoardScreen());
      case RouteName.attendanceScreen:
        return MaterialPageRoute(builder: (_) => const AttendanceScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteName.leavesScreen:
        return MaterialPageRoute(builder: (_) =>  LeavesScreen(filteredList: [], status: 'All', selectedMonth: presentMonth, SelectedYear: presentYear,));
      case RouteName.odScreen:
        return MaterialPageRoute(builder: (_) => const OdScreen());
      case RouteName.shiftScreen:
        return MaterialPageRoute(builder: (_) => const ShiftScreen());
      case RouteName.DbhelperScreen:
        return MaterialPageRoute(builder: (_) => DbHelperScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
