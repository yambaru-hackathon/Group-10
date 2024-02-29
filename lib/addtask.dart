import 'package:first/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key, required this.group});
  List<String> group;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Center(child: Text('課題追加')),
            backgroundColor: const Color.fromRGBO(189, 255, 255, 1)),
        body: CreateTask(group: group),
      ),
    );
  }
}

class CreateTask extends StatefulWidget {
  CreateTask({super.key, required this.group});
  List<String> group;

  @override
  State<CreateTask> createState() =>
      _CreateTaskState(group: group, selectedItem: group[0]);
}

class _CreateTaskState extends State<CreateTask> {
  _CreateTaskState({required this.group, required this.selectedItem});
  DateTime selectedDate = DateTime.now();
  double _sliderValue = 0;
  final task = TextEditingController();
  final url = TextEditingController();
  List<dynamic> doclist = [];
  bool have = false;
  List<String> group;
  String selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.only(left: 60, right: 60),
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '種類',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(width: 30),
            PullDown(items: ['普通', '目標'], firsttag: '普通'),
          ],
        ),
        SizedBox(height: 30),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '課題名',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 230),
          ],
        ),
        SizedBox(
          height: 40,
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: task,
          ),
        ),
        SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'リンク',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(width: 230),
          ],
        ),
        SizedBox(
          height: 40,
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: url,
          ),
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(
              flex: 1,
            ),
            const SizedBox(
              width: 20,
            ),
            const Text(
              '難易度',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(
              flex: 2,
            ),
            Text(
              '${_sliderValue.toInt()}',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            thumbShape: CircleThumbShape(),
          ),
          child: Container(
            width: 350,
            child: Slider(
              value: _sliderValue,
              min: 0,
              max: 5,
              onChanged: (double value) {
                setState(() {
                  _sliderValue = value;
                });
              },
              activeColor: Colors.black, // 「つまみ」より左側の色
              inactiveColor: Color.fromRGBO(221, 221, 221, 1), // 「つまみ」より右側の色
              thumbColor: Colors.white, // 「つまみ」の色
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 2,
            ),
            const Text(
              '期限',
              style: TextStyle(fontSize: 20),
            ),
            Spacer(
              flex: 1,
            ),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 2,
            ),
            Text(
              'グループ',
              style: TextStyle(fontSize: 20),
            ),
            Spacer(
              flex: 1,
            ),
            DropdownButton<String>(
              value: selectedItem, // 選択されている項目
              items: group.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // 選択された項目が変更されたときに呼び出されるコールバック関数
                // 変更された値を_selectedItemに設定
                setState(() {
                  debugPrint(selectedItem);
                  selectedItem = newValue!;
                  debugPrint(selectedItem);
                });
              },
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () async {
            doclist = await Database().docread(selectedItem, false);
            doclist.forEach(
              (element) {
                if (element == task.text) {
                  have = true;
                }
              },
            );
            if (have) {
              have = false;
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text('この課題は既にあるため追加できません'),
                    );
                  });
            } else {
              if (task.text != '') {
                Database().create(
                    selectedItem!,
                    task.text,
                    '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                    url.text,
                    _sliderValue.toInt());
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text('課題が入力されていません。'),
                      );
                    });
              }
            }
          },
          child: Text(
            '追加',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
      ],
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(today.year, today.month, today.day),
      lastDate: DateTime(today.year + 50, 12, 31),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

class PullDown extends StatefulWidget {
  const PullDown({super.key, required this.items, required this.firsttag});
  final List<String> items;
  final String firsttag;

  @override
  State<PullDown> createState() =>
      _PullDownState(items: items, selectedItem: firsttag);
}

class _PullDownState extends State<PullDown> {
  _PullDownState({required this.items, required this.selectedItem});
  List<String> items; // 表示する項目のリスト

  // 変数に応じて選択された項目を示す変数
  String selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedItem, // 選択されている項目
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (String? newValue) {
        // 選択された項目が変更されたときに呼び出されるコールバック関数
        // 変更された値をselectedItemに設定
        setState(() {
          selectedItem = newValue!;
        });
      },
    );
  }
}

class CircleThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const CircleThumbShape({
    this.thumbRadius = 10.0, //サイズ
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    //通常のつまみ用
    final fillPaint = Paint()
      ..color = sliderTheme.thumbColor! //つまみの色
      ..style = PaintingStyle.fill;

    //枠線用
    final borderPaint = Paint()
      ..color = Color.fromRGBO(221, 221, 221, 1) //枠線の色
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2; //枠線の太さ
    canvas.drawCircle(center, thumbRadius, fillPaint); //通常のつまみの描画
    canvas.drawCircle(center, thumbRadius, borderPaint); //枠線の描画
  }
}
