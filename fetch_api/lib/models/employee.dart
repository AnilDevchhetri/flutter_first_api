class Employee {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Employee({this.id, this.email, this.firstName, this.lastName, this.avatar});

  Employee.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.email = json['email'];
    this.firstName = json['first_name'];
    this.lastName = json['last_name'];
    this.avatar = json['avatar'];
  }
}
