import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:home_maintanance_app/dummydb.dart';
import 'package:home_maintanance_app/view/homescreen/widgets/Service_tile.dart';
import 'package:home_maintanance_app/view/homescreen/widgets/recentwork_card.dart';
import 'package:home_maintanance_app/view/service_Details_Screen/service_details_Screen.dart';

class HomeScreen extends StatelessWidget {
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
                itemCount: Dummydb.services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceDetailsScreen(
                            serviceName: Dummydb.services[index]['name'],
                            serviceIcon: Dummydb.services[index]['icon'],
                            serviceDescription: Dummydb.services[index]
                                ['description'],
                            features: List<String>.from(
                                Dummydb.services[index]['features']),
                          ),
                        ));
                  },
                  child: ServiceTile(Dummydb.services[index]["name"],
                      Dummydb.services[index]["icon"]),
                ),
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
