import 'package:DatabaseDemo/models/employee.dart';
import 'package:DatabaseDemo/services/EmployeeOperation.dart';
import 'package:flutter/material.dart';

class EditEmployee extends StatelessWidget {
  final Employee employee;

  EditEmployee({this.employee});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameController.text = employee.name;
    postController.text = employee.post;
    salaryController.text = employee.salary.toString();
    return Scaffold(
        appBar: AppBar(title: Text('Edit Employee')),
        body: editEmployeeToDatabase(context));
  }

  Widget editEmployeeToDatabase(BuildContext context) {
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
          child: Text('Edit Employee'),
          onPressed: () {
            editDataToDatabase(context, employee);
          },
        )
      ],
    );
  }

  void editDataToDatabase(BuildContext context, Employee emp) async {
    String name = nameController.text;
    String post = postController.text;
    int salary = int.parse(salaryController.text);

    Employee employee =
        Employee(id: emp.id, name: name, post: post, salary: salary);

    await EmployeeOperation.instance.editEmployee(employee);

    Navigator.pop(context);
  }
}
