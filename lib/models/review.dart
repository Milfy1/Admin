import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';
import '../provider/customer.dart';

class Review {
  String uid;
  String name;
  String profileimg;
  double rate;
  String comment;
  String time;

  Review(
      {required this.uid,
      required this.name,
      required this.profileimg,
      required this.rate,
      required this.comment,
      required this.time});

  static Future<void> addRate(String gymid, double rate, String uid) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('Customer').doc(uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      Customer c1 = Customer.fromJson(data, uid);
      DateTime startDate = await NTP.now();
      FirebaseFirestore.instance
          .collection("gyms")
          .doc(gymid)
          .collection("Review")
          .doc(uid)
          .set({
        'uid': c1.uid,
        'name': c1.name,
        'rate': rate,
        'comment': '',
        'profilePicture': c1.profilePicture,
        'time': startDate
      });
      addGymReviewed(uid, gymid);
    }
  }

  static Future<void> addReviwe(
      String gymid, double rate, String comment, String uid) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('Customer').doc(uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

      Customer c1 = Customer.fromJson(data, uid);
      DateTime startDate = DateTime.now();
      FirebaseFirestore.instance
          .collection("gyms")
          .doc(gymid)
          .collection("Review")
          .doc(uid)
          .set({
        'uid': c1.uid,
        'name': c1.name,
        'rate': rate,
        'comment': comment,
        'profilePicture': c1.profilePicture,
        'time': startDate
      });
      addGymReviewed(uid, gymid);
    }
  }

  // void addGymsReviewed(String uid, String gymid) async {
  //   await FirebaseFirestore.instance
  //       .collection('Customer')
  //       .doc(uid)
  //       .set({'like': gymid});
  // }

  static Future<void> deleteReview(String gymid, String uid) async {
    FirebaseFirestore.instance
        .collection("gyms")
        .doc(gymid)
        .collection("Review")
        .doc(uid)
        .delete();
    deleteGymReviewed(uid, gymid);
  }

  static Review fromList(QueryDocumentSnapshot<Object?> data) {
    String time = getTime(data.get('time'));
    return Review(
        uid: data.get('uid'),
        name: data.get('name'),
        profileimg: data.get('profilePicture'),
        rate: data.get('rate').toDouble(),
        comment: data.get('comment'),
        time: time);
  }

  static String getTime(Timestamp timestamp) {
    String time;
    int year = timestamp.toDate().year;
    int month = timestamp.toDate().month;
    int day = timestamp.toDate().day;
    time = DateFormat.yMMMMd().format(DateTime(year, month, day));
    return time;
  }

  static Future<Review?> getUserreview(String gymid, String uid) async {
    Review userrevew = Review(
        uid: '', name: '', profileimg: '', rate: 0.0, comment: '', time: '');
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Gyms')
        .doc(gymid)
        .collection('Review')
        .doc(uid)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return userrevew = Review.fromjson(data);
    }
    return null;
  }

  static Future<bool> searchForReview(String uid, String gymId) async {
    List _gyms;
    var _data =
        await FirebaseFirestore.instance.collection('Customer').doc(uid).get();
    Map<String, dynamic> _userdate = _data.data() as Map<String, dynamic>;
    _gyms = _userdate['reviews'];

    for (var gymid in _gyms) {
      if (gymid == gymId) return true;
    }

    return false;
  }

  static addGymReviewed(String uid, String gymId) async {
    FirebaseFirestore.instance.collection('Customer').doc(uid).update({
      'reviews': FieldValue.arrayUnion([gymId])
    });
  }

  static deleteGymReviewed(String uid, String gymId) {
    FirebaseFirestore.instance.collection('Customer').doc(uid).update({
      'reviews': FieldValue.arrayRemove([gymId])
    });
  }

  static getcomments(String gymid) {
    return FirebaseFirestore.instance
        .collection('gyms')
        .doc(gymid)
        .collection('Review')
        .orderBy('time', descending: true)
        .snapshots();
  }

  static Future<void> setRateToGym(String gymid) async {
    double sum = 0;
    var snapshot = await FirebaseFirestore.instance
        .collection('gyms')
        .doc(gymid)
        .collection('Review')
        .get();
    if (snapshot.size == 0) {
      setAvgRate(gymid, 0.0);
    } else {
      int size = snapshot.docs.length;
      for (var doc in snapshot.docs) {
        sum += doc.get('rate');
      }

      double avg = sum / size;
      var s = avg.toStringAsFixed(2);
      avg = double.parse(s);

      setAvgRate(gymid, avg);
    }
    ;
  }

  static setAvgRate(String gymid, double avg) {
    FirebaseFirestore.instance
        .collection('gyms')
        .doc(gymid)
        .update({'Avg_rate': avg});
  }

  factory Review.fromjson(Map<String, dynamic> data) {
    return Review(
        uid: data['uid'],
        name: data['name'],
        profileimg: data['profilePicture'],
        rate: data['rate'],
        comment: data['comment'],
        time: data['time'].toString());
  }
}
