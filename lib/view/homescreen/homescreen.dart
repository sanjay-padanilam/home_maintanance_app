import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/view/service_Details_Screen/service_details_Screen.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Stream<QuerySnapshot> _servicesStream =
      FirebaseFirestore.instance.collection('services').snapshots();

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    // Determine grid column count based on screen width
    final gridCrossAxisCount = screenWidth > 600 ? 3 : 2;

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: _servicesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          // Null check for snapshot.data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No services available'),
            );
          }

          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.shade300,
                    Colors.deepPurple.shade100
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Welcome, Sanjay",
                        style: TextStyle(
                          fontSize: screenWidth > 400
                              ? 24
                              : 18, // Responsive font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        radius: screenWidth > 400
                            ? 24
                            : 16, // Responsive avatar size
                        // backgroundImage:
                        //     AssetImage('assets/profile_placeholder.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Our Services.....",
                    style: TextStyle(
                      fontSize:
                          screenWidth > 400 ? 24 : 30, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  // Responsive Grid
                  Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCrossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio:
                            screenWidth > 600 ? 1.2 : 1, // Adjust card ratio
                      ),
                      itemBuilder: (context, index) {
                        final servicelist = snapshot.data!.docs;

                        return InkWell(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) {
                            //     ServiceDetailsScreen(servicename: 'plumbing');
                            //     return SizedBox();
                            //   },
                            // ));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 20,
                                  top: 20,
                                  child: Container(
                                    height: screenWidth > 400
                                        ? 80
                                        : 60, // Responsive size
                                    width: screenWidth > 400 ? 80 : 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              servicelist[index]['image'])),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: screenWidth > 400 ? 120 : 90,
                                  left: 30,
                                  child: Text(
                                    servicelist[index]['name'],
                                    style: TextStyle(
                                      fontSize: screenWidth > 400
                                          ? 16
                                          : 12, // Responsive text size
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
