import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screen_inv_credit_mobile.dart';
import 'screen_inv_credit_tablet.dart';
import 'screen_inv_credit_web.dart';


class ScreenInvCredit extends StatefulWidget {
  const ScreenInvCredit({super.key});

  @override
  State<ScreenInvCredit> createState() => _ScreenInvCreditState();
}

class _ScreenInvCreditState extends State<ScreenInvCredit> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenInvCredit(),
        landscape: (context) => const MobileScreenInvCredit(),
      ),
      tablet: const TabletScreenInvCredit(),
      desktop: const WebScreenInvCredit(),
    );
  }
}