import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:livescroe/Services/api.dart';


class leagueStanding extends StatefulWidget{
  String leagueCode;
  String leagueName;
  Color leagueColor;
  leagueStanding(this.leagueCode, this.leagueName, this.leagueColor);

  @override
  createState() => leagueStandingState(leagueCode, leagueName, leagueColor);
}

class leagueStandingState extends State<leagueStanding> {

  String leagueCode;
  String leagueName;
  Color leagueColor;
  leagueStandingState(this.leagueCode, this.leagueName, this.leagueColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: leagueColor),
      //backgroundColor: leagueColor,
      //appBar: AppBar(title: Text(leagueName), backgroundColor: leagueColor,),
      child: FutureBuilder(
        future: SoccerApi().getLeagueStandings(leagueCode),
        builder: (context, snapshot){
          if(snapshot.hasData == false){
            return Center(child: CircularProgressIndicator());
          }
          else{
            return Column(
              children: <Widget>[
                Padding(child: rankingRow(''), padding: EdgeInsets.fromLTRB(0, 10, 0, 0),),
                Divider(
                  color: Colors.white,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, i){
                      return Padding(
                          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Divider(color: Colors.white, height: 15, )
                      );
                    },
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i){

                      return Container(
                        decoration: BoxDecoration(
                          color: leagueColor.withOpacity(0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        //padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: rankingRow(
                            snapshot.data[i].pos.toString(),
                            snapshot.data[i].teamInfo['name'],
                            snapshot.data[i].pts.toString(),
                            snapshot.data[i].playedGames.toString(),
                            snapshot.data[i].w.toString(),
                            snapshot.data[i].d.toString(),
                            snapshot.data[i].l.toString()
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

Widget rankingRow([String p = 'Pos' ,String t = 'Team', String pts = 'Pts', String mp = 'MP', String w = 'W', String d = 'D', String l= 'L']){
  return Row(
    children: <Widget>[
      Expanded(child:Center(child: Text(p, style: plStyle),), flex: 1,),
      Expanded(child:Text(t, style: plStyle), flex: 4,),
      Expanded(child:Text(mp, style: plStyle), flex: 1,),
      Expanded(child:Text(w, style: plStyle), flex: 1,),
      Expanded(child:Text(d, style: plStyle), flex: 1,),
      Expanded(child:Text(l, style: plStyle), flex: 1,),
      Expanded(child:Text(pts, style: plStyle), flex: 1,)
    ],

  );
}

final plStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
);



