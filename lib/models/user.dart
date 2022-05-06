import 'dart:io';

//import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../Styles.dart';

//import 'package:gymhome/models/Owner.dart';
//import 'package:gymhome/provider/customer.dart';
//import 'package:gymhome/widgets/welcome.dart';

//import 'package:image_picker/image_picker.dart';

//import '../GymOwnerwidgets/ownerhome.dart';
//import '../widgets/newhome.dart';

//import 'package:gymhome/models/userdata.dart';

class AppUser {
  // String email;
  // String name;
  // String password;
  // String userid = '';
  // bool iscustomer = false;
  // String messages = '';
  // User(
  //     {required this.email,
  //     required this.name,
  //     required this.password,
  //     required this.iscustomer});

  // User(email, name, bool customer) {
  //   this.email = email;
  //   this.name = name;
  //   this.iscustomer = customer;
  // }
  // void setCustomerDate(bool iscustomer, String uid, String name, String email,
  //     String profilePicture) async {
  //   final _userdate = await SharedPreferences.getInstance();
  //   _userdate.setBool('iscustomer', iscustomer);
  //   _userdate.setString('email', email);
  //   _userdate.setString('name', name);
  //   _userdate.setString('uid', uid);
  //   _userdate.setString('profilePicture', profilePicture);
  // }
  // static void logout(BuildContext cxt) {
  //   UserData.deleteUserData();
  //   Navigator.of(cxt).pushReplacement(MaterialPageRoute(
  //     builder: (context) => welcome(),
  //   ));
  // }

  // static Future signup(bool customer, String email, String name,
  //     String password, BuildContext cxt) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     //   .then((user) {
  //     // if (user != null) {
  //     //   user.user!.sendEmailVerification();
  //     // }
  //     // });

  //  String userid = FirebaseAuthWeb.instance.currentUser!.uid;
  //     String profilePicture =
  //         'https://firebasestorage.googleapis.com/v0/b/gymshome-ce96b.appspot.com/o/DefaultProfilePic.jpg?alt=media&token=e175c7f8-55f2-4575-8315-9bc5a527fd9b';
  //     UserData.setUserDate(customer, userid, name, email);
  //     if (customer) {
  //       Customer _currentc = Customer(
  //           name: name,
  //           profilePicture: profilePicture,
  //           uid: userid,
  //           email: email);
  //       FirebaseFirestore.instance.collection("Customer").doc(userid).set({
  //         'name': _currentc.name,
  //         'email': _currentc.email,
  //         'reviews': [],
  //         'Likes': [],
  //         'compare': [],
  //         'profilePicture': _currentc.profilePicture
  //       });

  //       Navigator.of(cxt).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => NewHome(
  //               // currentc: _currentc,
  //               ),
  //         ),
  //       );
  //     } else {
  //       FirebaseFirestore.instance
  //           .collection("Gym Owner")
  //           .doc(userid)
  //           .set({'name': name, 'email': email});
  //       // Navigator.of(cxt).pushNamed(OwnerHome.rounamed);
  //       Navigator.of(cxt).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => OwnerHome(
  //               // currentc: _currentc,
  //               ),
  //         ),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     String messages = e.code;

  //     if (e.code == 'weak-password') {
  //       messages = 'The password provided is too weak.';
  //     } else if (e.code == 'email-already-in-use') {
  //       messages = 'The account already exists for that email.';
  //     }

  //     message(cxt, false, messages);
  //   }
  //   //end catch
  // } //end signup

