import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
        child: ChangeForm(), 
         //文字入力するための関数を呼び出している
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
  String group='';
  String pass='';
  late SharedPreferences prefs;
  String name='';

Future<void> setInstance() async{
  prefs = await SharedPreferences.getInstance();
}

Future<void> setDate() async{
  await prefs.setString('name', group);
}

void getDate(){
  name =  prefs.getString('name') ?? '';
  setState(() {});

}



@override
void initState(){
  super.initState();
  setInstance();
}

  


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
            fontSize: 30.0),
        ),
        Text(
          name,
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

      
        
        ElevatedButton(
              onPressed: (){
                setDate();
              },
              child: Text('保存'),
            ),

            
        ElevatedButton(
              onPressed: (){
                getDate();
                
              },
              child: Text('表示'),
            ),


    ],
    
  ),
  
);

  }
}

