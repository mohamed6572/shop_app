class Categories_Model{
bool? status;
cateogriesDataModel? data;
Categories_Model.fromJson(Map<String , dynamic> json){
  status = json['status'];
  data = cateogriesDataModel.fromJson(json['data']);
}
}
class cateogriesDataModel{
  int? current_page;
List<DataModel> data=[];
  cateogriesDataModel.fromJson(Map<String , dynamic> json){
    current_page = json['current_page'];
    json['data'].forEach((e){
      data.add(DataModel.fromJson(e));
    });

  }
}
class DataModel{
  int? id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}