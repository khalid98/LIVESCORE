import 'package:flutter/material.dart';
import 'package:livescroe/Screens/mainLeagueScreen.dart';
import 'package:livescroe/Services/api.dart';
import 'package:livescroe/models/SoccerModel.dart';
import 'package:livescroe/widgets/matchtile.dart';

Widget PageBody(context) {
  return Container(
    color: Colors.black87,
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    child: ListView(

      children: [
        //PL
        FutureBuilder(
          future: SoccerApi()
              .getAllMatches(39), //Here we will call our getData() method,
          builder: (context, snapshot) {
            //the future builder is very intersting to use when you work with api
            if (snapshot.hasData  && snapshot.data.length!=0) {
              List<SoccerMatch> allmatches = snapshot.data;
              print((snapshot.data).length);
              return AllMatches(context, allmatches,0);
            } else {
              return Center(
                child: Text(""),
              );
            }
          }, // here we will buil the app layout
        ),

        //la liga
        FutureBuilder(
          future: SoccerApi()
              .getAllMatches(140), //Here we will call our getData() method,
          builder: (context, snapshot) {
            //the future builder is very intersting to use when you work with api
            if (snapshot.hasData  && snapshot.data.length!=0) {
              List<SoccerMatch> allmatches = snapshot.data;
              print((snapshot.data).length);
              return AllMatches(context, allmatches,1);
            } else {
              return Center(
                child: Text(""),
              );
            }
          }, // here we will buil the app layout
        ),
        //French Ligue 1
        FutureBuilder(
          future: SoccerApi()
              .getAllMatches(61), //Here we will call our getData() method,
          builder: (context, snapshot) {
            //the future builder is very intersting to use when you work with api
            if (snapshot.hasData  && snapshot.data.length!=0) {
              List<SoccerMatch> allmatches = snapshot.data;
              print((snapshot.data).length);
              return AllMatches(context, allmatches,2);
            } else {
              return Center(
                child: Text(""),
              );
            }
          }, // here we will buil the app layout
        ),

        //Serie A
        FutureBuilder(
          future: SoccerApi()
              .getAllMatches(135), //Here we will call our getData() method,
          builder: (context, snapshot) {
            //the future builder is very intersting to use when you work with api
            if (snapshot.hasData  && snapshot.data.length!=0) {
              List<SoccerMatch> allmatches = snapshot.data;
              print((snapshot.data).length);
              return AllMatches(context, allmatches,3);
            } else {
              return Center(
                child: Text(""),
              );
            }
          }, // here we will buil the app layout
        ),

        //Bundesliga
        FutureBuilder(
          future: SoccerApi()
              .getAllMatches(78), //Here we will call our getData() method,
          builder: (context, snapshot) {
            //the future builder is very intersting to use when you work with api
            if (snapshot.hasData  && snapshot.data.length!=0) {
              List<SoccerMatch> allmatches = snapshot.data;
              print((snapshot.data).length);
              return AllMatches(context, allmatches,4);
            } else {
              return Center(
                child: Text(""),
              );
            }
          }, // here we will buil the app layout
        ),
        //UEFA Champions League
        FutureBuilder(
          future: SoccerApi()
              .getAllMatches(2), //Here we will call our getData() method,
          builder: (context, snapshot) {
            //the future builder is very intersting to use when you work with api
            if (snapshot.hasData && snapshot.data.length!=0) {
              List<SoccerMatch> allmatches = snapshot.data;
              print((snapshot.data).length);
              return AllMatches(context, allmatches,5);
            }
            else {
              return Center(
                child: Text(""),
              );
            }
          }, // here we will buil the app layout
        ),

        //UEFA Europa League
        FutureBuilder(
          future: SoccerApi()
              .getAllMatches(3), //Here we will call our getData() method,
          builder: (context, snapshot) {
            //the future builder is very intersting to use when you work with api
            if (snapshot.hasData && snapshot.data.length!=0) {
              List<SoccerMatch> allmatches = snapshot.data;
              print((snapshot.data).length);
              return AllMatches(context, allmatches,6);
            }
            else {
              return Center(
                child: Text(""),
              );
            }
          }, // here we will buil the app layout
        ),

      ],
    ),
  );
}

Widget AllMatches(context, List<SoccerMatch> allmatches,int index ) {
  return ExpansionTile(
      childrenPadding: EdgeInsets.all(8.0),
      initiallyExpanded: true,
      leading: Image.network(
        allmatches[0].league.logo,
        width: 36.0,
      ),
      title: GestureDetector(
        onTap: (){
          switch(index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => mainLeagueScreen('Premier League', 'PL',Color.fromRGBO(63, 16, 82, 1))
              ));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => mainLeagueScreen('La Liga', 'PD', Color.fromRGBO(0, 52, 114, 1))
              ));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => mainLeagueScreen('Ligue 1', 'FL1', Color.fromRGBO(227, 76, 38, 1))
              ));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (context) => mainLeagueScreen('Serie A', 'SA', Color.fromRGBO(29, 150, 71, 1))
              ));
              break;
            case 4:
              Navigator.push(context, MaterialPageRoute(builder: (context) =>mainLeagueScreen('Bundesliga', 'BL1', Color.fromRGBO(177, 40, 41, 1))
              ));
              break;
            case 5:
              Navigator.push(context, MaterialPageRoute(builder: (context) =>mainLeagueScreen('UEFA Champions League', 'CL', Color.fromRGBO(0, 52, 114, 1))
              ));
              break;

          }

        },


        child: Text(
          allmatches[0].league.name,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      children: <Widget>[
        for (int i = 0; i < allmatches.length; i++) matchTile(allmatches[i])
      ]);
}

