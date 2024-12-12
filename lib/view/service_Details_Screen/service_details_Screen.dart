import 'package:flutter/material.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final String serviceName;
  final IconData serviceIcon;
  final String serviceDescription;
  final List<String> features;

  ServiceDetailsScreen({
    required this.serviceName,
    required this.serviceIcon,
    required this.serviceDescription,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                children: [
                  Icon(serviceIcon, size: 48, color: Colors.blue),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      serviceName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Description Section
              Text(
                "About the Service",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                serviceDescription,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 24),

              // Features Section
              Text(
                "Key Features",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              ...features.map((feature) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 24),

              // Action Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality for booking or contacting
                  },
                  child: Text("Book Now"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: ServiceDetailsScreen(
//       serviceName: "Plumbing",
//       serviceIcon: Icons.plumbing,
//       serviceDescription: "Professional plumbing services for all your needs. We handle repairs, installations, and maintenance with precision and care.",
//       features: [
//         "24/7 Availability",
//         "Experienced Professionals",
//         "Affordable Pricing",
//         "Guaranteed Quality",
//       ],
//     ),
//   ));
// }
