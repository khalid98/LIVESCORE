import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:livescroe/Services/api.dart';

class topScorers extends StatefulWidget{
  String leagueCode;
  Color leagueColor;
  topScorers(this.leagueCode, this.leagueColor);
  createState() => topScorersState(leagueCode, leagueColor);
}

class topScorersState extends State<topScorers>{

  String leagueCode;
  Color leagueColor;
  topScorersState(this.leagueCode, this.leagueColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: leagueColor,
      child: FutureBuilder(
        future: SoccerApi().getScorers(leagueCode),
        builder: (context, snapshot){
          if(snapshot.data == null)
            return Center(child: CircularProgressIndicator());
          else{
            return Column(
              children: <Widget>[
                Padding(child: rankingRow(''), padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                Divider(color: Colors.white),
                Expanded(child:

                ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (context, i){
                    return Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Divider(color: Colors.white,),
                    );
                  },

                  itemBuilder: (context, i){
                    int playerRank = i +1;
                    return Container(
                      decoration: BoxDecoration(
                        color: leagueColor.withOpacity(0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      child: rankingRow(
                        playerRank.toString(),
                        snapshot.data[i].name,
                        snapshot.data[i].teamName,
                        snapshot.data[i].goalNum
                      ),
                    );
                  },
                ))
              ],
            );
          }
        },
      ),
    );
  }
}

Widget rankingRow([String pos = '', String name = 'Player', String team = 'Team',String goalNum = 'Goals']){
  return Row(
    children: <Widget>[
      Expanded(child: Center(child:Text(pos, style: plStyle)), flex: 1),
      Expanded(child: Padding(child:Text(name, style: plStyle),padding: EdgeInsets.fromLTRB(5, 0, 5, 0),), flex: 4),
      Expanded(child: Padding(child:Text(team, style: plStyle),padding: EdgeInsets.fromLTRB(5, 0, 5, 0),), flex: 4),
      Expanded(child: Text(goalNum, style: plStyle), flex: 2,)
    ],
  );
}

final plStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
);