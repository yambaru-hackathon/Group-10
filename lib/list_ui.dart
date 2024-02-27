import 'package:first/database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class ListUiWidget extends StatelessWidget {
  ListUiWidget(
      {super.key, required this.group, required this.task, required this.url});
  String group;
  String task;
  List url;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListUi(group: group, task: task, url: url),
    );
  }
}

class ListUi extends StatefulWidget {
  ListUi({Key? key, required this.group, required this.task, required this.url})
      : super(key: key);
  String group;
  String task;
  List url;

  @override
  _ListUiState createState() =>
      _ListUiState(group: group, task: task, url: url);
}

class _ListUiState extends State<ListUi> {
  _ListUiState({required this.group, required this.task, required this.url});
  String group;
  String task;
  double _currentValue = 0;
  List url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              '${group}/${task}',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: const Color.fromRGBO(189, 255, 255, 1)),
        body: ListView(
          children: List.generate(
            url.length,
            (index) => _menuItem(url[index]),
          ),
        )

        /*Column(
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
          
          */
          
        ],
      ),*/
        );
  }

  Widget _linkItem(String url) {
    return Link(
      // 開きたいWebページのURLを指定
      uri: Uri.parse(url),
      // targetについては後述
      target: LinkTarget.blank,
      builder: (BuildContext ctx, FollowLink? openLink) {
        return TextButton(
          onPressed: openLink,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            // minimumSize:
            //     MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            url,
            style: TextStyle(fontSize: 12),
          ),
        );
      },
    );
  }

  Widget _menuItem(String title) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
              ),
              _linkItem(title),
            ],
          )),
      onTap: () {
        print("onTap called.");
      },
    );
  }
}
