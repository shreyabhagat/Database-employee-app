import 'package:flutter/material.dart';

class PushToNextPage {
  static jump(BuildContext context, Widget page) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => page),
    );
  }
}
