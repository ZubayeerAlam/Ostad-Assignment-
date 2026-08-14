import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/assets_path.dart';

class screenBG extends StatelessWidget {
  final Widget child;
  const screenBG({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.asset(
            AssetPath.splashBG,
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
