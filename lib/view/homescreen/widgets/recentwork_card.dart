import 'package:flutter/material.dart';

class RecentWorkTile extends StatelessWidget {
  final String workerName;
  final String service;
  final double rating;

  RecentWorkTile(this.workerName, this.service, this.rating);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(workerName),
        subtitle: Text(service),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(rating.toString()),
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
