import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screen_safedrop_mobile.dart';
import 'screen_safedrop_tablet.dart';
import 'screen_safedrop_web.dart';


class ScreenSafedrop extends StatefulWidget {
  const ScreenSafedrop({super.key});

  @override
  State<ScreenSafedrop> createState() => _ScreenSafedropState();
}

class _ScreenSafedropState extends State<ScreenSafedrop> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenSafedrop(),
        landscape: (context) => const MobileScreenSafedrop(),
      ),
      tablet: const TabletScreenSafedrop(),
      desktop: const WebScreenSafedrop(),
    );
  }
}