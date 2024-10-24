import 'dart:convert';

import 'package:fetch_api/models/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeServices {
  String baseUrl = "https://reqres.in/api/";

  getAllEmployeeData() async {
    List<Employee> allEmployees = [];

    try {
      var response = await http.get(Uri.parse(baseUrl + "users?page=1"));
      if (response.statusCode == 200) {
        var data = response.body;
        var decodeData = jsonDecode(data);
        var employees = decodeData['data'];

        for (var employee in employees) {
          Employee newEmployee = Employee.fromJson(employee);
          allEmployees.add(newEmployee);
        }

        print(allEmployees);
        return allEmployees;
      } else {}
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
