import 'package:fetch_api/services/employee_services.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee data"),
        actions: [
          IconButton(
              onPressed: () {
                print(EmployeeServices().getAllEmployeeData());
              },
              icon: Icon(Icons.refresh))
        ],
      ),
    );
  }
}