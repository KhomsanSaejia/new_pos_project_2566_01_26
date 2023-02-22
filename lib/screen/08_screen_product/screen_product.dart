import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screen_product_mobile.dart';
import 'screen_product_tablet.dart';
import 'screen_product_web.dart';

class ScreenProduct extends StatefulWidget {
  const ScreenProduct({super.key});

  @override
  State<ScreenProduct> createState() => _ScreenProductState();
}

class _ScreenProductState extends State<ScreenProduct> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenProduct(),
        landscape: (context) => const MobileScreenProduct(),
      ),
      tablet: const TabletScreenProduct(),
      desktop: const WebScreenProduct(),
    );
  }
}