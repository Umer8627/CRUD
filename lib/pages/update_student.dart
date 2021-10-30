import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateStudentPage extends StatefulWidget {
  final String id;

  UpdateStudentPage({this.id});

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final _formkey = GlobalKey<FormState>();

  CollectionReference students =
      FirebaseFirestore.instance.collection('student');
   updateUser(id, name, email, password) {
     print(id);
     FirebaseFirestore.instance.collection('student')
        .doc(id)
        .update({'name': "$name", 'email': "$email", 'password': '$password'})
        .then((value) => print("User updated"))
        .catchError((error) => print("falied to update: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Record"),
      ),
      body: Form(
        key: _formkey,
        child: StreamBuilder(
          stream:  FirebaseFirestore.instance
            .collection('student')
            .doc(widget.id).snapshots(),

          builder: (_,snapshot) {
            if (snapshot.hasError) {
              print('Something Went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var data = snapshot.data;
            var name = data['name'];
            var email = data['email'];
            var password = data['password'];

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                      autofocus: false,
                      initialValue: name,
                      onChanged: (value) => {
                        name =value,
                      },
                      decoration: InputDecoration(
                        labelText: 'Name ',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 15.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Name";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                      autofocus: false,
                      initialValue: email,
                      onChanged: (value) => {
                        email = value,
                      },
                      decoration: InputDecoration(
                        labelText: 'Email ',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 15.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Valid Email";
                        } else if (!value.contains('@')) {
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: TextFormField(
                      obscureText: true,
                      autofocus: false,
                      initialValue: password,
                      onChanged: (value) => {
                        password= value,
                      },
                      decoration: InputDecoration(
                        labelText: 'Password ',
                        labelStyle: TextStyle(
                          fontSize: 18.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 15.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //Validateof form is satisfy all condition
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                updateUser(widget.id, name, email, password);
                                Navigator.pop(context);
                              });
                            }
                          },
                          child: Text(
                            "Update User",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: null,
                          child: Text(
                            "Reset",
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
       ),
      ),
    );
  }
}
