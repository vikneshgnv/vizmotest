//Employee details Model class
class EmployeeModel {
  EmployeeModel({
      String? createdAt, 
      String? name, 
      String? avatar, 
      String? email, 
      String? phone, 
      List<String>? department, 
      String? birthday, 
      String? country, 
      String? id,}){
    _createdAt = createdAt;
    _name = name;
    _avatar = avatar;
    _email = email;
    _phone = phone;
    _department = department;
    _birthday = birthday;
    _country = country;
    _id = id;
}

  EmployeeModel.fromJson(dynamic json) {
    _createdAt = json['createdAt'];
    _name = json['name'];
    _avatar = json['avatar'];
    _email = json['email'];
    _phone = json['phone'];
    _department = json['department'] != null ? json['department'].cast<String>() : [];
    _birthday = json['birthday'];
    _country = json['country'];
    _id = json['id'];
  }
  String? _createdAt;
  String? _name;
  String? _avatar;
  String? _email;
  String? _phone;
  List<String>? _department;
  String? _birthday;
  String? _country;
  String? _id;

  String? get createdAt => _createdAt;
  String? get name => _name;
  String? get avatar => _avatar;
  String? get email => _email;
  String? get phone => _phone;
  List<String>? get department => _department;
  String? get birthday => _birthday;
  String? get country => _country;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = _createdAt;
    map['name'] = _name;
    map['avatar'] = _avatar;
    map['email'] = _email;
    map['phone'] = _phone;
    map['department'] = _department;
    map['birthday'] = _birthday;
    map['country'] = _country;
    map['id'] = _id;
    return map;
  }

  //create a list of employee model
  static List<EmployeeModel> listFromJson(List<dynamic> json){
    return json == null
        ? []
        : json.map((value) => EmployeeModel.fromJson(value)).toList();
  }

}