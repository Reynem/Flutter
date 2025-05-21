import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic tac toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Tic tac toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<String> buttonValues = List.filled(9, '');
  List<List<int>> winCombinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];
  int xWin = 0;
  int yWin = 0;

  bool playerTurn = true;


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final boxSize = (screenWidth < screenHeight ? screenWidth : screenHeight) * 0.8;

    void doClearValues(){
      buttonValues = List.filled(9, '');
      return;
    }

    void doCheckDraw(){
      for (String k in buttonValues){
        if (k.isEmpty) return;
      }
      doClearValues();
    }

    String doCheckWin(){
      for (var combo in winCombinations){
        String a = buttonValues[combo[0]];
        String b = buttonValues[combo[1]];
        String c = buttonValues[combo[2]];
        if (a == b && b == c && c == 'X'){
          xWin++;
          doClearValues();
          return "X win";
        } else if (a == b && b == c && c == 'O'){
          yWin++;
          doClearValues();
          return 'O win';
        }
      }
      return '';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox( 
          width: boxSize,
          height: boxSize + 50,
          child: Column(
            children: [
              Text(
                "$xWin:$yWin",
                style: const TextStyle(
                  color: Colors.black,
                        fontSize: 30,
                ),
              ),
              
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  
                  children: List.generate(9, (index) {
                    return Padding(
                      padding: EdgeInsets.all(5),
                      child: MaterialButton(
                        onPressed: () {
                            setState(() {
                              if (buttonValues[index] == '' && playerTurn){
                                buttonValues[index] = 'X';
                                playerTurn = false;
                              } else if (buttonValues[index] == '' && !playerTurn){
                                buttonValues[index] = 'O';
                                playerTurn = true;
                              }
                              doCheckDraw();
                              doCheckWin();
                            });
                          },
                          color: Colors.blueAccent,
                          child: Text(
                            buttonValues[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                          )
                        )
                    );
                    
                  },
                  )
              )
            )
            ]
          )
          )
          ,
      )
    );
  }
}
