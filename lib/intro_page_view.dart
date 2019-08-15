import 'package:flutter/material.dart';
import 'package:pc_monitor/data.dart';
import 'package:pc_monitor/intro_page_item.dart';
import 'package:pc_monitor/page_transformer.dart';
import 'package:pc_monitor/main.dart';

class IntroPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PC Monitor'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: SizedBox.fromSize(
          size: const Size.fromHeight(500.0),
          child: PageTransformer(
            pageViewBuilder: (context, visibilityResolver) {
              return PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: dataLength,
                itemBuilder: (context, index) {
                  globalIndex = index;
                  var item;
                  item = sampleItems[sampleItems.keys.elementAt(index)];
                  final pageVisibility =
                    visibilityResolver.resolvePageVisibility(index);
                  return IntroPageItem(
                    item: item,
                    pageVisibility: pageVisibility,
                  );
                },
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newView) {
          currentView = newView;
          runApp(MyApp());
        },
        currentIndex: currentView,
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

