import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttontext;
  final Function onButtonPressed;

  const RoundedButton(
      {Key? key, required this.buttontext, required this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: const Color(0xFF6180CF),
      borderRadius: BorderRadius.circular(8),
      child: MaterialButton(
        onPressed: () {
          onButtonPressed();
        },
        minWidth: 800,
        height: 50,
        child: Text(
          buttontext,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
