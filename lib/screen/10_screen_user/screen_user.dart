import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screen_user_mobile.dart';
import 'screen_user_tablet.dart';
import 'screen_user_web.dart';



class ScreenUser extends StatefulWidget {
  const ScreenUser({super.key});

  @override
  State<ScreenUser> createState() => _ScreenUserState();
}

class _ScreenUserState extends State<ScreenUser> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenUser(),
        landscape: (context) => const MobileScreenUser(),
      ),
      tablet: const TabletScreenUser(),
      desktop: const WebScreenUser(),
    );
  }
}