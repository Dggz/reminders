import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_example/home.dart';

class AddReminderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextEditingController _titlecontroller = new TextEditingController();
    TextEditingController _txtcontroller = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Reminder"),
      ),

      body: ListView(
        children: <Widget>[
          TextFormField(
            controller: _titlecontroller,
            decoration: InputDecoration(
                labelText: 'Reminder title'
            ),
          ),
          TextFormField(
            controller: _txtcontroller,
            decoration: InputDecoration(
                labelText: 'Reminder text'
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
        onPressed: () async {
          final reminderJson = {
            'title': _titlecontroller.text,
            'text': _txtcontroller.text
          };
          final post_response = await http.post(globalURL(), body: reminderJson);
          Navigator.pop(context, true);


        },
      ),
    );
  }
}