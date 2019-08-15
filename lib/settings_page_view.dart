import 'package:flutter/material.dart';
import 'package:pc_monitor/data.dart';
import 'package:pc_monitor/main.dart';
import 'package:scoped_model/scoped_model.dart';

class SettingsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PC Monitor'),
        backgroundColor: Colors.red,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentView,
        onTap: (newView) {
          currentView = newView;
          runApp(MyApp());
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            title: new Text('Settings'),
          ),
        ],
      ),
    );
  }
}
