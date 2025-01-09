import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //static const baseUrl = "http://10.0.2.2:3000";
  static const baseUrl = "http://localhost:3000";
  static RegisterUser(Map<String, dynamic> userData) async {
    print(userData);
    try {
    var postUrl = Uri.parse('$baseUrl/registerUser');
      final res = await http.post(postUrl, headers: {
    "Content-Type": "application/json",  
  },
  body: jsonEncode(userData),);
      if (res.statusCode == 200) {
        print("user register succesfully");
      } else {
        print("somthing wrong please try again");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
