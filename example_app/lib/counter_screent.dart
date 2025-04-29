import 'package:flutter/material.dart';
import 'package:example_app/utils.dart';


class CounterScreen extends StatefulWidget {
    const CounterScreen({super.key});

    @override
    State<CounterScreen> createState() => _CounterScreenState();

    
}

class _CounterScreenState extends State<CounterScreen> {

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
        body: Column(
            children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                        Expanded(
                          child: formattedContainer(imagePath: "anime_girl.png", colorScheme: colorScheme),),

                        Expanded(
                          child: formattedContainer(text: "Second Container", colorScheme:  colorScheme),
                          )
                      ],
                  ),
                  
                  ),

                Expanded(
                  child: formattedContainer(text: "Third Container",colorScheme: colorScheme)
                )
              ]
          ),

        backgroundColor: colorScheme.primary,


        bottomNavigationBar: NavigationBar(destinations: destinations, backgroundColor: colorScheme.primaryContainer,),
      );
    
  }
}

