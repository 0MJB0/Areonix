import 'package:flutter/material.dart';

import '../../../../core/constants/index.dart';

mixin TabDieticianUIMixin<T extends StatefulWidget> on State<T> {
  Container buildMemberTabNavigationBar(
      int currentIndex, ValueChanged<int> onTap) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: TColor.black,
        unselectedItemColor: TColor.airforce,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check_circle_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.developer_mode),
            label: '',
          ),
        ],
      ),
    );
  }
}
