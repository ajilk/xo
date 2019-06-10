import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class Board extends StatelessWidget {
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
      width: 400.0,
    );
  }
}

class Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _pill('new game'),
          _pill('undo'),
        ],
      ),
    );
  }
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) =>
          print('goTo [Settings]'),
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
