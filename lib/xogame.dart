// lib/xogame.dart

import 'dart:io';

void startGame() {
  print("مرحباً بك في لعبة XO!");

  List<String> grid = List.filled(9, ' ');
  String currentPlayer = 'X';

  while (true) {
    printGrid(grid);

    int position;
    while (true) {
      print("اللاعب $currentPlayer اختار الخانة من 1 إلى 9:");
      String? input = stdin.readLineSync();
      position = int.tryParse(input ?? '') ?? -1;

      if (position >= 1 && position <= 9 && grid[position - 1] == ' ') {
        grid[position - 1] = currentPlayer;
        break;
      } else {
        print("إدخال غير صالح أو الخانة مشغولة. حاول مرة أخرى.");
      }
    }

    if (isWin(grid, currentPlayer)) {
      printGrid(grid);
      print("اللاعب $currentPlayer فاز!");
      break;
    }

    if (!grid.contains(' ')) {
      printGrid(grid);
      print("التعادل! لا يوجد فائز.");
      break;
    }

    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }
}

void printGrid(List<String> grid) {
  print("${grid[0]} | ${grid[1]} | ${grid[2]}");
  print("---------");
  print("${grid[3]} | ${grid[4]} | ${grid[5]}");
  print("---------");
  print("${grid[6]} | ${grid[7]} | ${grid[8]}");
}

bool isWin(List<String> grid, String player) {
  List<List<int>> winningConditions = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6],
  ];

  return winningConditions.any((combo) =>
    grid[combo[0]] == player &&
    grid[combo[1]] == player &&
    grid[combo[2]] == player);
}
