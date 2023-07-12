
import 'package:etime/DB/DB_Helper.dart';
import 'package:etime/DB/items.dart';
import 'package:etime/routes/route_names.dart';
import 'package:etime/routes/routes.dart';
import 'package:etime/utils/DropDownState.dart';
import 'package:etime/view_model/Pie_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
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

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(

            providers: [

              ChangeNotifierProvider<DropdownState>(create: (_) => DropdownState()),
            ChangeNotifierProvider<Pie_Chart_View_Model>(create: (_) => Pie_Chart_View_Model()),
      //  ChangeNotifierProvider<Provider2>(create: (_) => Provider2()),
        ],
        child:MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          initialRoute: RouteName.splashScreen,
          onGenerateRoute: Routes.generateRoute,
        )
        );
      },
    );
  }
}
