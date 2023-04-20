import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: ThemeColors.backgroundColor,
      centerTitle: true,
      title: const Text('Offerte lavoro Flutter'),
      bottom: const TabBar(
        tabs: [
          Tab(
            text: 'Assunzioni',
          ),
          Tab(
            text: 'Freelance',
          ),
        ],
      ),
    );
  }
}