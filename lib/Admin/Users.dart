import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Styles.dart';
import '../models/profile_model.dart';
// import 'AdminHome.dart';
// import 'dart:io';
import 'CustomerList.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool? isCustomers = true;
  //bool? gymOwners;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  List<ProfileModel> _CustomersList = [];
//List<GymModel> _gymsList = [];

  @override
  Widget build(BuildContext context) {
    Future? _getData() {
      if (isCustomers == true) {
        return _fireStore.collection("Customer").get();
      } else {
        return _fireStore.collection("Gym Owner").get();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.blue_base,
        title: Text('Users'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //is Customer?
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCustomers = true;
                    // widget.gym.gender = 'Men';
                    // print(widget.gym.gender);
                  });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                      color: isCustomers == true
                          ? colors.iconscolor
                          : colors.hinttext,
                    ),
                    Text(
                      "Customers",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roborto',
                        color: isCustomers == true
                            ? colors.iconscolor
                            : colors.hinttext,
                        fontWeight: isCustomers == true
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 10,
              ),
              // is Gym owner?
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCustomers = false;

                    //print(widget.gym.gender);
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.apartment,
                      size: 30,
                      color: isCustomers == true
                          ? colors.hinttext
                          : colors.iconscolor,
                    ),
                    Text(
                      "Gym Owners",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roborto',
                        color: isCustomers == true
                            ? colors.hinttext
                            : colors.iconscolor,
                        fontWeight: isCustomers == true
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: SafeArea(
              child: FutureBuilder(
                future: _getData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    _CustomersList.clear();
                    snapshot.data.docs.forEach((element) {
                      _CustomersList.add(ProfileModel.fromJson(element.data()));
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          GridView.builder(
                            controller:
                                ScrollController(keepScrollOffset: true),
                            shrinkWrap: true,
                            itemCount: _CustomersList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CustomerList(
                                  // gymInfo: _gymsList[index],
                                  user: _CustomersList[index]);
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 5),
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
        ),
      ]),
    );
  }
}
