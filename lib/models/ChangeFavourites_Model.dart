class ChangeFavorites_Model
{
  bool? status;
  String? message;
  ChangeFavorites_Model.fromJson(Map<String , dynamic> json){
    status = json['status'];
    message = json['message'];
  }

}