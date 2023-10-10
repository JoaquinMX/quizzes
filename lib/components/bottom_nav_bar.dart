import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.graduationCap),
          label: 'Topics',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.bolt),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.circleUser),
          label: 'Profile',
        )
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            break;
          case 1:
            Navigator.pushNamed(context, '/about');
            break;
          case 2:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
