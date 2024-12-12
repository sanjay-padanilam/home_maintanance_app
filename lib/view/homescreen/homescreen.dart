import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:home_maintanance_app/view/homescreen/widgets/Service_tile.dart';
import 'package:home_maintanance_app/view/homescreen/widgets/recentwork_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {
      'name': 'Electric',
      'icon': Icons.electric_bolt,
    },
    {
      'name': 'Plumbing',
      'icon': Icons.plumbing,
    },
    {
      'name': 'Cleaning',
      'icon': Icons.cleaning_services,
    },
    {
      'name': 'Repairing',
      'icon': Icons.build,
    },
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Service App',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          // Services Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Our Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              height: 100,
              child: GridView.builder(
                itemCount: services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) => ServiceTile(
                    services[index]["name"], services[index]["icon"]),
              )),
          // Top Deals Slider
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
                items: List.generate(
                  10,
                  (index) => Container(
                    height: size.height / 2,
                    width: size.width * 2 / 2.4,
                    color: Colors.black,
                  ),
                ),
                options:
                    CarouselOptions(autoPlay: true, enlargeCenterPage: true)),
          ),
          // Recent Work Ratings Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Recent Work & Ratings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          RecentWorkTile('John Doe', 'Electrician', 4.5),
          RecentWorkTile('Jane Smith', 'Plumber', 4.7),
          RecentWorkTile('Robert Brown', 'Cleaner', 4.0),
          RecentWorkTile('Emily White', 'Gardener', 4.8),
        ],
      ),
    );
  }
}
