
import 'package:example_app/api.dart';
import 'package:example_app/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:example_app/utils.dart';


class CounterScreen extends StatefulWidget {
    const CounterScreen({super.key});
    

    @override
    State<CounterScreen> createState() => _CounterScreenState();

    
}

class _CounterScreenState extends State<CounterScreen> {
 late Future<GithubInfo> futureGithubInfo;
 late Future<List<GithubRepoInfo>> futureGithubRepoInfo;

 String githubUserName = githubNameUser.value;

  @override
  void initState() {
    super.initState();
    _loadData();
    githubNameUser.addListener(refreshData);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (githubUserName != githubNameUser.value) {
      refreshData();
    }
  }

  @override
  void dispose() {
    githubNameUser.removeListener(refreshData);
    super.dispose();
  }

  void _loadData(){
    futureGithubInfo = fetchGithubGeneralInfo(githubUserName);
    futureGithubRepoInfo = fetchGithubRepoInfo(githubUserName);
  }

  void refreshData() {
  setState(() {
    githubUserName = githubNameUser.value;
    futureGithubInfo = fetchGithubGeneralInfo(githubUserName);
    futureGithubRepoInfo = fetchGithubRepoInfo(githubUserName);
  });
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final ColorScheme colorScheme = theme.colorScheme;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    final List<Widget> destinations = [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: formattedButton("Home", context, colorScheme),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: formattedButton("Settings", context, colorScheme),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: formattedButton("Profile", context, colorScheme),
      ),
    ];


    if (queryData.size.width < 600.0){
      return Scaffold(
          body: Column(
              children: <Widget>[
                  Expanded(
                      child: formattedImageContainer(imagePath: "anime_girl.png", colorScheme: colorScheme),
                    ),
                  Expanded(
                    child: thirdContainer(futureGithubRepoInfo, colorScheme)
                  ),
                  
                ]
            ),

          backgroundColor: colorScheme.primary,


          bottomNavigationBar: NavigationBar(destinations: destinations, backgroundColor: colorScheme.primaryContainer,),
        );

    } else{

      return Scaffold(
          body: Column(
              children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                          
                            formattedImageContainer(imagePath: "anime_girl.png", colorScheme: colorScheme),

                            Expanded(
                              child: FutureBuilder<GithubInfo>(
                                  future: futureGithubInfo,
                                  builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                          return formattedContainer(text: "Ошибка загрузки: ${snapshot.error}", colorScheme: colorScheme);
                                      } else if (snapshot.hasData) {
                                          final githubInfo = snapshot.data!;
                                          return formattedContainer(
                                              text: "User: ${githubInfo.user}",
                                              colorScheme: colorScheme
                                          );
                                      } else {
                                          return formattedContainer(text: "Нет данных", colorScheme: colorScheme);
                                      }
                                  },
                              ),
                            ),
                        ],
                    ),
                    
                    ),

                  Expanded(
                      child: thirdContainer(futureGithubRepoInfo, colorScheme)
                    )
                ]
            ),

          backgroundColor: colorScheme.primary,


          bottomNavigationBar: NavigationBar(destinations: destinations, backgroundColor: colorScheme.primaryContainer,),
        );
    }
    
  }
}
