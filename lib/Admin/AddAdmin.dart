import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../Styles.dart';
import '../models/Admin.dart';
import '../models/user.dart';

class AddAdmin extends StatefulWidget {
  const AddAdmin({Key? key}) : super(key: key);

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  Admin _admin = Admin(email: '', initPassword: '', uid: '');
  List<Admin> _adminList = [];
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Future? _getData() {
    _fireStore.collection('Admin').get();
  }

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Add Admin'), backgroundColor: colors.blue_base),
      body: Form(
        key: _form,
        child: Column(children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 30, 200, 0),
            child: Text(
              'Add a New Admin: ',
              style: TextStyle(
                fontFamily: 'Epilogue',
                fontSize: 18,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 15, 50, 0),
            width: 320,
            height: 50,
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Admin Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: colors.black100),
                  ),
                ),
                onChanged: (value) {
                  _admin.email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Email cannot be empty!';
                  if (!value.contains('@'))
                    return 'Email formamt is not correct';
                }),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 15, 50, 0),
            width: 320,
            height: 50,
            child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Admin Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: colors.black100),
                  ),
                ),
                onChanged: (value) {
                  _admin.initPassword = value;
                },
                validator: (value) {
                  if (value!.isEmpty) return 'Password cannot be empty!';
                }),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: colors.blue_base),
              //  color: colors.blue_base,
              child: FlatButton(
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      var newAdmin =
                          FirebaseFirestore.instance.collection('Admin').doc();
                      newAdmin.set({
                        "email": _admin.email,
                        "initPassword": _admin.initPassword,
                        "uid": newAdmin.id
                      });
                      AppUser.message(context, true, 'Admin Has Been Added');
                    }
                  },
                  child: Text(
                    'Add Admin',
                    style: TextStyle(color: Colors.white),
                  ))),
        ]),
      ),
    );
  }
}
