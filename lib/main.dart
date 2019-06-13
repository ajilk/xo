import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'settings.dart';

/* GOAL: Separate logic from UI */ 

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: XO(),
        ),
      );
    },
  );
}

Widget _pill(String msg,
    {Color color = const Color.fromRGBO(234, 234, 234, 1.0)}) {
  return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: new BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
      width: 150,
      height: 50,
      child: Center(child: Text(msg)));
}

class UserA extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      _pill('9', color: Color.fromRGBO(0, 209, 205, 1.0));
}

class UserB extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      _pill('7', color: Color.fromRGBO(243, 0, 103, 1.0));
}

class Score extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          UserA(),
          UserB(),
        ],
      ),
    );
  }
}

class Board extends StatefulWidget {
  @override 
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {
  List< List<Tile> > _board = [
    [Tile(), Tile(), Tile()],
    [Tile(), Tile(), Tile()],
    [Tile(), Tile(), Tile()]
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(234, 234, 234, 1.0),
        borderRadius: new BorderRadius.all(
          const Radius.circular(10.0),
        ),
      ),
      height: 350.0,
      width: 350.0,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [ _board[0][0], _board[0][1], _board[0][2] ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [ _board[1][0], _board[1][1], _board[1][2] ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [ _board[2][0], _board[2][1], _board[2][2] ]),
          ]
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  @override
  TileState createState() => TileState();
}

class TileState extends State<Tile> {
  int _value = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      height: 110,
      width: 110,
      child: Center(child: Text('$_value')),
    );
  }
}

class Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _pill('new game'),
              _pill('undo'),
            ],
          ),
          GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails details) =>
                print('goTo [Settings]'),
            onTap: () => print('goTo [Settings]'),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                  opacity: 0.4,
                  child: Icon(
                    Icons.arrow_upward,
                  )),
              width: 400,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }
}

class XO extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(40, 60, 40, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(child: Image.asset('images/xo.png', width: 100)),
              Score(),
              Board(),
              Actions(),
              Settings(),
            ],
          ),
        ),
      ),
    );
  }
}
