import 'package:example_app/api.dart';
import 'package:example_app/settings_screen.dart';
import 'package:flutter/material.dart';

const Color colorContainerOne = Color(0x90D5FFff);
const Color colorContainerSecond = Color(0x57B9FFff);

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

MaterialButton formattedButton(String text, BuildContext context){
return MaterialButton(
  onPressed: () {
    if (text == "Settings"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
    } else if (text == "Home"){
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  },
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

Widget formattedContainer({required String text, required ColorScheme colorScheme}){
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
        child: Center(child: Text(text)),
    
  
  );

}

Widget formattedImageContainer({required String imagePath, required ColorScheme colorScheme}){
  return FittedBox(
    fit: BoxFit.contain,
    child: Container(
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
        child: Center(child: Image.asset("assets/images/$imagePath")),
    ));
}


Widget thirdContainer(Future<List<GithubRepoInfo>> futureGithubRepoInfo, ColorScheme colorScheme){
  return FutureBuilder(
    future: futureGithubRepoInfo, 
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
          return formattedContainer(text: "Ошибка загрузки: ${snapshot.error}", colorScheme: colorScheme);
      } else if (snapshot.hasData) {
          final githubRepoInfo = snapshot.data!;
          return ListView.builder(
              itemCount: githubRepoInfo.length,
              itemBuilder: (context, index) {
                  final repo = githubRepoInfo[index];
                  return Card(
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(
                                      repo.repoName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                      ),
                                  ),
                                  if (repo.description != null && repo.description!.isNotEmpty)
                                      Padding(
                                          padding: const EdgeInsets.only(top: 4.0),
                                          child: Text(repo.description!),
                                      ),
                                  if (repo.language != null && repo.language!.isNotEmpty)
                                      Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Text("Language: ${repo.language!}"),
                                      ),
                              ],
                          ),
                      ),
                  );
              },
            cacheExtent: 250,
          );
      } else {
          return formattedContainer(text: "Нет данных", colorScheme: colorScheme);
      }
    }
    );
}