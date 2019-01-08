import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'reminder.dart';
import 'listreminders.dart';

Future<List<Reminder>> fetchPosts(http.Client client) async {
//  final response = await http.get('http://192.168.0.103:8000/reminders/');
//  final response = await http.get('http://10.182.5.51:8000/reminders/');
  final response = await http.get('http://192.168.42.33:8000/reminders/');
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    final parsed = json.decode(response.body);

    return parsed['results'].map<Reminder>((json) => Reminder.fromJson(json)).toList();
  }
  else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

//List<Reminder> parsePosts(String responseBody) {
//  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//
//  return parsed.map<Reminder>((json) => Reminder.fromJson(json)).toList();
//}

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Reminder>>(
        future: fetchPosts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListViewReminders(reminders: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}