import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class IntroItem {
  IntroItem({
    this.title,
    this.category,
    this.imageUrl,
  });

  var title;
  var category;
  var imageUrl;
}

Map<String, dynamic> sampleItems = new Map();
Map<String, List<double>> graphData = new Map();

var globalIndex;
final Xml2Json xml2json = Xml2Json();

var username = "MSIAfterburner";
var password = "yuh";
var basicAuth = "Basic " + base64Encode(utf8.encode("$username:$password"));

var fpsFixedHeight = true;

var dataLength = 0;
var prefs;

var currentView = 0;

//SharedPreferences.getInstance().then((result) => prefs = result);