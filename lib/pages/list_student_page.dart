import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/pages/update_student.dart';
import 'package:flutter/material.dart';

class ListStudentPage extends StatefulWidget {
  @override
  _ListStudentPageState createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  // Ferching data from firebase
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('student').snapshots();

  // for deleting record we have to create varaible instance
  CollectionReference students =
      FirebaseFirestore.instance.collection('student');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('user deleted'))
        .catchError((error) => print('Failed to delte user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("you have problem in fetching data");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List storedocs = [];
          // for fetching data
          snapshot.data.docs.map((DocumentSnapshot document) {
            // assign every data in map
            Map a = document.data();
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(170),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          color: Colors.blueGrey.shade100,
                          child: Center(
                            child: Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 21.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.blueGrey.shade100,
                          child: Center(
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Container(
                          color: Colors.blueGrey.shade100,
                          child: Center(
                            child: Text(
                              "Action",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: Text(
                              storedocs[i]['name'],
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(
                              storedocs[i]['email'],
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UpdateStudentPage(
                                                id: storedocs[i]['id']),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                    // size: 10,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    // size: 17,
                                  ),
                                  onPressed: () => {
                                    deleteUser(storedocs[i]['id']),
                                    // print(storedocs)
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}
/**/
