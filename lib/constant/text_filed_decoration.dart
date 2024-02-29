import 'package:flutter/material.dart';

const textFiledDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
    borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 78), width: 2.0),
  ),
  contentPadding: EdgeInsets.all(18),
  // border: InputBorder.none,
  // border: InputBorder.none,
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  hintStyle: TextStyle(fontFamily: 'font3'),
);
