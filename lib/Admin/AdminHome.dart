import 'package:flutter/material.dart';
import '../Admin/AddAdmin.dart';
import '../Admin/AllGyms.dart';
import '../Admin/Users.dart';
import '../Styles.dart';
//import 'package:gymhome/widgets/newhome.dart';
import 'package:path/path.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
      switch (value) {
        case 'Logout':
          break;
        case 'Add Admin':
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddAdmin()));
          break;
      }
    }

    Widget AlertDialogs() {
      return AlertDialog(
        title: Text('Delete Image?'),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Delete')),
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel')),
        ],
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 24,
        backgroundColor: colors.blue_smooth,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Admin ',
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: colors.blue_base,
          elevation: 0,
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Add Admin'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 250, 0),
                child: Text(
                  'Hi Admin..',
                  style: TextStyle(
                      color: colors.blue_base,
                      fontFamily: 'Epilogue',
                      fontStyle: FontStyle.italic,
                      fontSize: 23),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  height: 170,
                  width: 170,
                  child: ElevatedButton(
                    onPressed: () {
                      bool? isNew = true;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllGyms(
                                isNew: isNew,
                              )));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New Gyms ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '500 ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 7,
                        color: colors.blue_base,
                      ),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      primary: Colors.white, // <-- Button color
                      onPrimary: colors.blue_base, // <-- Splash color
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  height: 150,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      bool? isNew = false;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllGyms(isNew: isNew)));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Old Gyms ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '500 ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 7,
                        color: Colors.orange,
                      ),
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.orange, // <-- Splash color
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 120,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Users()));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Users ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '500 ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 7,
                        color: Colors.pink,
                      ),

                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      primary: Colors.white, // <-- Button color
                      onPrimary: Colors.pink, // <-- Splash color
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}
