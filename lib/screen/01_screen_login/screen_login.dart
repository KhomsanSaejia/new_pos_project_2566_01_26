import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screen_login_mobile.dart';
import 'screen_login_tablet.dart';
import 'screen_login_web.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenLogin(),
        landscape: (context) => const MobileScreenLogin(),
      ),
      tablet: const TabletScreenLogin(),
      desktop: const WebScreenLogin(),
    );
  }
}
