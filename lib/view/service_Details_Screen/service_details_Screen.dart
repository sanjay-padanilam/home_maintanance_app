import 'package:flutter/material.dart';

class ServiceDetailsScreen extends StatefulWidget {
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
  _ServiceDetailsScreenState createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  String? _selectedFeature;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.serviceName),
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
                  Icon(widget.serviceIcon, size: 48, color: Colors.blue),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.serviceName,
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
                widget.serviceDescription,
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
              Column(
                children: widget.features.map((feature) {
                  return RadioListTile<String>(
                    title: Text(feature),
                    value: feature,
                    groupValue: _selectedFeature,
                    onChanged: (value) {
                      setState(() {
                        _selectedFeature = value;
                      });
                    },
                  );
                }).toList(),
              ),

              SizedBox(height: 24),

              // Action Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedFeature != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You selected: $_selectedFeature'),
                        ),
                      );
                      // Add additional functionality for booking or processing
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a feature first!'),
                        ),
                      );
                    }
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
