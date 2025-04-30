
import 'package:example_app/api.dart';
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

  @override
  void initState() {
    futureGithubInfo = fetchGithubGeneralInfo('Reynem');
    futureGithubRepoInfo = fetchGithubRepoInfo('Reynem');
    super.initState();
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

    if (queryData.size.width < 600.0){
      return Scaffold(
          body: Column(
              children: <Widget>[
                  Expanded(
                      child: formattedImageContainer(imagePath: "anime_girl.png", colorScheme: colorScheme),
                    ),
                  Expanded(
                    child: formattedContainer(text: "Third Container",colorScheme: colorScheme)
                  )
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
                    child: FutureBuilder(
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
                            );
                        } else {
                            return formattedContainer(text: "Нет данных", colorScheme: colorScheme);
                        }
                      }
                      )

                    )
                ]
            ),

          backgroundColor: colorScheme.primary,


          bottomNavigationBar: NavigationBar(destinations: destinations, backgroundColor: colorScheme.primaryContainer,),
        );
    }
    
  }
}
