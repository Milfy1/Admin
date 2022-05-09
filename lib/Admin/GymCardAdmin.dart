import 'package:Admin/Admin/GymDescription.dart';
import 'package:Admin/Styles.dart';
import 'package:flutter/material.dart';
import '../models/GymModel.dart';

class GymCardAdmin extends StatelessWidget {
  const GymCardAdmin({
    Key? key,
    required this.gymInfo,
    required this.isNew,
  }) : super(key: key);
  final GymModel gymInfo;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => GymDescrption(
                  gym: gymInfo,
                  isNew: isNew,
                )));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.35,
        //   width: MediaQuery.of(context).size.height * 0.7,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Color(0xff3d4343),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                offset: Offset(3, 3),
                spreadRadius: 2,
                blurRadius: 2,
              )
            ]),
        child: Column(
          children: [
            Expanded(
              // flex: 2,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                    width: double.infinity,
                    height: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: Image.network(gymInfo.imageURL ?? '',
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(50))),
                      child: Text(
                        gymInfo.name ?? '',
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color(0xff48484a),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        ' ' + gymInfo.avg_rate.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Icon(
                        Icons.star,
                        size: 45,
                        color: colors.yellow_base,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        gymInfo.reviews == 0
                            ? 'No reviews yet'
                            : "Based on " +
                                gymInfo.reviews.toString() +
                                " reviews",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "50 Km",
                      //       style: TextStyle(
                      //           fontSize: 20,
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     Icon(
                      //       Icons.directions_walk,
                      //       color: Colors.white,
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
