import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view_model/splash_view_model.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices services = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    services.isLogIn(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Text(
            'ETimeTrackLite',
            style: GoogleFonts.aBeeZee(
              fontSize: 40,
            ),
          ),
        ),
      ),
    );
  }
}
