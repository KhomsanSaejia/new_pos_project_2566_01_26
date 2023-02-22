import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../model/model_user.dart';
import 'screen_home_mobile.dart';
import 'screen_home_tablet.dart';
import 'screen_home_web.dart';

class ScreenHome extends StatefulWidget {
  final ModelUser modelUser;
  const ScreenHome({super.key, required this.modelUser});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => MobileScreenHome(modelUser: widget.modelUser),
        landscape: (context) => MobileScreenHome(modelUser: widget.modelUser),
      ),
      tablet: TabletScreenHome(modelUser: widget.modelUser),
      desktop: WebScreenHomepage(modelUser: widget.modelUser),
    );
  }
}
