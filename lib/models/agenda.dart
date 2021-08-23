import 'package:flutter/foundation.dart';


class Agenda  with ChangeNotifier {
  final String userId;
  final String title;
  final String details;
  final String myDate;
  final String colorTwo;
  final String colorOne;

  Agenda({
    @required this.userId,
    @required this.title,
    @required this.details,
    @required this.myDate,
    @required this.colorTwo,
    @required this.colorOne,
  });
}