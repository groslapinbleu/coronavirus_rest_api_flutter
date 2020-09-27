import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  const EndpointCard({Key key, @required this.title, @required this.data})
      : super(key: key);
  final String title;
  final int data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          SizedBox(
            width: 8,
          ),
          Text(data.toString()),
        ],
      ),
    );
  }
}
