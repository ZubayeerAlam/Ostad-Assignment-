import 'package:flutter/material.dart';

import '../Utils/app_colors.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String? appBarTitle;
  final bool showSearch;
  const Appbar({super.key, this.appBarTitle, this.showSearch = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.PColor,
      leading: Icon(Icons.menu, color: Colors.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            appBarTitle != null ? appBarTitle! : "All task",
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 22),
          ),

          if (showSearch)
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
