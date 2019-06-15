/// Implements Game board and logic

import 'player.dart';

enum Value { X, O, N, }

class Game {
  /* FIELDS */
  Player _O, _X;
  static const int SIZE = 3;
  List< List<Value> >  _board = new List< List<Value> >(SIZE);
  Value turn = Value.X; // specifies whose turn it is

  /* GETTERS - SETTERS */
  Player get O => _O;
  Player get X => _X;
  List< List<Value> > get board => _board;

  /* CONSTRUCTORS */
  Game() {
    Player _O = new Player();
    Player _X = new Player();

    // Initialize Board
    for(int i=0; i<SIZE; i++){
      List<Value> row = new List<Value>(SIZE);
      for(int j=0; j<SIZE; j++){
        row[j] = Value.N;
      } _board[i] = row;
    }
  }

  void newGame() {
    // _O.score = 0;
    // _X.score = 0;

    // Reset Board
    for(int i=0; i<SIZE; i++){
      List<Value> row = new List<Value>(SIZE);
      for(int j=0; j<SIZE; j++){
        row[j] = Value.N;
      } _board[i] = row;
    } 
  }
}
