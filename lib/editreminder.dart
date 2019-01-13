import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_example/home.dart';
import 'package:http_example/reminder.dart';

class ReminderScreen extends StatelessWidget {
  final Reminder reminder;

  ReminderScreen({Key key, this.reminder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _titlecontroller = new TextEditingController();
    TextEditingController _txtcontroller = new TextEditingController();
    _titlecontroller.text = reminder.title;
    _txtcontroller.text = reminder.text;

    return Scaffold(
      appBar: AppBar(
        title: Text("${reminder.title}"),
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
      floatingActionButton: Row(
        children: <Widget>[
          Spacer(
            flex: 7,
          ),
          FloatingActionButton(
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            heroTag: null,
            backgroundColor: Colors.red,
            onPressed: () async {
              final String id = reminder.id.toString();
              final delete_response = await http.delete(globalURL() + id + '/');
              Navigator.pop(context, true);
            },
          ),
          Spacer(),
          FloatingActionButton(
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
            heroTag: null,
            backgroundColor: Colors.orange,
            onPressed: () async {
              final String id = reminder.id.toString();
              final reminderJson = {
                'id': id,
                'title': _titlecontroller.text,
                'text': _txtcontroller.text
              };
              final put_response = await http.put(globalURL() + id + '/', body: reminderJson);
              Navigator.pop(context, true);
            },
          ),

        ],
      ),
    );
  }
}