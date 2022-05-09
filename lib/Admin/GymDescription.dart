import 'dart:io';
import 'package:Admin/Admin/AllGyms.dart';
import 'package:Admin/Admin/Contact.dart';
import 'package:Admin/Admin/commentCard.dart';
import 'package:Admin/Admin/locationmap.dart';
import 'package:Admin/models/profile_model.dart';
import 'package:Admin/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Admin/models/GymModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:Admin/models/review.dart';
import 'package:Admin/Styles.dart';

//import 'package:Admin/models/user.dart';

class GymDescrption extends StatefulWidget {
  GymModel gym;
  final bool isNew;
  //List<Placelocation> gymsaddress;
  //final String userid;
  GymDescrption({
    Key? key,
    required this.isNew,
    //required this.gymsaddress,
    required this.gym,
  }) : super(key: key);
  static const routeName = '/gym';

  @override
  _GymDescrptionState createState() => _GymDescrptionState();
}

class _GymDescrptionState extends State<GymDescrption> {
  // int pricess = 6;
  ProfileModel user = ProfileModel('', '', '');
  String distance = 'Loading...';
  List<Review> reviews = [];
  Review? userReview;
  List<String> listReviews = [];
  String currentPrice = '';
  int activeIndex = 0;
  final controller = CarouselController();
  String? window = 'Description';
  windowChoose(windows) {
    switch (windows) {
      case 'Comments':
        setState(() {
          window = 'Comments';
        });
        print('comm');
        break;
      case 'Facilites':
        setState(() {
          window = "Facilites";
        });
        print('fac');
        break;
      case 'Description':
        setState(() {
          window = 'Description';
        });
        print('des');
        break;
      // default:
      //   setState(() {
      //     window = '';
      //   });
    }
  }

  @override
  void initState() {
    super.initState();
    getDistance();
  }

  void getDistance() async {
    final _dis = await Placelocation.calculateDistance(widget.gym.location!);
    if (mounted)
      setState(() {
        distance = _dis;
      });
  }

