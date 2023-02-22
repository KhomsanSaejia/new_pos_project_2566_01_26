import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screen_test_oil_mobile.dart';
import 'screen_test_oil_tablet.dart';
import 'screen_test_oil_web.dart';

class ScreenTestOil extends StatefulWidget {
  const ScreenTestOil({super.key});

  @override
  State<ScreenTestOil> createState() => _ScreenTestOilState();
}

class _ScreenTestOilState extends State<ScreenTestOil> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenTestOil(),
        landscape: (context) => const MobileScreenTestOil(),
      ),
      tablet: const TabletScreenTestOil(),
      desktop: const WebScreenTestOil(),
    );
  }
}