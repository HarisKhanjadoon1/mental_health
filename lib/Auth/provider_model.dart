import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProvideModel {
  final String? fullName;
  final String? email;
  final String? phone;
  final String? category;
  final String? profilepic;
  final String? uid;
  final String? title;
  final String? desc;
  final double? price;
  final List<String>? request;
  final List<String>? images;
  final List<String>? review;
  final List<String>? loaction;
  final String? accountcategory;
  final String? provider;

  ProvideModel(
      {this.fullName,
      this.email,
      this.phone,
      this.category,
      this.profilepic,
      this.uid,
      this.title,
      this.desc,
      this.price,
      this.request,
      this.images,
      this.review,
      this.loaction,
      this.accountcategory,
      this.provider});

  factory ProvideModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();

    return ProvideModel(
      fullName: data?['fullName'],
      email: data?['email'],
      phone: data?['phone'],
      category: data?['category'],
      profilepic: data?['profilepic'],
      uid: data?['uid'],
      title: data?['title'],
      desc: data?['desc'],
      price: data?['price'],
      request:
          data?['request'] is Iterable ? List.from(data?['request']) : null,
      images: data?['images'] is Iterable ? List.from(data?['images']) : null,
      review: data?['review'] is Iterable ? List.from(data?['review']) : null,
      loaction:
          data?['loaction'] is Iterable ? List.from(data?['loaction']) : null,
      accountcategory: data?['accountcategory'],
      provider: data?['provider'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (fullName != null) "fullName": fullName,
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
      if (category != null) "category": category,
      if (profilepic != null) "profilepic": profilepic,
      if (uid != null) "uid": uid,
      if (title != null) "title": title,
      if (desc != null) "desc": desc,
      if (price != null) "price": price,
      if (request != null) "request": request,
      if (images != null) "images": images,
      if (review != null) "review": review,
      if (loaction != null) "loaction": loaction,
      if (accountcategory != null) "accountcategory": accountcategory,
      if (provider != null) "accountcategory": accountcategory,
    };
  }
}
