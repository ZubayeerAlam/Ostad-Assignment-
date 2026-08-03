import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.PColor,
      leading: Icon(Icons.menu, color: Colors.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "All tasks",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 22),
          ),

          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
