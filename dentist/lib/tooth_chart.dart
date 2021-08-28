import 'package:dentist/tooth.dart';
import 'package:flutter/material.dart';

class TeethChart extends StatefulWidget {
  const TeethChart({Key key}) : super(key: key);

  @override
  _TeethChartState createState() => _TeethChartState();
}

class _TeethChartState extends State<TeethChart> {
  List upperLeftTeeth = [11, 12, 13, 14, 15, 16, 17, 18],
      upperRightTeeth = [21, 22, 23, 24, 25, 26, 27, 28],
      lowerLeftTeeth = [41, 42, 43, 45, 46, 47, 48],
      lowerRightTeeth = [31, 32, 33, 34, 35, 36, 37, 38];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tooth charts'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upper Teeth
                  Row(
                    children: [
                      // left side
                      Container(
                        child: Row(
                          children: upperLeftTeeth.reversed
                              .map((tooth) => Tooth(
                                    toothIndex: tooth,
                                    type: 'all',
                                  ))
                              .toList(),
                        ),
                      ),

                      // right side
                      Container(
                        child: Row(
                          children: upperRightTeeth
                              .map((tooth) => Tooth(
                                    toothIndex: tooth,
                                    type: 'all',
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  // Lower Teeth
                  Row(
                    children: [
                      // left side
                      Container(
                        child: Row(
                          children: lowerLeftTeeth.reversed
                              .map((tooth) => Tooth(
                                    toothIndex: tooth,
                                    type: 'all',
                                  ))
                              .toList(),
                        ),
                      ),
                      // right side
                      Container(
                        child: Row(
                          children: lowerRightTeeth
                              .map((tooth) => Tooth(
                                    toothIndex: tooth,
                                    type: 'all',
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
