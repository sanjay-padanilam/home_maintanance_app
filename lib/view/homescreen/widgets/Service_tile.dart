import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  final String serviceName;
  final IconData icon;

  ServiceTile(this.serviceName, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 8),
            Text(
              serviceName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
