class ChangeCarts_Model
{
  bool? status;
  String? message;
  ChangeCarts_Model.fromJson(Map<String , dynamic> json){
    status = json['status'];
    message = json['message'];
  }

}