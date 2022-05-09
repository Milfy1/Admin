import 'dart:io';
import 'package:Admin/Admin/Contact.dart';

import '../models/profile_model.dart';
import 'package:flutter/material.dart';
import '../Styles.dart';
import '../models/profile_model.dart';

class CustomerList extends StatefulWidget {
  CustomerList({Key? key, required this.user}) : super(key: key);
  ProfileModel user;
  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: widget.user.userImage != null
                    ? ClipOval(
                        child: Image.network(
                          widget.user.userImage!,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return CircleAvatar(
                              radius: 45,
                              backgroundColor: colors.blue_smooth,
                              child: Icon(
                                Icons.person,
                                size: 85,
                                color: colors.iconscolor,
                              ),
                            );
                          },
                        ),
                      )
                    : CircleAvatar(
                        radius: 45,
                        backgroundColor: colors.blue_smooth,
                        child: Icon(
                          Icons.person,
                          size: 85,
                          color: colors.iconscolor,
                        ),
                      ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Tooltip(
                      message: widget.user.userName,
                      child: Container(
                        //     margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: widget.user.userName!.length <= 10
                            ? Text(
                                widget.user.userName ?? '',
                                style: TextStyle(
                                    fontFamily: 'Epilouge',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(widget.user.userName!.replaceRange(
                                10, widget.user.userName!.length, '..')),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Tooltip(
                      message: widget.user.email,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: widget.user.email!.length <= 10
                            ? Text(widget.user.email ?? '')
                            : Text(widget.user.email!.replaceRange(
                                10, widget.user.email!.length, '..')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SendEmail(user: widget.user)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: Text(
                    'Contact',
                    style: TextStyle(color: colors.blue_base),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: Text(
                    'Ban',
                    style: TextStyle(color: colors.red_base),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
