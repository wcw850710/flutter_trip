import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _controller = PageController(initialPage: 0);
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  var _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _controller,
          onPageChanged: (i) {
            setState(() {
              _current = i;
            });
          },
          children: const [
            HomePage(),
            SearchPage(),
            TravelPage(),
            MyPage(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _current,
            onTap: (i) {
              _controller.jumpToPage(i);
              setState(() {
                _current = i;
              });
            },
            selectedLabelStyle: TextStyle(color: _activeColor),
            unselectedLabelStyle: TextStyle(color: _defaultColor),
            selectedItemColor: _activeColor,
            unselectedItemColor: _defaultColor,
            unselectedFontSize: 14.0,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '首頁',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: '搜索',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                label: '旅拍',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: '我的',
              ),
            ]));
  }
}
