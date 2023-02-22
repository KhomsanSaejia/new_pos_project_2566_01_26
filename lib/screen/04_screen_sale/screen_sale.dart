import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../model/model_user.dart';
import 'screen_sale_mobile.dart';
import 'screen_sale_tablet.dart';
import 'screen_sale_web.dart';

class ScreenSale extends StatefulWidget {
  final ModelUser modelUser;
  const ScreenSale({super.key, required this.modelUser});

  @override
  State<ScreenSale> createState() => _ScreenSaleState();
}

class _ScreenSaleState extends State<ScreenSale> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      breakpoints:
          const ScreenBreakpoints(desktop: 1000, tablet: 550, watch: 500),
      mobile: OrientationLayoutBuilder(
        portrait: (context) => const MobileScreenSale(),
        landscape: (context) => const MobileScreenSale(),
      ),
      tablet: const TabletScreenSale(),
      desktop:  WebScreenSale(modelUser: widget.modelUser,),
    );
  }
}