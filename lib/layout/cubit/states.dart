import 'package:shop_app/models/ChangeFavourites_Model.dart';
import 'package:shop_app/models/loginModel.dart';

abstract class AppStates{}

class AppInitialState extends AppStates{}
class ChangeBottomNavState extends AppStates{}

class AppLodingDataState extends AppStates{}

class AppGetDataSuccsesState extends AppStates{}
class AppGetDataErrorState extends AppStates{
  final String Error;
  AppGetDataErrorState(this.Error);
}

class AppGetCategoriesSuccsesState extends AppStates{}
class AppGetCategoriesErrorState extends AppStates{
  final String Error;
  AppGetCategoriesErrorState(this.Error);
}
class AppChangeFavouritesState extends AppStates{}

class AppChangeFavouritesSuccsesState extends AppStates{
final ChangeFavorites_Model? model;

  AppChangeFavouritesSuccsesState(this.model);
}
class AppChangeFavouritesErrorState extends AppStates{
  final String Error;
  AppChangeFavouritesErrorState(this.Error);
}


class AppLodingGetFavoritesState extends AppStates{}

class AppGetFavoritesSuccsesState extends AppStates{}
class AppGetFavoritesErrorState extends AppStates{
  final String Error;
  AppGetFavoritesErrorState(this.Error);
}

class AppLodingGetProfileState extends AppStates{}

class AppGetProfileSuccsesState extends AppStates{
 final Login_Model? login_model;

  AppGetProfileSuccsesState(this.login_model);
}
class AppGetProfileErrorState extends AppStates{
  final String Error;
  AppGetProfileErrorState(this.Error);
}


class AppLodingUpdateProfileState extends AppStates{}

class AppUpdateProfileSuccsesState extends AppStates{
  final Login_Model? login_model;

  AppUpdateProfileSuccsesState(this.login_model);
}
class AppUpdateProfileErrorState extends AppStates{
  final String Error;
  AppUpdateProfileErrorState(this.Error);
}