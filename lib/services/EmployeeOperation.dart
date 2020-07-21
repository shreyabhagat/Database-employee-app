import 'package:DatabaseDemo/models/employee.dart';
import 'package:DatabaseDemo/services/databaseHelper.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeOperation {
  EmployeeOperation._();

  static final EmployeeOperation instance = EmployeeOperation._();

  Future<int> addEmployee(Employee employee) async {
    Database db = await DatabaseHelper.instance.database;
    return db.insert('Employees', employee.toMap());
  }

  Future<int> deleteEmployee(Employee employee) async {
    Database db = await DatabaseHelper.instance.database;
    return db.delete('employees', where: 'id=?', whereArgs: [employee.id]);
  }

  Future<int> editEmployee(Employee employee) async {
    Database db = await DatabaseHelper.instance.database;
    return db.update('employees', employee.toMap(),
        where: 'id=?', whereArgs: [employee.id]);
  }

  Future<List<Employee>> getAlEmployee() async {
    Database db = await DatabaseHelper.instance.database;

    List<Map<String, dynamic>> maps = await db.query('employees');

    List<Employee> employees = [];

    for (int i = 0; i < maps.length; i++) {
      employees.add(Employee.fromMap(maps[i]));
    }
    return employees;
  }
}
