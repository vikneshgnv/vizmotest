import 'dart:convert';
import 'package:http/http.dart';
import 'package:vizmotest/repository/api/apiClient.dart';
import 'package:vizmotest/repository/models/employeeModel.dart';

class EmployeeApi{
  ApiClient _apiClient = ApiClient();

  //api endpoint
  String _getAllEmployeePath = '/employee';

  //future to fetch all employee data
  Future<List<EmployeeModel>> fetchEmployeeList() async {
    Response response =
    await _apiClient.invokeAPI(_getAllEmployeePath, 'GET', null);

    return EmployeeModel.listFromJson(jsonDecode(response.body));


  }


  //future to fetch employee data through pagination
  Future<List<EmployeeModel>> fetchEmployeeListByPagination(int pageNumber, int limit) async {
    Response response =
    await _apiClient.invokeAPI(_getAllEmployeePath+'?page=$pageNumber&limit=$limit', 'GET', null);

    return EmployeeModel.listFromJson(jsonDecode(response.body));

  }

  //future to sort employee list
  Future<List<EmployeeModel>> sortEmployeeList(String sortBy, String order) async {
    String url;
    if(order.isEmpty || order == null){
     url = _getAllEmployeePath+'?sortBy=${sortBy}';
    }
    else{
      url = _getAllEmployeePath+'?sortBy=${sortBy}&order=${order}';
    }
    Response response =
    await _apiClient.invokeAPI(url, 'GET', null);

    return EmployeeModel.listFromJson(jsonDecode(response.body));

  }

  //future to search employee list
  Future<List<EmployeeModel>> searchEmployeeListByName(String value) async {

    Response response =
    await _apiClient.invokeAPI( _getAllEmployeePath+'?search=${value}', 'GET', null);

    return EmployeeModel.listFromJson(jsonDecode(response.body));

  }

  //future to filter employee list
  Future<List<EmployeeModel>> filterEmployeeListByName(String value) async {

    Response response =
    await _apiClient.invokeAPI( _getAllEmployeePath+'?search=${value}', 'GET', null);

    return EmployeeModel.listFromJson(jsonDecode(response.body));

  }

  //filter employee list by name & country
  Future<List<EmployeeModel>> filterEmployeeListByNameandCountry(String country,String name) async {

    Response response =
    await _apiClient.invokeAPI( _getAllEmployeePath+'?country=${country}&name=${name}', 'GET', null);

    return EmployeeModel.listFromJson(jsonDecode(response.body));

  }


  //filter employee list by any parameter
  Future<List<EmployeeModel>> filterEmployeeList(EmployeeModel employeeModel) async {

    Response response =
    await _apiClient.invokeAPI( _getAllEmployeePath+'?country=${employeeModel.country}&name=${employeeModel.name}&id=${employeeModel.id}&phone=${employeeModel.phone}&email=${employeeModel.email}&department=${employeeModel.department!.first.toString()}', 'GET', null);

    return EmployeeModel.listFromJson(jsonDecode(response.body));

  }
}