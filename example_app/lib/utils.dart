import 'package:flutter/material.dart';


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

   MaterialButton formattedButton(String text){
    return MaterialButton(
      onPressed: () {},
      focusColor: const Color.fromARGB(255, 25, 80, 125),
      hoverColor: const Color.fromARGB(255, 36, 126, 199),
      color: Colors.blue,
      textColor: Colors.white,
      height: double.maxFinite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text),
    );
  }