  // static Future login(String email, String password, BuildContext cxt) async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     String userid = FirebaseAuth.instance.currentUser!.uid;
  //     var collection = FirebaseFirestore.instance.collection('Gym Owner');
  //     var docSnapshot = await collection.doc(userid).get();
  //     if (docSnapshot.exists) {
  //       Owner _currentOwner =
  //           Owner.fromjson(docSnapshot.data() as Map<String, dynamic>, userid);
  //       UserData.setUserDate(
  //           false, userid, _currentOwner.name, _currentOwner.email);
  //       Navigator.of(cxt).pushReplacement(MaterialPageRoute(
  //         builder: (context) => OwnerHome(),
  //       ));
  //     } else {
  //       var _currentcustomer = await FirebaseFirestore.instance
  //           .collection('Customer')
  //           .doc(userid)
  //           .get();
  //       Customer _currentc = Customer.fromJson(
  //           _currentcustomer.data() as Map<String, dynamic>, userid);
  //       UserData.setUserDate(
  //           true, _currentc.uid, _currentc.name, _currentc.email);
  //       Navigator.of(cxt).pushReplacement(
  //         MaterialPageRoute(
  //           builder: (context) => NewHome(),
  //         ),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     String messages = e.code;
  //     message(cxt, false, messages);
  //   }
  // }

  // static Future resetpass(String email, BuildContext cxt) async {
  //   String messages;
  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  //     messages = 'Check your email';
  //     message(cxt, true, messages);
  //   } on FirebaseAuthException catch (e) {
  //     messages = e.code;
  //     if (messages == 'unknown') messages = 'enter correct email';
  //     message(cxt, false, messages);
  //   }
  // }

//  static Future<void> logout() async {
//     _token = 'null';
//     _userId = 'null';
//     _expiryDate = 'null' as DateTime;
//     if (_authTimer != 'null') {
//       _authTimer.cancel();
//       _authTimer = 'null' as Timer;
//     }
  // notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     // prefs.remove('userData');
//     prefs.clear();
//   }

  // static bool areYousure(
  //     BuildContext cxt, String title, String messame, Function? function) {
  //   bool sure;

  //   showDialog<bool>(
  //     context: cxt,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: Text(title, style: TextStyle(color: colors.blue_base)),
  //       content: Text(messame, style: TextStyle(color: colors.black60)),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context, false),
  //           child:
  //               const Text('Cancel', style: TextStyle(color: colors.red_base)),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             function;
  //             Navigator.pop(context, true);
  //           },
  //           child: const Text(
  //             'yes',
  //             style: TextStyle(color: colors.blue_base),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ).then((value) {
  //     return value;
  //   });
  //   return false;
  // }
  static warning(BuildContext cxt, String message) {
    ScaffoldMessenger.of(cxt).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 7),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: colors.yellow_base,
            ),
            Text(
              message,
              style: TextStyle(
                  color: colors.yellow_base,
                  fontFamily: 'Roboto',
                  fontSize: 16),
            ),
          ],
        ),
        backgroundColor: colors.yellow_smooth,
      ),
    );
  }

  static message(BuildContext cxt, bool iserror, String message) {
    ScaffoldMessenger.of(cxt).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iserror ? Icons.check : Icons.error_outline,
              color: iserror ? colors.green_base : colors.red_base,
            ),
            Text(
              message,
              style: TextStyle(
                  color: iserror ? colors.green_base : colors.red_base,
                  fontFamily: 'Roboto',
                  fontSize: 16),
            ),
          ],
        ),
        backgroundColor: iserror ? colors.green_smooth : colors.red_smooth,
      ),
    );
  }
}

File? _imageFile;

// get image method GALLERY
// Future getImageGallery() async {
//   final image =
//       await ImagePicker.platform.pickImage(source: ImageSource.gallery);
//   if (image == null) return;

//   final imageTemp = File(image.path);

//   _imageFile = imageTemp;
// }

// get image method CAMERA
// Future getImageCamera() async {
//   final image =
//       await ImagePicker.platform.pickImage(source: ImageSource.camera);
//   if (image == null) return;
//   final imageTemp = File(image.path);

//   _imageFile = imageTemp;
// }

//var userId = FirebaseAuth.instance.currentUser!.uid;

// Future uploadPicForUserProfile() async {
//   FirebaseStorage storage = FirebaseStorage.instance;
//   Reference ref = storage
//       .ref()
//       .child("$userId" + " ProfilePic " + DateTime.now().toString());
//   await ref.putFile(_imageFile!);
//   String imageurl = await ref.getDownloadURL();
//   FirebaseFirestore.instance
//       .collection('Customer')
//       .doc(userId)
//       .update({'profilePicture': imageurl});
// }
