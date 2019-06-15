/// Implements Game board and logic

import 'player.dart';

enum Value {
  X,
  O,
  N,
}

class Game {
  /* FIELDS */
  Player _O, _X;
  static const int SIZE = 3;
  List<List<Value>> _board = new List<List<Value>>(SIZE);
  Value turn = Value.X; // specifies whose turn it is

  /* GETTERS - SETTERS */
  Player get O => _O;
  Player get X => _X;
  List<List<Value>> get board => _board;

  /* CONSTRUCTORS */
  Game() {
    _O = new Player();
    _X = new Player();

    // Initialize Board
    for (int i = 0; i < SIZE; i++) {
      List<Value> row = new List<Value>(SIZE);
      for (int j = 0; j < SIZE; j++) {
        row[j] = Value.N;
      }
      _board[i] = row;
    }
  }

  /// Clears Board
  void newGame() {
    for (int i = 0; i < SIZE; i++) {
      List<Value> row = new List<Value>(SIZE);
      for (int j = 0; j < SIZE; j++) {
        row[j] = Value.N;
      }
      _board[i] = row;
    }
  }

  /// Resets game and scores 
  void reset(){
    newGame();
    _O.score = 0;
    _X.score = 0;
  }

  Value over() {
    // Horizontal Wins
    if (board[0][0] == board[0][1] && board[0][1] == board[0][2]) {
      return board[0][0];
    }
    else if (board[1][0] == board[1][1] && board[1][1] == board[1][2]) {
      return board[1][0];
    }
    else if (board[2][0] == board[2][1] && board[2][1] == board[2][2]) {
      return board[2][0];
    }

    // Vertical Wins
    else if (board[0][0] == board[1][0] && board[1][0] == board[2][0]) {
      return board[0][0];
    }
    else if (board[0][1] == board[1][1] && board[1][1] == board[2][1]) {
      return board[0][1];
    }
    else if (board[0][2] == board[1][2] && board[1][2] == board[2][2]) {
      return board[0][2];
    }

    // Diagonal Wins
    else if (board[0][0] == board[1][1] && board[1][1] == board[2][2]) {
      return board[0][0];
    }
    else if (board[0][2] == board[1][1] && board[1][1] == board[2][0]) {
      return board[0][2];
    }

  // No wins yet
  return Value.N;
  }

  bool canMove() {
    for(int i=0; i<SIZE; i++){
      for(int j=0; j<SIZE; j++){
        if(board[i][j] == Value.N) return true;
      }
    }
    return false;
  }
}
