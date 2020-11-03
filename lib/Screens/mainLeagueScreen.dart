import 'package:flutter/material.dart';
import 'package:livescroe/widgets/standings.dart';
import 'package:livescroe/widgets/topScorers.dart';
import 'package:livescroe/widgets/upcomingMatches.dart';



class mainLeagueScreen extends StatefulWidget {

  String leagueName;
  String leagueCode;
  Color leagueColor;

  mainLeagueScreen(this.leagueName, this.leagueCode,this.leagueColor);

  createState() => mainLeagueScreenState(leagueName, leagueCode,leagueColor);

}

class mainLeagueScreenState extends State<mainLeagueScreen>{

  String leagueName;
  String leagueCode;
  Color leagueColor;

  mainLeagueScreenState(this.leagueName, this.leagueCode,this.leagueColor);
  Widget screenContent = Container();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text(leagueName),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(text: 'Matches',),
                  Tab(text: 'Standings',),
                  Tab(text: 'Scorers',)
                ],
              ),
              backgroundColor: leagueColor,
            ),
            body: TabBarView(
              children: <Widget>[
                upcomingMatches(leagueCode, leagueColor),
                leagueStanding(leagueCode, leagueName, leagueColor),
                topScorers(leagueCode, leagueColor)
              ],
            ),
          )),
    );
  }

  void displayStandings(){
    setState(() {
      screenContent = leagueStanding('PL', leagueName, leagueColor);
    });
  }

  void displayMatches(){
    setState(() {
      screenContent = upcomingMatches(leagueCode, leagueColor);
    });
  }
}