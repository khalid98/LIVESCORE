import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:livescroe/models/SoccerModel.dart';
import 'package:livescroe/models/match.dart';
import 'package:livescroe/models/teamStanding.dart';
import 'package:livescroe/models/topScorer.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);
final String token = 'c2928278d71247c3bcb7c4ccc89cc2c6';


class SoccerApi {
  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    'x-rapidapi-key': "8b26a123b0a62cabe0b8416e134431bd",
  };

  Future<List<SoccerMatch>> getAllMatches(int num) async {
    Response res = await get(
        "https://v3.football.api-sports.io/fixtures?season=2020&league=$num&date=2020-10-17",
        headers: headers);

    if (res.statusCode == 200) {
      // this mean that we are connected to the data base
      var body = jsonDecode(res.body);
      List<dynamic> matchesList = body['response'];
      print("Ruslat : ${body["results"]}");
      print("Api service: ${matchesList}"); // to debug
      List<SoccerMatch> matches = matchesList
          .map((dynamic item) => SoccerMatch.fromJson(item))
          .toList();

      return matches;
    }
  }
  Future<List<teamStanding>> getLeagueStandings(String leagueCode) async{
    Response r = await get(Uri.encodeFull('https://api.football-data.org/v2/competitions/$leagueCode/standings?standingType=TOTAL'),
        headers: {
          "X-Auth-Token" : token
        }
    );
    Map<String, dynamic> x = jsonDecode(r.body);
    List y = x['standings'];

    List<teamStanding> k = [];
    for(var i in y[0]['table']){
      k.add(new teamStanding(i['position'], i['team'], i['playedGames'], i['won'], i['draw'], i['lost'], i['points']));
    }

    return k;
  }
  Future<List<topScorer>> getScorers(String code) async{
    Response r = await get(Uri.encodeFull('https://api.football-data.org/v2/competitions/$code/scorers'),
        headers: {
          'X-Auth-Token' : token
        }
    );
    Map<String, dynamic> x = jsonDecode(r.body);
    List y = x['scorers'];
    List<topScorer> topScorersList = [];
    for(var i in y){
      topScorersList.add(new topScorer(i['player']['name'], i['team']['name'], i['numberOfGoals'].toString()));
    }

    return topScorersList;
  }
  Future<List<match>> getMatches(String code) async {
    Response r = await get(
        Uri.encodeFull(
            'https://api.football-data.org/v2/competitions/$code/matches?status=SCHEDULED'),
        headers: {"X-Auth-Token": token});

    Map<String, dynamic> x = jsonDecode(r.body);
    List y = x['matches'];

    List<match> extractedMatches = [];

    print(x.keys);
    for (var i in y) {
      extractedMatches.add(new match(
          i['homeTeam']['name'],
          i['awayTeam']['name'],
          i['utcDate'].toString().substring(5, 10),
          DateTime.parse(i['utcDate'])
              .toLocal()
              .toIso8601String()
              .substring(11, 16)));
    }

    return extractedMatches;
  }
}
