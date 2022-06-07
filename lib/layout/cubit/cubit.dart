import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/ChangeCarts_Model.dart';
import 'package:shop_app/models/ChangeFavourites_Model.dart';
import 'package:shop_app/models/carts_model.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/loginModel.dart';
import 'package:shop_app/modules/cateogries/cateogries_screan.dart';
import 'package:shop_app/modules/favorites/favorites_screan.dart';
import 'package:shop_app/modules/products/products_screan.dart';
import 'package:shop_app/modules/settings/settings_screan.dart';
import 'package:shop_app/shared/components/constens.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  Home_model? home_model;
  int currentIndex = 0;

  List<Widget> Screans = [
    Products_Screan(),
    Cateogries_Screan(),
    Favorites_Screan(),
    Settings_Screan(),
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  Map<int, bool> favorits = {};
  Map<int, bool> carts = {};

  void getHomeData() {
    emit(AppLodingDataState());
    Dio_Helper.getData(url: Home,token: token).then((value) {

      home_model = Home_model.fromJson(value.data);

      home_model?.data?.products.forEach((e) {
        favorits.addAll({e.id ?? 0: e.in_favorites});
      });
      home_model?.data?.products.forEach((e) {
        carts.addAll({e.id ?? 0: e.inCart});
      });
      print(favorits.toString());

      emit(AppGetDataSuccsesState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetDataErrorState(error.toString()));
    });
  }

  Categories_Model? categories_model;

  void getCategoriesData() {
    Dio_Helper.getData(url: Categories).then((value) {
      categories_model = Categories_Model.fromJson(value.data);
      emit(AppGetCategoriesSuccsesState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetCategoriesErrorState(error.toString()));
    });
  }

  ChangeFavorites_Model? changeFavorites_Model;

  void ChangeFavourites(int productId) {
    favorits[productId] = !favorits[productId]!;
    emit(AppChangeFavouritesState());

    Dio_Helper.postData(
            url: FAVORITES, data: {'product_id': productId},
        token: token
    )
        .then((value) {
      changeFavorites_Model =ChangeFavorites_Model.fromJson(value.data);
      print(value.data);
      if(changeFavorites_Model?.status==false){
        favorits[productId] = !favorits[productId]!;

      }else{
        GetFavorites();
      }
          emit(AppChangeFavouritesSuccsesState(changeFavorites_Model));
    })
        .catchError((error) {
      favorits[productId] = !favorits[productId]!;

      emit(AppChangeFavouritesErrorState(error.toString()));
    });
  }


  ChangeCarts_Model? changeCarts_Model;

  void ChangeCarts(int productId) {
    carts[productId] = !carts[productId]!;
    emit(AppChangeCartsState());
    Dio_Helper.postData(
            url: CARTS, data: {'product_id': productId},
        token: token
    )
        .then((value) {
      changeCarts_Model =ChangeCarts_Model.fromJson(value.data);
      print(value.data);
      if(changeCarts_Model?.status==false){
        carts[productId] = !carts[productId]!;

      }else{
        GetCarts();
      }
          emit(AppChangeCartsSuccsesState(changeCarts_Model));
    })
        .catchError((error) {
      carts[productId] = !carts[productId]!;

      emit(AppChangeCartsErrorState(error.toString()));
    });
  }
  FavoritesModel?  favoritesModel;

  void GetFavorites(){
    emit(AppLodingGetFavoritesState());
    Dio_Helper.getData(url: FAVORITES,token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel?.data.toString());
      emit(AppGetFavoritesSuccsesState());
    }).catchError((error){
      emit(AppGetFavoritesErrorState(error));
    });


  }



  CartsModel?  cartsModel;

  void GetCarts(){
    emit(AppLodingGetCartsState());
    Dio_Helper.getData(url: CARTS,token: token).then((value) {
      cartsModel = CartsModel.fromJson(value.data);
      print(cartsModel?.data?.cart_items[0].id);
      emit(AppGetCartsSuccsesState());
    }).catchError((error){
      emit(AppGetCartsErrorState(error));
    });


  }

  Login_Model? usermodel;
  
  void getProfile(){
    emit(AppLodingGetProfileState());
    Dio_Helper.getData(url: PROFILE,token: token).then((value) {
      usermodel =Login_Model.fromJson(value.data);
      emit(AppGetProfileSuccsesState(usermodel));
    }).catchError((error){
      emit(AppGetProfileErrorState(error));
    });
  }

  void UpdateProfile({
  required String name,
  required String email,
  required String phone,
  String? image
}){
    emit(AppLodingUpdateProfileState());
    Dio_Helper.putData(url: Update_PROFILE,token: token,
    data: {
      'name': name, 'email': email, 'phone': phone,'image' : image
    }
    ).then((value) {
      usermodel =Login_Model.fromJson(value.data);
      emit(AppUpdateProfileSuccsesState(usermodel));
    }).catchError((error){
      emit(AppUpdateProfileErrorState(error));
    });
  }

}
