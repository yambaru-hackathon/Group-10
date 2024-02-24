import 'package:cloud_firestore/cloud_firestore.dart';

//データベースと通信する
class Database {
  final db = FirebaseFirestore.instance;

  //データの追加
  Future<void> create(
      String group, String task, String deadline, String url) async {
    await db.collection(group).doc(task).set({
      'group': group,
      'task': task,
      'deadline': deadline,
      'url': [url],
    });
  }

  //urlの追加
  Future<void> addurl(String group, String task, String url) async {
    await db.collection(group).doc(task).update({
      'url': FieldValue.arrayUnion([url]),
    });
  }

  //urlの削除
  Future<void> delurl(String group, String task, String url) async {
    await db.collection(group).doc(task).update({
      'url': FieldValue.arrayRemove([url]),
    });
  }

  //データの読み込み
  Future<dynamic> fldread(String group, String task, String field) async {
    DocumentSnapshot dcsn = await db.collection(group).doc(task).get();
    Map<String, dynamic> data = dcsn.data() as Map<String, dynamic>;

    //通常はStringを返しfieldがurlの時のみListを返す
    return data[field];
  }

  //全てのドキュメントを取得
  Future<List> docread(String group) async {
    List docList = [];
    await FirebaseFirestore.instance.collection(group).get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.forEach(
              (doc) {
                docList.add(doc.id);
              },
            ),
          },
        );
    return docList;
  }

  //データの更新
  Future<void> update(
      String group, String task, String field, String newdata) async {
    if (field != 'url') {
      await db.collection(group).doc(task).update({
        field: newdata,
      });
    }
  }

  //データの削除
  Future<void> delete(String group, [String task = '']) async {
    if (task != '') {
      await db.collection(group).doc(task).delete();
    } else {
      final users = FirebaseFirestore.instance.collection(group);
      WriteBatch batch = FirebaseFirestore.instance.batch();

      users.get().then((querySnapshot) {
        querySnapshot.docs.forEach((document) {
          batch.delete(document.reference);
        });
        batch.commit();
      });
    }
  }
}
