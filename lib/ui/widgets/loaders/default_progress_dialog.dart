import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog {
  final BuildContext context;
  final String message;

  ProgressDialog(this.context, {this.message = ""});

  void show() {
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white.withOpacity(0.7),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CupertinoActivityIndicator(
                  radius: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void dismiss() {
    Navigator.pop(this.context);
  }
}
