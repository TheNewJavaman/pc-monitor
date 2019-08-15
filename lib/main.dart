import 'package:flutter/material.dart';
import 'package:pc_monitor/intro_page_view.dart';
import 'dart:async';
import 'package:pc_monitor/data.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'package:screen/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pc_monitor/settings_page_view.dart';

void refreshData() {
  runApp(MyApp());

  get(new Uri.http("javaman.net:80", "/mahm"), headers: {"authorization": basicAuth}).then((result) {
    String xmlData = result.body; //xml
    xml2json.parse(xmlData); //json
    Map<String, dynamic> data = jsonDecode(xml2json.toParker()); //Map

    SharedPreferences.getInstance().then((result) {
      var dataCategories = [];
      prefs = result;

      for (var el in data["HardwareMonitor"]["HardwareMonitorEntries"]["HardwareMonitorEntry"]) {
        var name = el["srcName"];
        var unit = el["srcUnits"].toString();
        prefs.setBool(name.toString() + unit.toString(), true);
        if (prefs.getBool(name.toString() + unit.toString())) {
          dataCategories.add([el["srcName"], el["srcUnits"].toString()]);
        }
      }

      dataLength = dataCategories.length;

      for (var i = 0; i < dataCategories.length; i++) {
        var index = data["HardwareMonitor"]["HardwareMonitorEntries"]["HardwareMonitorEntry"].indexWhere((el) => el["srcName"] == dataCategories[i][0] && el["srcUnits"].toString() == dataCategories[i][1]);
        var dataString = data["HardwareMonitor"]["HardwareMonitorEntries"]["HardwareMonitorEntry"][index]["data"];
        var dataData = double.parse(
            double.parse(dataString).toStringAsFixed(1));
        var dataStringFormatted = dataData.toString() + dataCategories[i][1];
        if (graphData[dataCategories[i][0] + dataCategories[i][1]] == null) {
          graphData[dataCategories[i][0] + dataCategories[i][1]] = [];
          for (var j = 0; j < 480; j++) {
            graphData[dataCategories[i][0] + dataCategories[i][1]].add(0.0);
          }
        }
        if (graphData[dataCategories[i][0] + dataCategories[i][1]].length > 480) {
          graphData[dataCategories[i][0] + dataCategories[i][1]].removeAt(0);
        }

        graphData[dataCategories[i][0] + dataCategories[i][1]].add(dataData);
        sampleItems[dataCategories[i][0] + dataCategories[i][1]] = new IntroItem(
          title: dataStringFormatted,
          category: dataCategories[i][0],
        );
      }
    });
  });
}

void main() {
  Screen.keepOn(true);
  const dataTime = const Duration(milliseconds:63);
  new Timer.periodic(dataTime, (Timer t) => refreshData());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (currentView == 0) {
      return MaterialApp(
        title: 'PC Monitor',
        theme: ThemeData(
          primarySwatch: Colors.red,
          secondaryHeaderColor: Colors.white,
        ),
        color: Colors.red,
        home: IntroPageView(),
      );
    } else {
      return MaterialApp(
        title: 'PC Monitor',
        theme: ThemeData(
          primarySwatch: Colors.red,
          secondaryHeaderColor: Colors.white,
        ),
        color: Colors.red,
        home: SettingsPageView(),
      );
    }
  }
}
