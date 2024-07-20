import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static const String Player_X = "X";
  static const String Player_O = "O";
  String lastPlayer= '';
  bool iswinner=false;

  late String currentPlayer;
  late bool gameEnd;
  late List<String> occupied;
  



  @override

  void initState(){
    initializeGame();
    super.initState();
  }

  void initializeGame(){
    currentPlayer = Player_X;
    gameEnd = false;
    occupied = ["","","","","","","","",""];
  }

  


  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Tic Tac Toe Game',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent
              ),
              ),
              Text("The Player $currentPlayer Turn",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              ),
              Container(
                width: double.infinity,
                height: 430,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  ),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, index){
                    return GestureDetector(
                      onTap: iswinner? null :  () {
                        checkForWinner();
                        if (gameEnd || occupied[index].isNotEmpty){
                          return;
                        }
                        setState(() {
                          occupied[index] = currentPlayer;
                          if (currentPlayer == Player_X) {
                            currentPlayer = Player_O;
                            lastPlayer = Player_X;
                                               
                          }
                          else
                          {
                            currentPlayer = Player_X;
                            lastPlayer = Player_O;
                          }
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: occupied[index].isEmpty? Colors.blueAccent:occupied[index]==Player_X? Colors.orangeAccent: Colors.limeAccent,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Center(
                          child: Text(occupied[index],
                          style: const TextStyle(
                            fontSize: 36,
                          ),
                          )
                          ),
                      ),
                    );
                  },
                  ),
              ),
              ElevatedButton.icon(
                onPressed: (){
                  setState(() {
                    initializeGame();
                  });
                },
                icon: const Icon(Icons.replay),
                label: const Text('Repeat The Game',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
                )
                ),
                const SizedBox(
                  height: 50,
                ),
                // Text(
                //   'The Winner Is $lastPlayer',
                // style: const TextStyle(
                //   fontSize: 32,
                //   fontWeight: FontWeight.bold,
                //   color: Colors.white,
                // ),
                // ),
            ],
          ),
        ),
      ),
    );
  }


  checkForWinner(){
    List <List<int>> winningList=[
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6],
    ];
    
    for(var winningPos in winningList){
      String playerPostion0 = occupied[winningPos[0]];
      String playerPostion1 = occupied[winningPos[1]];
      String playerPostion2 = occupied[winningPos[2]];

      if(playerPostion0.isNotEmpty){
        if (playerPostion0 == playerPostion1 && playerPostion0 == playerPostion2) {
          showGameOverMessage("Player $playerPostion0 Won" );
          gameEnd = true;
          return;
        }
      }
    }
  }
showGameOverMessage(String message){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Center(child: Text('  Game Over \n$message',
    style: const TextStyle(
      color: Colors.orangeAccent,
      fontSize: 30,
    ),
    )))
    );
  
}

}