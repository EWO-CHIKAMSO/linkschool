
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:linkschool/modules/common/constants.dart';
import 'app_navigation_flow.dart';
import 'package:introduction_screen/introduction_screen.dart';


class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:Constants.customScreenDec0ration(),
        child:PageView(
          children: [
            Container(
              color: Colors.amber,
              height: 400,
            ),
            Container(
              color: Colors.orange,
              height: 400,
            ),
            Container(
              color: Colors.green,
              height: 400,
            ),
          ],
        ),
    );
  }
}