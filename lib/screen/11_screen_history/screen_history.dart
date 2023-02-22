import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screen_history_mobile.dart';
import 'screen_history_tablet.dart';
import 'screen_history_web.dart';



class ScreenHistory extends StatefulWidget {
  const ScreenHistory({super.key});

  @override
  State<ScreenHistory> createState() => _ScreenHistoryState();
}

class _ScreenHistoryState extends State<ScreenHistory> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenHistory(),
        landscape: (context) => const MobileScreenHistory(),
      ),
      tablet: const TabletScreenHistory(),
      desktop: const WebScreenHistory(),
    );
  }
}