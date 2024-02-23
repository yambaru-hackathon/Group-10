import 'package:flutter/material.dart';

class ListUi extends StatefulWidget {
  const ListUi({Key? key}) : super(key: key);

  @override
  _ListUiState createState() => _ListUiState();
}

class _ListUiState extends State<ListUi>{
      double _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('資料',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.blue
        ),

    body:Column(
      children: [
      Slider(value: _currentValue, 
             min: 0,
             max: 100,
             divisions: 10,
             label: _currentValue.toString(),
             onChanged: (value) {
        setState(() {
          _currentValue = value;
        });
      }),
    ],)
      
    );
  }
}


