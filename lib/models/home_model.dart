class Home_model {
  bool? status;
  HomeDataModel? data;

  Home_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<bannerModel> banners = [];
  List<productModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(bannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(productModel.fromJson(element));
    });
  }
}

class bannerModel {
  int? id;
  String? image;

  bannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class productModel {

List<String> images=[];
int? id;
late dynamic  price;
late dynamic  oldPrice;
late dynamic  discount;
late String  image;
late String  name;
late String  description;
late bool  in_favorites;
late bool  inCart;
  productModel.fromJson(Map<String , dynamic> json){
    json['images'].forEach((element) {
      images.add(element);
    });
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    in_favorites = json['in_favorites'];
    inCart = json['in_cart'];

  }
}
//
// class imagesModel{
//   String? images;
//   imagesModel.fromJson(List<String>  json){
//     images = json['images'];
//   }
// }