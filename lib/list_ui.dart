import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class ListUiWidget extends StatelessWidget {
  ListUiWidget({super.key, required this.group});
  String group;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListUi(group: group),
    );
  }
}

class ListUi extends StatefulWidget {
  ListUi({Key? key, required this.group}) : super(key: key);
  String group;

  @override
  _ListUiState createState() => _ListUiState(group: group);
}

class _ListUiState extends State<ListUi> {
  _ListUiState({required this.group});
  String group;
  double _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            group,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color.fromRGBO(189, 255, 255, 1)),
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
          /*
          Link(
            // 開きたいWebページのURLを指定
            uri: Uri.parse('https://virment.com/handling-url-flutter/'),
            // targetについては後述
            target: LinkTarget.blank,
            builder: (BuildContext ctx, FollowLink? openLink) {
              return TextButton(
                onPressed: openLink,
                child: const Text(
                  'Webサイト表示',
                  style: TextStyle(fontSize: 12),
                ),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  // minimumSize:
                  //     MaterialStateProperty.all(Size.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              );
            },
          ),
          */
        ],
      ),
    );
  }
}
