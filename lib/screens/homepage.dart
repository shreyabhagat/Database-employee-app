import 'package:DatabaseDemo/models/employee.dart';
import 'package:DatabaseDemo/screens/addEmployee.dart';
import 'package:DatabaseDemo/screens/editEmployee.dart';
import 'package:DatabaseDemo/services/EmployeeOperation.dart';
import 'package:DatabaseDemo/services/push_to_next_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Employee> employee = [];
  void getData() async {
    List<Employee> emp = await EmployeeOperation.instance.getAlEmployee();

    setState(() {
      employee = emp;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          pushToAddEmployeePage(context);
        },
      ),
      body: employee.length == 0 ? noEmployee() : displayEmployee(),
    );
  }

  Future<void> pushToAddEmployeePage(BuildContext context) async {
    await PushToNextPage.jump(context, AddEmployee());
    getData();
  }

  Widget noEmployee() {
    return Center(
      child: Text('No Employee'),
    );
  }

  Widget displayEmployee() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
      itemCount: employee.length,
      itemBuilder: (BuildContext context, int index) {
        Employee emp = employee[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(emp.name[0]),
          ),
          title: Text(emp.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(emp.post),
              Text('\u20B9${emp.salary.toString()}'),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              deleteEmployee(emp);
            },
          ),
          onTap: () {
            pushToEditEmployeePage(emp);
          },
        );
      },
    );
  }

  void pushToEditEmployeePage(Employee employee) async {
    await PushToNextPage.jump(
      context,
      EditEmployee(employee: employee),
    );
    getData();
  }

  void deleteEmployee(Employee employee) async {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        'Warning',
        style: TextStyle(color: Colors.red),
      ),
      content: Text('Do you really want to delete ${employee.name}?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Yes'),
          onPressed: () async {
            await EmployeeOperation.instance.deleteEmployee(employee);
            getData();
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    await showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
