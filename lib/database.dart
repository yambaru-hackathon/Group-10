import 'package:cloud_firestore/cloud_firestore.dart';

//データベースと通信する
class Database{
  final db = FirebaseFirestore.instance;

  //データの追加
  Future<void> create(String group, String task, String deadline, String url) async{
    await db.collection(group).doc(task).set(
      {
        'group': group,
        'task': task,
        'deadline': deadline,
        'url': [url],
      }
    );
  }

  //urlの追加
  Future<void> addurl(String group, String task, String url) async{
    await db.collection(group).doc(task).update({
      'url' : FieldValue.arrayUnion([url]),
    });
  }

  //urlの削除
  Future<void> delurl(String group,String task, String url) async{
    await db.collection(group).doc(task).update({
      'url' : FieldValue.arrayRemove([url]),
    });
  }

  //データの読み込み
  Future<dynamic> read(String group, String task, String genre) async{
    DocumentSnapshot dcsn = await db.collection(group).doc(task).get();
    Map<String, dynamic> data = dcsn.data() as Map<String, dynamic>;

    //通常はStringを返しgenreがurlの時のみListを返す
    return data[genre];
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
  Future<void> delete(String group, String task) async{
    await db.collection(group).doc(task).delete();
  }
}