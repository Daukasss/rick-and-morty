import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/pages/character_page.dart';
import '../pages/selected_page.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            const TabBarView(
              children: [
                CharacterPage(),
                SelectedPage(),
              ],
            ),
            Positioned(
              height: 60,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.grey.withOpacity(0.2),
                child: const TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.home),
                    ),
                    Tab(
                      icon: Icon(Icons.select_all),
                    ),
                  ],
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.red,
                  unselectedLabelColor: Color(0xff999999),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
