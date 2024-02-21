import 'dart:html';
import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

//データベースと通信する
class Database{
  final db = FirebaseFirestore.instance;

  //データの追加
  Future<void> create(String group, String task, String deadline) async{
    await db.collection(group).doc(task).set(
      {
        'group': group,
        'task': task,
        'deadline': deadline,
      }
    );
  }

  //データの読み込み
  Future<String> read(String group, String task) async{
    final doc = await db.collection(group).doc(task).get();
    debugPrint(doc.data().toString());
    return doc.data().toString();
  }

  //データの更新
  Future<void> update() async{
    await db.collection('songs').doc('S01').update(
      {
        'title': 'test',
      }
    );
  }

  //データの削除
  Future<void> delete() async{
    await db.collection('songs').doc('S02').delete();
  }
}