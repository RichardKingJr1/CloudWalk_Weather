import 'package:flutter/material.dart';

class AppBotton extends StatefulWidget {
  var cont;
  int selectedIndex;

  AppBotton({Key? key, required this.cont, required this.selectedIndex})
      : super(key: key);

  @override
  _AppBottonState createState() => _AppBottonState();
}

class _AppBottonState extends State<AppBotton> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: widget.selectedIndex,
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.home), label: '' ),
        const BottomNavigationBarItem(
            icon: Icon(Icons.abc), label: '' ),
      ],
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      onTap: onTap,
    );
  }

  void onTap(int index) {
    setState(() {
      switch (index) {
        case 0:
          Navigator.of(widget.cont)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          break;
        case 1:
          Navigator.of(widget.cont)
              .pushNamedAndRemoveUntil('/forecast', (Route<dynamic> route) => false);
          break;
      }
    });
  }
}
