import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:livescroe/models/SoccerModel.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);
int index=0;
List<String>x=[
  "a05a6f99a56e0f1b12a986b2b9a95786",

"bc559a6bda4706ffe475c558f48406cf",
"10984245e317511e0a1971fb444bc501",
"5f1d6c9db72c3922ee4051d1ae5a7846",
"0269c5beee06fbe0f13f0fac8ff24c09",
"ead8e1cc138505b94834141521b8b4c3" ,

];
//a05a6f99a56e0f1b12a986b2b9a95786
//bc559a6bda4706ffe475c558f48406cf
//10984245e317511e0a1971fb444bc501
//5f1d6c9db72c3922ee4051d1ae5a7846
//0269c5beee06fbe0f13f0fac8ff24c09
//ead8e1cc138505b94834141521b8b4c3
class SoccerApi {
  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    'x-rapidapi-key': "a05a6f99a56e0f1b12a986b2b9a95786",
  };

  Future<List<SoccerMatch>> getAllMatches(int num) async {
    Response res = await get(
        "https://v3.football.api-sports.io/fixtures?season=2020&league=$num&date=$formattedDate",
        headers: headers);

    if (res.statusCode == 200) {
      // this mean that we are connected to the data base
      var body = jsonDecode(res.body);
      List<dynamic> matchesList = body['response'];
      print("Ruslat : ${body["results"]}");
      print("errorserrorserrors : ${body["errors"]['requests']}");
      print("Api service: ${matchesList}"); // to debug
      List<SoccerMatch> matches = matchesList
          .map((dynamic item) => SoccerMatch.fromJson(item))
          .toList();

      return matches;
    }
  }
}
