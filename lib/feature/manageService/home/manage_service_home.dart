import 'package:doorcareworker/feature/manageService/site/google_map_page.dart';
import 'package:flutter/material.dart';

class ManageServiceHome extends StatelessWidget {
  const ManageServiceHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GoogleMapPage()));
              },
              child: Text('Google MAp'))),
    );
  }
}
