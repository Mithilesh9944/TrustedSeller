import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'UtilPages.dart';

class UtilButtons{

  //Button
  static Widget buildButton({required String title,required BuildContext context,required String route}) {

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 109, 174, 231),
        minimumSize: const Size(double.infinity, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed:(){
        Future.delayed(const Duration(milliseconds: 100), () {
          Navigator.of(context).pushNamed(route);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => MyLogin()),
          // );
        });
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),

    );
  }

}