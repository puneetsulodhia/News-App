import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import 'package:http/http.dart' as http;

Future<List> rssToJson(String category,
    {String baseUrl = 'https://www.hindustantimes.com/feeds/rss/'}) async {
  final myTranformer = Xml2Json();
  var url = Uri.parse(baseUrl + category + '/rssfeed.xml');
  http.Response response = await http.get(url);
  myTranformer.parse(response.body);
  var json = myTranformer.toGData();
  var result = jsonDecode(json)['rss']['channel']['item'];
  if (!(result is List<dynamic>)) {
    return [result];
  }
  return result;
}