  deleteGym() {
    var snapshot = FirebaseFirestore.instance
        .collection('gyms')
        .doc(widget.gym.gymId)
        .collection('Review')
        .snapshots();
    //Delete reviews
    FirebaseFirestore.instance
        .collection('gyms')
        .doc(widget.gym.gymId)
        .collection('Review')
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });

    snapshot.forEach((element) {
      element.docs.clear();
    });
    listReviews.clear();
    snapshot.forEach((element) {
      element.docs.forEach((element) {
        setState(() {
          listReviews.add(element.id);
        });
      });
      print(listReviews);
      if (listReviews.isNotEmpty) {
        for (var i = 0; i < listReviews.length; i++) {
          print(listReviews);
          FirebaseFirestore.instance
              .collection('Customer')
              .doc(listReviews[i])
              .update({
            'reviews': FieldValue.arrayRemove([widget.gym.gymId])
          }).then((value) => {
                    FirebaseFirestore.instance
                        .collection('gyms')
                        .doc(widget.gym.gymId)
                        .delete()
                        .then((value) => Navigator.of(context).pop())
                        .then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => AllGyms(
                                      isNew: widget.isNew,
                                    ))))
                  });
        }
      } else {
        FirebaseFirestore.instance
            .collection('gyms')
            .doc(widget.gym.gymId)
            .delete()
            .then((value) => Navigator.of(context).pop())
            .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AllGyms(
                          isNew: widget.isNew,
                        ))));
      }
    });
    AppUser.message(context, true, "Gym is Deleted");
  }

  Widget AlertDialogs() {
    return AlertDialog(
      title: Text(
        'Delete Gym?',
        style: TextStyle(color: colors.red_base),
      ),
      content: Text('Are you sure you want to delete this gym?'),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
              deleteGym();
            },
            child: Text(
              'Yes',
              style: TextStyle(color: colors.red_base),
            )),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: TextStyle(color: colors.blue_base),
            )),
      ],
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 24,
      // backgroundColor: colors.blue_smooth,
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: widget.gym.images!.length,
        onDotClicked: animateToSlide,
        effect: ScrollingDotsEffect(
          //   strokeWidth: 100,
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: colors.blue_base,
          dotColor: Colors.grey,
        ),
      );

  void animateToSlide(int index) => controller.animateToPage(index);

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: const Text(
                'Whoops!',
                style: TextStyle(fontSize: 30, color: colors.black60),
              ),
            );
          },
        ),
      ); // Container
  Widget display() {
    if (window == 'Description') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
          ),
          Expanded(
              child: Container(
            // decoration: BoxDecoration(
            //    borderRadius: BorderRadius.circular(10.0),
            //   border: Border.all(color: colors.blue_smooth),
            //  ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  widget.gym.description ?? '',
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                ),
              ),
            ),
          )),
          SizedBox(
            width: 30,
          ),
        ],
      );
    } else if (window == "Comments") {
      return StreamBuilder<QuerySnapshot>(
        stream: Review.getcomments(widget.gym.gymId ?? ''),
        builder: (context, snapshot) {
          reviews.clear();

          if (snapshot.hasData) {
            for (QueryDocumentSnapshot<Object?> comment
                in snapshot.data!.docs) {
              reviews.add(Review.fromList(comment));
            }
// put user review
// currentUserRev(reviews);
// show all reviews
            List<Widget> commentCards = [];
            for (var item in reviews) {
              commentCards.add(commentCard(review: item));
            }
            return Column(
              children: commentCards,
            );
          }

          return CircularProgressIndicator(
            color: colors.blue_base,
          );
        }, //end then
      );
    } else if (window == 'Facilites') {
      return Column(
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (var fac in widget.gym.faciltrs!)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: colors.blue_smooth),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      child: Text(
                        fac,
                        style: TextStyle(
                          color: colors.blue_base,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: widget.gym.images!.isNotEmpty
                  ? CarouselSlider.builder(
                      carouselController: controller,
                      options: CarouselOptions(
                        height: 400,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                      ),
                      itemCount: widget.gym.images!.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = widget.gym.images![index];
                        return buildImage(urlImage, index);
                      },
                    )
                  : Container(
                      child: Text('There are no images uploaded for this gym'),
                    )),
          SizedBox(
            height: 20,
          ),
          widget.gym.images!.isNotEmpty
              ? buildIndicator()
              : SizedBox(
                  height: 20,
                ),
        ],
      );
    }
    return Text('data');
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   setState(() {});
    // });

    GymModel gym = widget.gym;
    // String uid = widget.gym.ownerId!;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("View Gym",
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: colors.blue_base,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: screenWidth,
                  height: 700,
                  child: Image.network(
                    gym.imageURL ?? '',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 600,
                  left: 10,
                  child: Container(
                    child: Text(
                      gym.name ?? '',
                      style: TextStyle(
                          //   color: Colors.white,
                          fontFamily: 'Epilogue',
                          fontSize: 100,
                          fontWeight: FontWeight.bold,
                          //  fontStyle: FontStyle.italic,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = colors.black100),
                    ),
                  ),
                ),
                Positioned(
                  top: 600,
                  left: 10,
                  child: Container(
                    child: Text(
                      gym.name ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Epilogue',
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        //    fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.black,
            ),
            Card(
              margin: EdgeInsets.all(10),
              elevation: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            distance,
                            style: TextStyle(fontSize: 40),
                          ),
                          Icon(
                            Icons.directions_walk_outlined,
                            size: 40,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 40,
                                color: colors.yellow_base,
                              ),
                              Text(
                                gym.avg_rate.toString(),
                                style: TextStyle(fontSize: 40),
                              ),
                            ],
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                widget.gym.reviews == 0
                                    ? 'No reviews yet'
                                    : "Based on " +
                                        widget.gym.reviews.toString() +
                                        " reviews",
                                style: TextStyle(fontSize: 30),
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            gym.priceOneDay != 0
                                ? FlatButton(
                                    minWidth: 5,
                                    child: Text(
                                      'Day',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceOneDay.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 30),
                                    ),
                                    color: currentPrice ==
                                            gym.priceOneDay.toString()
                                        //do this for all
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        currentPrice =
                                            gym.priceOneDay.toString();
                                      });
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(left: 10),
                                    // width: 30,
                                    child: Text(
                                      'Day',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 30),
                                    ),
                                  ),
                            gym.priceOneMonth != 0
                                ? FlatButton(
                                    minWidth: 5,
                                    child: Text(
                                      'Month',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceOneMonth.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 30),
                                    ),
                                    color: currentPrice ==
                                            gym.priceOneMonth.toString()
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        currentPrice =
                                            gym.priceOneMonth.toString();
                                      });
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(left: 5, right: 5),
                                    //  width: 50,
                                    child: Text(
                                      'Month',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 30),
                                    ),
                                  ),
                            gym.priceThreeMonths != 0
                                ? FlatButton(
                                    minWidth: 5,
                                    child: Text(
                                      '3 Months',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceThreeMonths
                                                      .toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 30),
                                    ),
                                    color: currentPrice ==
                                            gym.priceThreeMonths.toString()
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        currentPrice =
                                            gym.priceThreeMonths.toString();
                                      });
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        left: 5, right: 5), // width: 100,
                                    child: Text(
                                      '3 Months',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 30),
                                    ),
                                  ),
                            gym.priceSixMonths != 0
                                ? FlatButton(
                                    minWidth: 5,
                                    child: Text(
                                      '6 Months',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceSixMonths.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 30),
                                    ),
                                    color: currentPrice ==
                                            gym.priceSixMonths.toString()
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        currentPrice =
                                            gym.priceSixMonths.toString();
                                      });
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        left: 5, right: 5), //   width: 80,
                                    child: Text(
                                      '6 Months',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 30),
                                    ),
                                  ),
                            gym.priceOneYear != 0
                                ? FlatButton(
                                    minWidth: 5,
                                    child: Text(
                                      'Year',
                                      style: TextStyle(
                                          color: currentPrice ==
                                                  gym.priceOneYear.toString()
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 30),
                                    ),
                                    color: currentPrice ==
                                            gym.priceOneYear.toString()
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        currentPrice =
                                            gym.priceOneYear.toString();
                                      });
                                    },
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        left: 5, right: 5), //    width: 50,
                                    child: Text(
                                      'Year',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 30),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Container(
                        margin: EdgeInsets.only(right: 20),
                        child: currentPrice != ''
                            ? Text(
                                "${currentPrice} SAR",
                                style: TextStyle(fontSize: 30),
                              )
                            : Text('')),
                  ]),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              // margin: EdgeInsets.all(value),
              child: Card(
                  elevation: 2,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(),
                                  //  height: 30,
                                  width: 100,
                                  //  color: colors.red_base,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    color: window == 'Description'
                                        ? Color.fromARGB(195, 71, 153, 183)
                                        : Colors.white,
                                  ),
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text('Description',
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: window == 'Description'
                                                ? Colors.white
                                                : Colors.black,
                                          )),
                                    ],
                                  )),
                                ),
                                onTap: () {
                                  windowChoose('Description');
                                }),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.only(),

                                width: 100,
                                //  color: colors.red_base,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  color: window == 'Facilites'
                                      ? Color.fromARGB(195, 71, 153, 183)
                                      : Colors.white,
                                ),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      'Facilites',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: window == 'Facilites'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )
                                  ],
                                )),
                              ),
                              onTap: () {
                                windowChoose("Facilites");
                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Container(
                                margin: EdgeInsets.only(),

                                width: 100,
                                //  color: colors.red_base,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  color: window == 'Comments'
                                      ? Color.fromARGB(195, 71, 153, 183)
                                      : Colors.white,
                                ),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      'Comments',
                                      style: TextStyle(
                                        fontSize: 30,
                                        color: window == 'Comments'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    )
                                  ],
                                )),
                              ),
                              onTap: () {
                                windowChoose('Comments');
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      display(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
// End comments
      bottomNavigationBar: Row(
        children: [
          InkWell(
            onTap: () {
              if (widget.isNew) {
                FirebaseFirestore.instance
                    .collection('gyms')
                    .doc(widget.gym.gymId)
                    .update({'isWaiting': false})
                    .then((value) => Navigator.of(context).pop())
                    .then((value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => AllGyms(
                                  isNew: widget.isNew,
                                ))));

                AppUser.message(context, true, "Gym is Accepted");
              } else {
                var owner = FirebaseFirestore.instance
                    .collection('Gym Owner')
                    .doc(widget.gym.ownerId)
                    .get();
                owner.then((value) {
                  setState(() {
                    user.email = value['email'];
                    user.userName = value['name'];
                  });
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SendEmail(user: user)));
                });
              }
            },
            // splashColor: colors.blue_base,
            child: Container(
                color: widget.isNew ? colors.green_base : colors.blue_base,
                width: screenWidth / 2,
                height: 50,
                child: Center(
                    child: widget.isNew
                        ? Text(
                            'Accept Gym',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                          )
                        : Text(
                            'Contact Owner',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                          ))),
          ),
          InkWell(
            onTap: () {
              showDialog(context: context, builder: (_) => AlertDialogs());
            },
            child: Container(
                color: Color.fromARGB(230, 234, 60, 47),
                width: screenWidth / 2,
                height: 50,
                child: Center(
                  child: Text(
                    // userReview != null ? 'Edit my review' : "Write a review",
                    'Delete Gym',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
