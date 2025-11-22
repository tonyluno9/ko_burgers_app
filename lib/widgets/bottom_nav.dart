import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNav extends StatelessWidget {
  final int index;
  const BottomNav({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      selectedItemColor: Colors.blue,
      onTap: (i) {
        if (i == 0) context.go('/home');
        if (i == 1) context.go('/menu');
        if (i == 2) context.go('/chat');
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.article), label: "News"),
        BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Menú"),
        BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "KAY/O"),
      ],
    );
  }
}
