import 'package:flutter/material.dart';

class ListUi extends StatefulWidget {
  const ListUi({Key? key}) : super(key: key);

  @override
  _ListUiState createState() => _ListUiState();
}

class _ListUiState extends State<ListUi> {
  double _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            '化学の資料',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color.fromARGB(255, 16, 199, 184)),
      body: Column(
        // 進捗度スライダー //
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("進捗度:", style: TextStyle(fontSize: 20)),
              Text(
                _currentValue.toString(),
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "%",
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
          Slider(
              value: _currentValue,
              min: 0,
              max: 100,
              divisions: 10,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "化学の授業資料",
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(onPressed: () {}, child: const Text("URL")),
              ElevatedButton(
                onPressed: () {},
                child: Text("Go"),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "化学の過去問",
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(onPressed: () {}, child: const Text("URL")),
              ElevatedButton(
                onPressed: () {},
                child: Text("Go"),
              )
            ],
          )
        ],
      ),
    );
  }
}
