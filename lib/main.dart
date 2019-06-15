import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'settings.dart';
import 'game.dart';

/* GOAL: Separate logic from UI */
/* GOAL: Remove duplicate code | lift state up */
/* FEATURE: Indicate whose turn it is */

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

Widget _buildControl(String msg,
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

class Score extends StatelessWidget {
  final int x, o;
  Score({this.x, this.o});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildControl(x.toString(), color: Color.fromRGBO(0, 209, 205, 1.0)),
          _buildControl(o.toString(), color: Color.fromRGBO(243, 0, 103, 1.0)),
        ],
      ),
    );
  }
}

Image _icon(Value value) {
  switch (value) {
    case Value.X:
      return Image.asset('images/x.png');
      break;
    case Value.O:
      return Image.asset('images/o.png');
      break;
    case Value.N:
      return null;
      break;
  }
  return null;
}


class Board extends StatefulWidget {
  @override
  BoardState createState() => BoardState();
}

class BoardState extends State<Board> {
  Game game;
  bool over = false;

  BoardState() {
    game = new Game();
  }

  Widget _buildSquare(int i, int j) {
    return GestureDetector(
      onTap: () => setState(() {
            if (game.board[i][j] == Value.N) {
              game.board[i][j] = game.turn;
              game.turn = (game.turn == Value.X) ? Value.O : Value.X;
            }
            if(game.over() == Value.N && !game.canMove()) over = true;
            if(game.over() == Value.X || game.over() == Value.O) over = true;
          }),
      child: Square(value: game.board[i][j]),
    );
  }

  Widget _buildRow(int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSquare(i, 0),
        _buildSquare(i, 1),
        _buildSquare(i, 2),
      ],
    );
  }

  Widget _over() {
    if(game.over() == Value.X) game.X.score++;
    if(game.over() == Value.O) game.O.score++;
    return Container(
      child: _icon(game.over())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Score(o: game.O.score, x: game.X.score),
        Container(
          margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(234, 234, 234, 1.0),
            borderRadius: new BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          height: 350.0,
          width: 350.0,
          // This part is really bad (duplicate code) and soon will be fixed
          child: over ? _over() : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRow(0),
              _buildRow(1),
              _buildRow(2),
            ],
          ),
        ),
        // Actions(),
        // Temporarily here because I do not know
        // how to access data of the parent
        Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => setState(() { game.newGame(); over = false; } ),
                    onLongPress: () => setState( () { game.reset(); }),
                    child: _buildControl('new game'),
                  ),
                  _buildControl('undo'),
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
        )
      ],
    );
  }
}

class Square extends StatelessWidget {

  final Value value;
  Square({this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 110,
      width: 110,
      padding: EdgeInsets.all(10.0),
      child: Center(child: _icon(value)),
    );
  }
}

// class Actions extends StatelessWidget {
//   final Game game;
//   Actions({this.game});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
//       child: Column(
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               GestureDetector(
//                 onTap: () => print('oops'),
//                 child: _pill('new game'),
//               ),
//               _pill('undo'),
//             ],
//           ),
//           GestureDetector(
//             onVerticalDragUpdate: (DragUpdateDetails details) =>
//                 print('goTo [Settings]'),
//             onTap: () => print('goTo [Settings]'),
//             child: Container(
//               alignment: Alignment.bottomCenter,
//               child: Opacity(
//                   opacity: 0.4,
//                   child: Icon(
//                     Icons.arrow_upward,
//                   )),
//               width: 400,
//               height: 60,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
              // Score(), // inside board
              Board(),
              // Actions(), // <- inside board
              Settings(),
            ],
          ),
        ),
      ),
    );
  }
}
