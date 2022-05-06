import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../Admin/GymCardAdmin.dart';
import '../Styles.dart';
import '../models/GymModel.dart';

class AllGyms extends StatefulWidget {
  AllGyms({Key? key, required this.isNew}) : super(key: key);
  bool? isNew;
  @override
  State<AllGyms> createState() => _AllGymsState();
}

class _AllGymsState extends State<AllGyms> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<GymModel> _gymsList = [];

  Future? _getData() {
    if (widget.isNew!) {
      return _fireStore
          .collection("gyms")
          .where('isWaiting', isEqualTo: true)
          .get();
    } else {
      return _fireStore
          .collection("gyms")
          .where('isWaiting', isEqualTo: false)
          .get();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'New Gyms',
          style: TextStyle(color: Colors.white, fontFamily: 'Epilogue'),
        )),
        backgroundColor: colors.blue_base,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                _gymsList.clear();
                snapshot.data.docs.forEach((element) {
                  _gymsList.add(GymModel.fromJson(element.data()));
                });
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        controller: ScrollController(keepScrollOffset: true),
                        shrinkWrap: true,
                        itemCount: _gymsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GymCardAdmin(
                            gymInfo: _gymsList[index],
                          );
                        },
                      )
                    ],
                  ),
                );
              } else
                return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
