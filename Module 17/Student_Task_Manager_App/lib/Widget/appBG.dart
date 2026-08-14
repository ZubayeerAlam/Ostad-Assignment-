import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/assets_path.dart';

class appBG extends StatelessWidget {
  final Widget child;
  const appBG({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: SvgPicture.asset(
            AssetPath.backgroundSVG,
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
