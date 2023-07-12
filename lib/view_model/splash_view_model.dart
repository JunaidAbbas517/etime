import 'dart:async';

import 'package:flutter/material.dart';


import '../routes/route_names.dart';

class SplashServices {
  void isLogIn(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushNamed(
        context,
        RouteName.dashBoardScreen,
      ),
    );
  }
}
