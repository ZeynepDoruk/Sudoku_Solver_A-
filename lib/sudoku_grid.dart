import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudokusolver_ver1/model.dart';
class SudokuGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    return Consumer<SudokuModel>(builder: (context, model, child) {
        return Center(
          child: AspectRatio( aspectRatio: 1,
            child: Container( margin: EdgeInsets.all(20.0), 
              decoration: BoxDecoration( border: Border.all(color: Colors.black, width: 3.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (row) {
                  return Expanded(
                    child: Row(
                      children: List.generate(4, (col) {
                        return Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  width: (row % 2 == 0) ? 2.0 : 1.0,
                                  color: Colors.black,
                                ),
                                left: BorderSide(
                                  width: (col % 2 == 0) ? 2.0 : 1.0,
                                  color: Colors.black,
                                ),
                                right: BorderSide(
                                  width: (col == 3) ? 2.0 : 1.0,
                                  color: Colors.black,
                                ),
                                bottom: BorderSide(
                                  width: (row == 3) ? 2.0 : 1.0,
                                  color: Colors.black,
                                ),
                              ),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                model.sudokuHaritasi[row][col]?.toString() ?? '',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
