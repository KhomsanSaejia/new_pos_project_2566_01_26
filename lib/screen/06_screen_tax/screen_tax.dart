import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screen_tax_mobile.dart';
import 'screen_tax_tablet.dart';
import 'screen_tax_web.dart';



class ScreenTax extends StatefulWidget {
  const ScreenTax({super.key});

  @override
  State<ScreenTax> createState() => _ScreenTaxState();
}

class _ScreenTaxState extends State<ScreenTax> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenTax(),
        landscape: (context) => const MobileScreenTax(),
      ),
      tablet: const TabletScreenTax(),
      desktop: const WebScreenTax(),
    );
  }
}