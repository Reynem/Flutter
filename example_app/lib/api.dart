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

Future<GithubInfo> fetchGithubInfo(String user) async {
  final response = await http.get(
    Uri.parse('https://api.github.com/users/$user')
  );

  if (response.statusCode == 200){
    return GithubInfo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to get account');
  }
}