import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class CurrentTimeAndDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now(); // Get the current time and date
    String formattedDate = DateFormat('EEE').format(now); // Format the date
    String formattedTime = DateFormat('h:mm a').format(now); // Format the time

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            Text(
              formattedDate, // Display the formatted date
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              ',$formattedTime', // Display the formatted time
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
