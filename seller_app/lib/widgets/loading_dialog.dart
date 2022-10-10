import 'package:seller_app/widgets/progress.dart';
import 'package:flutter/material.dart';


class LoadingDialog extends StatelessWidget {
  final String? message;

  LoadingDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          SizedBox(height: 10,),
          Text(message! + " Please Wait..."),
        ]
      ),
    );
  }
}
