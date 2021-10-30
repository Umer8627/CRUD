import 'package:crud/pages/add_student_page.dart';
import 'package:crud/pages/list_student_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Flutter FireBase CRUD"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => AddStudentPage(),
                  ),
                );
              },
              child: Text(
                "Add",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
            ),
          ],
        ),
      ),
      body: ListStudentPage(),
    );
  }
}
