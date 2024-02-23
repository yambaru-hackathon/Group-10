import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const newgroup());
}


class newgroup extends StatelessWidget{
const newgroup({super.key});  

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'グループ追加',
          textAlign: TextAlign.center,
        ),
      ),
      body: const Center(
        child: ChangeForm(),   //文字入力するための関数を呼び出している
      ),

    ); 
  }
}


class ChangeForm extends StatefulWidget{
  const ChangeForm({super.key});

  @override
  _ChangeFormState createState() => _ChangeFormState();
}


class _ChangeFormState extends State<ChangeForm>{
  final _formKey = GlobalKey<FormState>();
  String group='';
  String pass='';
  String a='';
  String b='';

  void _handleText(String e){
    setState(() {
      group = e;
    });
  }

  
  void _handlepass(String e){
    setState(() {
      pass = e;
    });
  }

  
void _submission() {
  a=group;
  b=pass;
}







@override
  Widget build(BuildContext context){
  return Container(
    padding: const EdgeInsets.all(50.0),
    child:Column(
      children: [
        Text(
          'グループ名',
          style: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 10.0),
        ),

        TextField(
          enabled:true,
          maxLength: 10, //入力数
          style: const TextStyle(color:Colors.red),
          obscureText: false,
          maxLines:1,
          onChanged: _handleText,
        ),

        
        Text(
          'Password',
          style: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 10.0),
        ),


        TextField(
          enabled:true,
          maxLength: 10, //入力数
          style: const TextStyle(color:Colors.red),
          obscureText: true,
          maxLines:1,
          onChanged: _handleText,
        ),
        ElevatedButton(
              onPressed: _submission,
              child: Text('保存'),
            ),

        
        Text(
          a,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 50.0),
        ),

        Text(
          b,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 50.0),
        ),



    ],
    
  ),
  
);

  }
}

