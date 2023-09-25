import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// uuid is third party package for generating unique id's. We are using outside of the class so that other classes can use the same.
const uuid = Uuid();

final dateFormatter = DateFormat.yMd();

// enum is used to create custom type like string, int and all...
enum Category { travel, food, miscellaneous, rent, goods }

// creating map for category icons

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.rent: Icons.home,
  Category.goods: Icons.smartphone_sharp,
  Category.miscellaneous: Icons.pages_rounded,
};

class Expense {
  Expense(
      {required this.cost,
      required this.dateTime,
      required this.title,
      required this.category})
      : id = uuid.v4();

  final String title;
  final double cost;
  final DateTime dateTime;
  final Category category;
  final String id;

  String get fomattedDate {
    return dateFormatter.format(dateTime);
  }
}
