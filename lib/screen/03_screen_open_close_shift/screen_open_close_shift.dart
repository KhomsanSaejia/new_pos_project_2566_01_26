import 'package:flutter/material.dart';

import 'package:responsive_builder/responsive_builder.dart';

import '../../model/model_user.dart';
import 'screen_open_close_shift_mobile.dart';
import 'screen_open_close_shift_tablet.dart';
import 'screen_open_close_shift_web.dart';

class ScreenOpenCloseShift extends StatefulWidget {
  final ModelUser modelUser;
  const ScreenOpenCloseShift({super.key, required this.modelUser});

  @override
  State<ScreenOpenCloseShift> createState() => _ScreenOpenCloseShiftState();
}

class _ScreenOpenCloseShiftState extends State<ScreenOpenCloseShift> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenOpenCloseShift(),
        landscape: (context) => const MobileScreenOpenCloseShift(),
      ),
      tablet: const TabletScreenOpenCloseShift(),
      desktop: WebScreenOpenCloseShift(
        modelUser: widget.modelUser,
      ),
    );
  }
}
