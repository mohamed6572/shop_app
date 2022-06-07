class CartsModel {
  bool? status;

  Data? data;

  CartsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


}

class Data {
  List<DataModel> cart_items =[];

  Data.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((element) {
      cart_items.add(DataModel.fromJson(element));
    });

  }

}

class DataModel{
  int? id;
  int? quantity;

  Product? product;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = Product.fromJson(json['product']) ;
  }

}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
