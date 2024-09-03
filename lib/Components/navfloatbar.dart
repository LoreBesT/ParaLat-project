import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';

class NavFloatBar extends StatefulWidget {
  NavFloatBar({super.key, this.index, this.funzioni});
  int? index;
  List<Widget>? funzioni;

  @override
  State<NavFloatBar> createState() => _NavFloatBarState();
}

class _NavFloatBarState extends State<NavFloatBar> {
  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Auth().isDarkTheme(context);
    return FloatingNavbar(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      selectedItemColor: Colors.deepPurple,
      backgroundColor:
          isDarkTheme ? Color.fromARGB(48, 0, 0, 0) : Colors.white,
      unselectedItemColor: isDarkTheme ? Colors.white : Colors.black,
      selectedBackgroundColor: Color.fromARGB(255, 250, 219, 255),
      elevation: 4,
      borderRadius: 20,
      // onTap: (int val) => setState(() => _index = val),
      onTap: (int val) {
        setState(() {
          widget.index = val;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.funzioni![val]),
        );
        // navigateWithCustomAnimation(context, widget.funzioni![val]);
      },
      currentIndex: widget.index,
      items: [
        FloatingNavbarItem(icon: Icons.home, title: 'Home'),
        FloatingNavbarItem(icon: Icons.newspaper, title: 'Notizie'),
        FloatingNavbarItem(icon: Icons.settings, title: 'Impostazioni'),
      ],
    );
  }
}
