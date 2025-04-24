import 'package:flutter/material.dart';

void main() => runApp(RootApp());

class RootApp extends StatelessWidget {
  const RootApp({super.key});
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      home: CounterScreen()
    );
  }

  MaterialButton formattedButton(String text){
    return MaterialButton(
      onPressed: () {},
      focusColor: const Color.fromARGB(255, 25, 80, 125),
      hoverColor: const Color.fromARGB(255, 36, 126, 199),
      color: Colors.blue,
      child: Text(text),
    );
  }

  // Scaffold
  
  }

class CounterScreen extends StatefulWidget {
    const CounterScreen({super.key});

    @override
    State<CounterScreen> createState() => _CounterScreenState();

    
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> destinations = [ formattedH2Text("Home"), 
        formattedH2Text("Settings"), 
        formattedH2Text("Profile")];

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: formattedH2Text(counter.toString()),
          ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _incrementCounter();
          },
          tooltip: "Like",
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: const Icon(Icons.thumb_up),
          ),

        backgroundColor: Color(Colors.deepOrange.toARGB32()),
        appBar: AppBar(
          title: const Text("My App"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),

        bottomNavigationBar: NavigationBar(destinations: destinations),
      );
  }
  Text formattedH2Text(String text){
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 28,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
