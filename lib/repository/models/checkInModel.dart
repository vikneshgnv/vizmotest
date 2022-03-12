/// checkin : "2021-12-17T12:37:30.873Z"
/// location : "Billings"
/// purpose : "invoice transaction at Strosin and Sons using card ending with ***8731 for UYU 610.28 in account ***20333241"
/// id : "24"
/// employeeId : "24"

class CheckInModel {
  CheckInModel({
      String? checkin, 
      String? location, 
      String? purpose, 
      String? id, 
      String? employeeId,}){
    _checkin = checkin;
    _location = location;
    _purpose = purpose;
    _id = id;
    _employeeId = employeeId;
}

  CheckInModel.fromJson(dynamic json) {
    _checkin = json['checkin'];
    _location = json['location'];
    _purpose = json['purpose'];
    _id = json['id'];
    _employeeId = json['employeeId'];
  }
  String? _checkin;
  String? _location;
  String? _purpose;
  String? _id;
  String? _employeeId;

  String? get checkin => _checkin;
  String? get location => _location;
  String? get purpose => _purpose;
  String? get id => _id;
  String? get employeeId => _employeeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['checkin'] = _checkin;
    map['location'] = _location;
    map['purpose'] = _purpose;
    map['id'] = _id;
    map['employeeId'] = _employeeId;
    return map;
  }

  //create a list of CheckIn model
  static List<CheckInModel> listFromJson(List<dynamic> json){
    return json == null
        ? []
        : json.map((value) => CheckInModel.fromJson(value)).toList();
  }


}