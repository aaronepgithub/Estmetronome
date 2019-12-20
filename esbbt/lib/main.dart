import 'package:flutter/material.dart';
import 'tabs/first.dart';
import 'tabs/second.dart';
import 'tabs/third.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESBBT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [SecondTab(), FirstTab(), ThirdTab()];

  void _onBottomNavBarTab(int index) {
    
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset('assets/curesma2.png'),
          Text('ESBBT/ESNHPT'),
        ],
      )),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavBarTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account),
            title: Text('About Us'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            title: Text('Timer'),
          )
        ],
      ),
    );
  }
}
