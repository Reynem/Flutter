import 'dart:convert';

import 'package:http/http.dart' as http;


class GithubInfo {
  final String user;

  const GithubInfo({required this.user});

  factory GithubInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'login': String user} => GithubInfo(
        user: user
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class GithubRepoInfo {
  String repoName;
  String? description;
  String? language;


  GithubRepoInfo(this.repoName, this.description, this.language);

  factory GithubRepoInfo.fromJson(Map<String, dynamic> json){
    return GithubRepoInfo(
      json['name'] as String,
      json['description'] as String?,
      json['language'] as String?,
    );
  }
}

Future<GithubInfo> fetchGithubGeneralInfo(String user) async {
  final response = await http.get(
    Uri.parse('https://api.github.com/users/$user')
  );

  if (response.statusCode == 200){
    return GithubInfo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to get account');
  }
}

Future<List<GithubRepoInfo>> fetchGithubRepoInfo(String user) async {
  final response = await http.get(
    Uri.parse('https://api.github.com/users/$user/repos')
  );

  if (response.statusCode == 200){
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((json) => GithubRepoInfo.fromJson(json as Map<String, dynamic>)).toList();
  } else{
    throw Exception('Failed to get account');
  }
}