class Register_Model{
  bool status = true;
  String? message;
  userData? data;
  Register_Model.fromJson(Map<String,dynamic> json){
    status =json['status'];
    message =json['message'];
    data =userData.fromjson(json['data']);
  }
}



class userData {
  int? id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;

  userData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}
