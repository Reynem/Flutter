import 'package:example_app/api.dart';
import 'package:example_app/settings_screen.dart';
import 'package:flutter/material.dart';


Text formattedH2Text(String text, ColorScheme colorScheme){
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 28,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
    );
  }

MaterialButton formattedButton(String text, BuildContext context, ColorScheme colorScheme){
return MaterialButton(
  onPressed: () {
    if (text == "Settings"){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
    } else if (text == "Home"){
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  },
  focusColor: colorScheme.primary.withValues(alpha: 0.4),
  hoverColor: colorScheme.primary.withValues(alpha: 0.2),
  color: colorScheme.primary,
  textColor: colorScheme.onPrimary,
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
        color: colorScheme.surfaceContainerHighest,
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.5), width: 0.5),
      ),
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(child: 
          Text(
            text,
            style: TextStyle(
              color: colorScheme.onSurface,
            ),
          )
        ),
    
  
  );

}

Widget formattedImageContainer({required String imagePath, required ColorScheme colorScheme}){
  return FittedBox(
    fit: BoxFit.contain,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: colorScheme.surfaceContainerHighest,
        border: Border.all(color: colorScheme.onSurface.withValues(alpha: 0.5), width: 0.5),
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
                                          color: colorScheme.onSurface,
                                      ),
                                  ),
                                  if (repo.description != null && repo.description!.isNotEmpty)
                                      Padding(
                                          padding: const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            repo.description!,
                                            style: TextStyle(
                                              color: colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                      ),
                                  if (repo.language != null && repo.language!.isNotEmpty)
                                      Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              "Language: ${repo.language!}",
                                              style: TextStyle(
                                                color: colorScheme.onSurfaceVariant,
                                              ),
                                            ),
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