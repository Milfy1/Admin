import 'package:cloud_firestore/cloud_firestore.dart';

class GymModel {
  List<dynamic>? images;
  List<dynamic>? faciltrs;
  List<dynamic>? prices;
  double? priceOneDay;
  double? priceOneMonth;
  double? priceThreeMonths;
  double? priceSixMonths;
  double? priceOneYear;
  String? imageURL;
  String? gymId;
  String? ownerId;
  String? name;
  String? description;
  GeoPoint? location;
  bool? isWaiting;
  bool? isComplete;
  String? gender;
  double? avg_rate;
  int? reviews;

  GymModel(
      this.images,
      this.faciltrs,
      this.prices,
      this.priceOneDay,
      this.priceOneMonth,
      this.priceOneYear,
      this.priceSixMonths,
      this.priceThreeMonths,
      this.imageURL,
      this.gymId,
      this.ownerId,
      this.name,
      this.description,
      this.location,
      this.isComplete,
      this.isWaiting,
      this.gender,
      this.avg_rate,
      this.reviews);

  GymModel.fromJson(Map<String, dynamic> json) {
    images = json['images'];
    faciltrs = json['faciltrs'];
    priceOneDay = double.parse(json['One Day'].toString());
    priceOneMonth = double.parse(json['One Month'].toString());
    priceThreeMonths = double.parse(json['Three Months'].toString());
    priceSixMonths = double.parse(json['Six Months'].toString());
    priceOneYear = double.parse(json['One Year'].toString());
    gymId = json['gymId'];
    imageURL = json['imageURL'];
    name = json['name'];
    description = json['descrption'];
    location = json['Location'];
    isWaiting = json['isWaiting'];
    isComplete = json['isComplete'];
    gender = json['gender'];
    avg_rate = double.parse(json['Avg_rate'].toString());
    reviews = json['reviews'];
  }
  GymModel.fromQ(QueryDocumentSnapshot<Object?> data) {
    images = data['images'];
    faciltrs = data['faciltrs'];
    priceOneDay = double.parse(data['One Day'].toString());
    priceOneMonth = double.parse(data['One Month'].toString());
    priceThreeMonths = double.parse(data['Three Months'].toString());
    priceSixMonths = double.parse(data['Six Months'].toString());
    priceOneYear = double.parse(data['One Year'].toString());
    gymId = data['gymId'];
    imageURL = data['imageURL'];
    name = data['name'];
    description = data['descrption'];
    location = data['Location'];
    isWaiting = data['isWaiting'];
    isComplete = data['isComplete'];
    gender = data['gender'];
    avg_rate = double.parse(data['Avg_rate'].toString());
    reviews = data['reviews'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['images'] = this.images;
  //   data['faciltrs'] = this.faciltrs;
  //   data['price'] = this.priceOndDay;
  //   data['price'] = this.priceOndMonth;
  //   data['price'] = this.priceThreeMonts;
  //   data['price'] = this.priceSixMonths;
  //   data['price'] = this.priceOneYear;
  //   data['imageURL'] = this.imageURL;
  //   data['name'] = this.name;
  //   data['description'] = this.description;
  //   data['location'] = this.location;
  //   data['isFavorite'] = this.isFavorite;
  //   return data;
  // }
}
