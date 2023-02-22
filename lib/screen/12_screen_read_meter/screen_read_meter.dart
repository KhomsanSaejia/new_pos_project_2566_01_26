import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screen_read_meter_mobile.dart';
import 'screen_read_meter_tablet.dart';
import 'screen_read_meter_web.dart';



class ScreenReadMeter extends StatefulWidget {
  const ScreenReadMeter({super.key});

  @override
  State<ScreenReadMeter> createState() => _ScreenReadMeterState();
}

class _ScreenReadMeterState extends State<ScreenReadMeter> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenReadMeter(),
        landscape: (context) => const MobileScreenReadMeter(),
      ),
      tablet: const TabletScreenReadMeter(),
      desktop: const WebScreenReadMeter(),
    );
  }
}