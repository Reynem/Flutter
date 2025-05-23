import 'package:flutter/material.dart';
import 'package:example_app/settings_screen.dart';


class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});
  
  
  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Settings',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, brightness: Brightness.light),
        useMaterial3: true,
      ),
      
      home: SettingsScreen(),
    );
  }
  
  }
