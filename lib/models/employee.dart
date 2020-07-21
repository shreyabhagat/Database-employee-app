class Employee {
  int id;
  String name;
  String post;
  int salary;

  Employee({this.id, this.name, this.post, this.salary});

  Employee.fromMap(Map<String, dynamic> maps) {
    this.id = maps['id'];
    this.name = maps['name'];
    this.post = maps['post'];
    this.salary = maps['salary'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();

    map['id'] = this.id;
    map['name'] = this.name;
    map['post'] = this.post;
    map['salary'] = this.salary;

    return map;
  }
}
