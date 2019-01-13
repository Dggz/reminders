import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_example/addreminder.dart';

import 'listreminders.dart';
import 'reminder.dart';

String globalURL() {
  return 'http://192.168.0.102:8000/reminders/';
//  return 'http://10.182.5.51:8000/reminders/';
//  return 'http://10.182.5.51:8000/reminders/';
}

Future<List<Reminder>> fetchPosts(http.Client client) async {
  final response = await http.get(globalURL());
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

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddReminderScreen()),
          );

        },
      ),
    );
  }
}