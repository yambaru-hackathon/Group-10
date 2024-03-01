import 'package:first/database.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:url_launcher/link.dart';

import 'addurl.dart';
//import 'package:url_launcher/link.dart';

class ListUiWidget extends StatelessWidget {
  ListUiWidget({super.key, required this.group, required this.task});
  String group;
  String task;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListUi(group: group, task: task),
    );
  }
}

class ListUi extends StatefulWidget {
  ListUi({Key? key, required this.group, required this.task}) : super(key: key);
  String group;
  String task;

  @override
  _ListUiState createState() => _ListUiState(group: group, task: task);
}

class _ListUiState extends State<ListUi> {
  _ListUiState({
    required this.group,
    required this.task,
  });
  String group;
  String task;
  List url = [];

  @override
  void initState() {
    super.initState();
    _fetchUrl();
  }

  void _fetchUrl() async {
    // 非同期関数を呼び出して値を取得
    List Url = await Database().fldread(group, task, 'url');
    // setStateを使用してurlリストを更新
    setState(() {
      url = Url;
    });
  }

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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Addurl(group: group, task: task)),
          ).then((value) async {
            List Url = await Database().fldread(group, task, 'url');

            setState(() {
              url = Url;
            });
          });
        },
        backgroundColor: Color.fromARGB(255, 228, 228, 228),
        child: const Text('+'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(180)),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
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
      ),
    );
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
            style: const TextStyle(fontSize: 10),
            softWrap: true,
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
