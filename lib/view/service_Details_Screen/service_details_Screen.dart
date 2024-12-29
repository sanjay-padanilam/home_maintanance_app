import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_maintanance_app/view/service_Details_Screen/service_details_screen_controller/service_screen_controller.dart';

class ServiceDetailsScreen extends ConsumerStatefulWidget {
  final String? servicename;
  const ServiceDetailsScreen({super.key, this.servicename});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends ConsumerState<ServiceDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _placecontroller = TextEditingController();
  TextEditingController _housenamecontroller = TextEditingController();
  TextEditingController _phonenumbercontroller = TextEditingController();

  // Regular expression for validating a 10-digit phone number
  final String phonePattern = r'^[0-9]{10}$';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('service details'),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  // Name Field
                  TextFormField(
                    controller: _namecontroller,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your full name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  // Place Field
                  TextFormField(
                    controller: _placecontroller,
                    decoration: InputDecoration(
                      labelText: 'Place',
                      hintText: 'Enter your place',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your place';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  // House Name Field
                  TextFormField(
                    controller: _housenamecontroller,
                    decoration: InputDecoration(
                      labelText: 'House Name',
                      hintText: 'Enter your house name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your house name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  // Phone Number Field
                  TextFormField(
                    controller: _phonenumbercontroller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Enter a 10-digit phone number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      RegExp regExp = RegExp(phonePattern);
                      if (!regExp.hasMatch(value)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.0),
                  // Submit Button
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')),
                        );
                        ref
                            .read(ServiceScreenStateProvider.notifier)
                            .addOrderToFirebase(
                              context: context,
                              houseName: _housenamecontroller.text,
                              name: _namecontroller.text,
                              phoneNumber: _phonenumbercontroller.text,
                              place: _placecontroller.text,
                              serviceName: widget.servicename,
                              userId: FirebaseAuth.instance.currentUser!.uid
                                  .toString(),
                              status: 'pending',
                            );

                        // Proceed with further processing using the saved values
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
