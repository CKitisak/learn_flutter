import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Back to First Page'),
          onPressed: () {
            // Close the second page and return to the First page
            // removes the current Route from the stack
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
