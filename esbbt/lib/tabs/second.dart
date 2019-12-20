import 'package:flutter/material.dart';
import '../wview1.dart';

class SecondTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // child: MyHomePage(title: 'About Us'),
        child: WebViewInFlutter(),
      ),
    );
  }
}

