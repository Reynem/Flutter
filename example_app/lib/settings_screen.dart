library;

import 'package:example_app/utils.dart';
import 'package:flutter/material.dart';


ValueNotifier<String> githubNameUser = ValueNotifier<String>("Reynem");

class SettingsScreen extends StatefulWidget {
    const SettingsScreen({super.key});

    @override
    State<SettingsScreen> createState() => _SettingsScreenState();

    
}

class _SettingsScreenState extends State<SettingsScreen> {
  
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final ColorScheme colorScheme = theme.colorScheme;

    final List<Widget> destinations = [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: formattedButton("Home", context),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: formattedButton("Settings", context),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: formattedButton("Profile", context),
      ),
    ];
    
    
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a github username',
                  fillColor: Colors.black,
                  
                ),
                onChanged: (value) {
                  githubNameUser.value = value;
                },
                
              )
              
            ),
          ),
      backgroundColor: colorScheme.primaryContainer,
      bottomNavigationBar: NavigationBar(destinations: destinations, backgroundColor: colorScheme.primaryContainer,),
            
    );
      

  }
}
