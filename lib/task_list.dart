import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'newgroup.dart';
import 'dart:async';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: task_list_338(),
    );
  }
  
}


class task_list_338 extends StatefulWidget {
  const task_list_338({super.key});
  

  @override
  State<task_list_338> createState() => _task_list_338State();
}


String dropdownVal1 = "hard";
String dropdownVal2 = "all";
String geto='';



Widget _buildBackground() {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.black12,
  );
}


Widget _buildFloatingActionButton() {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 54,
      width: 54,
      margin: const EdgeInsets.only(right: 17, bottom: 50),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(Icons.add, size: 25, color: Colors.white),
    ),
  );
  
}

class _task_list_338State extends State<task_list_338> {
  
   @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    setState(() {
      geto = prefs.getString('name') ?? '';
    });  
    await prefs.reload();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "課題一覧",
          textAlign: TextAlign.end,
        ),
               
        backgroundColor: const Color.fromARGB(255, 54, 171, 244),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    child: const Text(
                      "＋",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 201, 223, 233),
                        shape: BeveledRectangleBorder(side: BorderSide.none)),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Color.fromARGB(255, 160, 189, 212),
                    child: DropdownButton(
                      underline: Container(
                        height: 0,
                      ),
                      value: dropdownVal2,
                      icon: const Icon(Icons.expand_more, color: Colors.black),
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: const Color.fromARGB(255, 160, 189, 212),
                      onChanged: (String? newVal2) {
                        setState(() {
                          dropdownVal2 = newVal2!;
                        });
                      },
                      items: const [
                        DropdownMenuItem<String>(
                          value: "all",
                          child: Text("全部"),
                        ),
                        DropdownMenuItem<String>(
                          value: "grupe",
                          child: Text("グループ"),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Color.fromARGB(255, 126, 176, 216),
                    child: DropdownButton(
                      underline: Container(
                        height: 0,
                      ),
                      value: dropdownVal1,
                      icon: const Icon(Icons.expand_more, color: Colors.black),
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: const Color.fromARGB(255, 126, 176, 216),
                      onChanged: (String? newVal1) {
                        setState(() {
                          dropdownVal1 = newVal1!;
                        });
                      },
                      items: const [
                        DropdownMenuItem<String>(
                          value: "hard",
                          child: Text("難易度準(難)"),
                        ),
                        DropdownMenuItem<String>(
                          value: "ez",
                          child: Text("難易度準(簡)"),
                        ),
                        DropdownMenuItem<String>(
                          value: "short",
                          child: Text("期限表示(短)"),
                        ),
                        DropdownMenuItem<String>(
                          value: "long",
                          child: Text("期限表示(長)"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              
          "$geto",
          textAlign: TextAlign.end,
        ),
        

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            //------------------------
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => newgroup()),
              );
            },
            //------------------------
            backgroundColor: Color.fromARGB(255, 228, 228, 228),
            child: Icon(
              Icons.groups,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(180)),
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Color.fromARGB(255, 228, 228, 228),
            child: Icon(
              Icons.calendar_month,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(180)),
          ),
        ],        
      ),
      bottomNavigationBar: SingleChildScrollView(),
      
    );
  }
}
