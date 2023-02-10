import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view/common/localization/localization.dart';
import 'package:flutter_mvvm/view/page/about/about_page.dart';
import 'package:flutter_mvvm/view/page/artist/artists_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pages = [
    const ArtistsPage(),
    const AboutPage(),
  ];
  final pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(Localization.of(context).string('app_title')),
        centerTitle: true,
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: _pages,
        ),
      ),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  Widget _getBottomNavigationBar() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
          pageController.jumpToPage(_selectedIndex);
        });
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          label: Localization.of(context).string('home_title'),
        ),
        NavigationDestination(
          icon: const Icon(Icons.info_outlined),
          label: Localization.of(context).string('about_title'),
        ),
      ],
    );
  }
}
