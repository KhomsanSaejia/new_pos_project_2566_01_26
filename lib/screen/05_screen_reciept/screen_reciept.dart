import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screen_reciept_mobile.dart';
import 'screen_reciept_tablet.dart';
import 'screen_reciept_web.dart';


class ScreenReciept extends StatefulWidget {
  const ScreenReciept({super.key});

  @override
  State<ScreenReciept> createState() => _ScreenRecieptState();
}

class _ScreenRecieptState extends State<ScreenReciept> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenReciept(),
        landscape: (context) => const MobileScreenReciept(),
      ),
      tablet: const TabletScreenReciept(),
      desktop: const WebScreenReciept(),
    );
  }
}