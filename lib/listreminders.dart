import 'package:flutter/material.dart';
import 'package:http_example/editreminder.dart';

import 'reminder.dart';


class ListViewReminders extends StatelessWidget {
  final List<Reminder> reminders;

  ListViewReminders({Key key, this.reminders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: reminders.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {

            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReminderScreen(reminder: reminders[position])),
                  );
                },
                title: Text(
                  '${reminders[position].title}',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
                subtitle: Text(
                  '${reminders[position].text}',
                  style: new TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                ),
              ],
            );
          }),
    );
  }
}
