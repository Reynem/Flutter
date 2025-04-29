import 'package:flutter/material.dart';

const Color colorContainerOne = Color(0x90D5FF);
const Color colorContainerSecond = Color(0x57B9FF);

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

Widget formattedContainer({String? text, String? imagePath, required ColorScheme colorScheme}){
  Widget content;
  if (text != null){
    content = Text(text, style:TextStyle(color: Colors.white));
  } else if (imagePath != null) {
    String imageFullPath = "assets/images/$imagePath";
    content = Image.asset(imageFullPath);
  } else {
    content = const SizedBox.shrink();
  }
  return 
    Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: colorScheme.onPrimaryContainer,
      border: Border.all(color: Colors.black, width: 0.5),
      boxShadow: [BoxShadow(color: Colors.grey.withAlpha(2),
        spreadRadius: 7.0,
        blurRadius: 8.0,
        offset: const Offset(0, 3)
      
      )],

      gradient: LinearGradient(colors: [colorContainerOne, colorContainerSecond], 
        begin: Alignment.topLeft,
        end: Alignment.bottomRight
      ),
      
    ),
      width: double.maxFinite,
      height: double.maxFinite,
      child: Center(child: content),
    
  
  );

}