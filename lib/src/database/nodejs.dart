import 'dart:convert';

import 'package:http/http.dart' as http;

class Nodejsdata {
  static var client = http.Client();
  /* Future<List>*/ getDatafromNodejs() async {
    print('Uriiii i');
    final uri = Uri.http('10.0.0.4:5000', 'api');
    print('Uriiii $uri');
    print('response1');
    final response = await client.get(uri);
    print('response 2');
    print(response);
    Map data = jsonDecode(response.body);
    List user = [];
    for (var i in data['result']) {
      user.add(i);
    }
    print(user);
    //return user;
  }

  Future<List> getApi() async {
    final uri = Uri.https('shazam.p.rapidapi.com',
        '/songs/list-recommendations', {'key': '484129036', 'locale': 'en-US'});
    final respone = await http.get(uri, headers: {
      'X-RapidAPI-Host': 'shazam.p.rapidapi.com',
      'X-RapidAPI-Key': '0c6056fb09msheeedae083b5a9a9p19681ejsnf6712a42864a'
    });
    Map data = jsonDecode(respone.body);

    List user = [];
    for (var i in data['tracks']) {
      user.add(i);
    }
    return user;
  }
}
