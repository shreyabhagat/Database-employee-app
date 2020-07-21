import 'package:DatabaseDemo/models/employee.dart';
import 'package:DatabaseDemo/services/EmployeeOperation.dart';
import 'package:flutter/material.dart';

class AddEmployee extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: addEmployeeToDatabase(context),
    );
  }

  Widget addEmployeeToDatabase(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        TextField(
          textCapitalization: TextCapitalization.words,
          controller: nameController,
          decoration: InputDecoration(
            hintText: 'Name',
          ),
        ),
        SizedBox(height: 16),
        TextField(
          textCapitalization: TextCapitalization.words,
          controller: postController,
          decoration: InputDecoration(
            hintText: 'Post',
          ),
        ),
        SizedBox(height: 16),
        TextField(
          keyboardType: TextInputType.number,
          controller: salaryController,
          decoration: InputDecoration(
            hintText: 'Salary',
          ),
        ),
        SizedBox(height: 16),
        RaisedButton(
          child: Text('Add Employee'),
          onPressed: () {
            addDataToDatabase(context);
          },
        )
      ],
    );
  }

  void addDataToDatabase(BuildContext context) async {
    String name = nameController.text;
    String post = postController.text;
    int salary = int.parse(salaryController.text);

    Employee employee = Employee(name: name, post: post, salary: salary);

    await EmployeeOperation.instance.addEmployee(employee);

    Navigator.pop(context);
  }
}
