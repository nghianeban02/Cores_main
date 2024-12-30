import 'package:cores_project/utils/app_assets.dart';
import 'package:cores_project/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                AppAssets.home,
                color: _selectedIndex == 0 ? Colors.white : Colors.grey,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: SvgPicture.asset(
                AppAssets.bell,
                color: _selectedIndex == 1 ? Colors.white : Colors.grey,
              ),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: SvgPicture.asset(
                AppAssets.comment,
                color: _selectedIndex == 2 ? Colors.white : Colors.grey,
              ),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: SvgPicture.asset(
                AppAssets.user,
                color: _selectedIndex == 3 ? Colors.white : Colors.grey,
              ),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}