import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/assets_path.dart';

class Screen_BG extends StatelessWidget {

  final Widget child;
  const Screen_BG({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(child: SvgPicture.asset(AssetPath.backgroundSVG,fit: BoxFit.cover,)),
        child,
      ],
    );
  }
}
