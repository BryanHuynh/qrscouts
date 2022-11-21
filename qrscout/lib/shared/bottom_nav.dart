import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.house,
            size: 20,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.book,
            size: 20,
          ),
          label: 'Collections',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.gears,
            size: 20,
          ),
          label: 'settings',
        ),
      ],
      fixedColor: Colors.deepPurple[200],
      onTap: (int idx) {
        // if (idx == currentIndex) return;
        switch (idx) {
          case 0:
            Navigator.popAndPushNamed(context, '/dashboard');
            break;
          case 1:
            Navigator.popAndPushNamed(context, '/collections');
            break;
          case 2:
            Navigator.popAndPushNamed(context, '/settings');
            break;
        }
      },
    );
  }
}
