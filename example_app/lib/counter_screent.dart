import 'package:flutter/material.dart';
import 'package:example_app/utils.dart';


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
    final theme = Theme.of(context); 
    final ColorScheme colorScheme = theme.colorScheme;

    final List<Widget> destinations = [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: formattedButton("Home"),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: formattedButton("Settings"),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: formattedButton("Profile"),
      ),
    ];

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: formattedContainer(counter.toString(), colorScheme),
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

        backgroundColor: colorScheme.primary,


        bottomNavigationBar: NavigationBar(destinations: destinations, backgroundColor: colorScheme.primaryContainer,),
      );
    
  }
}

