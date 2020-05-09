import 'package:flutter/material.dart';
class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'SearchTab'
        ),
      ),
      body: Center(
        child: Text('Search tab'),
      ),
    );
  }
}