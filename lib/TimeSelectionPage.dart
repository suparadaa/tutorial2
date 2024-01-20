import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications_tutorial/local_notifications.dart';
import 'package:intl/intl.dart';

class TimeSelectionPage extends StatefulWidget {
  @override
  _TimeSelectionPageState createState() => _TimeSelectionPageState();
}

class _TimeSelectionPageState extends State<TimeSelectionPage> {
  // List to store selected times
  List<String> selectedTimes = [];
  int currentId = 1; // เพิ่มตัวแปรนับ id

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Times'),
      ),
      body: ListView(
        children: [
          // Create a list of time selection buttons
          for (int i = 0; i < 4; i++)
            ListTile(
              title: Text('Select Time ${i + 1}'),
              trailing: IconButton(
                icon: Icon(Icons.access_time),
                onPressed: () async {
                  // Show time picker and add selected time to the list
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  /* if (selectedTime != null) {
                    setState(() {
                      selectedTimes
                          .add('${selectedTime.hour}:${selectedTime.minute}');
                    });*/
                  if (selectedTime != null) {
                    setState(() {
                      String formattedTime = DateFormat('HH:mm').format(
                        DateTime(
                            2022, 1, 1, selectedTime.hour, selectedTime.minute),
                      );
                      selectedTimes.add(formattedTime);
                    });
                  }
                },
              ),
            ),
          // Display the selected times
          if (selectedTimes.isNotEmpty)
            ListTile(
              title: Text('Selected Times:'),
              subtitle: Text(selectedTimes.join(', ')),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call the function to schedule daily notifications
          for (String selectedTime in selectedTimes) {
            LocalNotifications().scheduleDailyNotifications(
              id: currentId,
              hourAndMinuteList: [selectedTime],
              title: 'Notification Title',
              body: 'Notification Body',
              payload: 'Notification Payload',
            );
            currentId++; // เพิ่ม id ในแต่ละการเรียก
          }
          // Navigate back to the previous screen
          Navigator.pop(context);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
