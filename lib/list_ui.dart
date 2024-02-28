import 'package:first/database.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:url_launcher/link.dart';
//import 'package:url_launcher/link.dart';

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
            (index) => FutureBuilder(
              future: _menuItem(url[index]),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return snapshot.data!;
                }
              },
            ),
          ),
        ));
  }

  Future<Widget> _link(String url) async {
    Response response = await get(Uri.parse(url));
    var document = parse(response.body);
    String title = document.head!.getElementsByTagName('title')[0].innerHtml;

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
            title,
            style: const TextStyle(fontSize: 12),
          ),
        );
      },
    );
  }

  Future<Widget> _menuItem(String url) async {
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
              await _link(url),
            ],
          )),
      onTap: () {
        print("onTap called.");
      },
    );
  }
}
