import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/second'),
              child: Text('PUSH'),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed('/second'),
              child: Text('REPLACE'),
            ),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }
}
