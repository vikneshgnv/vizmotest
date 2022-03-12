import 'dart:convert';
import 'package:http/http.dart';
import 'package:vizmotest/repository/api/apiClient.dart';
import 'package:vizmotest/repository/models/checkInModel.dart';


class CheckInApi{
  ApiClient _apiClient = ApiClient();

  //api endpoint
  String _getAllEmployeePath = '/employee';

  //future to fetch all checkin data with employee id
  Future<List<CheckInModel>> fetchAllCheckInList(int id) async {
    Response response =
    await _apiClient.invokeAPI(_getAllEmployeePath+'/$id/checkin', 'GET', null);

    return CheckInModel.listFromJson(jsonDecode(response.body));


  }

  //future to fetch all checkin data with employee id
  Future<List<CheckInModel>> fetchCheckInwithCheckInId(int employeeId,int checkInID) async {
    Response response =
    await _apiClient.invokeAPI(_getAllEmployeePath+'/$employeeId/checkin/$checkInID', 'GET', null);

    return CheckInModel.listFromJson([jsonDecode(response.body)]); // add single checkin as a list


  }


}