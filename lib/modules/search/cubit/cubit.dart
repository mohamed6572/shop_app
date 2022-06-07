import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/constens.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points.dart';

class searchCubit extends Cubit<searchStates> {
  searchCubit() : super(searchInitialState());

  static searchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void Search({
  required String text
}){
    emit(searchLodingState());

    Dio_Helper.postData(url: SEARCH,
        token: token,
        data: {
      'text':text
    }).then((value) {
      searchModel= SearchModel.fromJson(value.data);
      emit(searchSucssesState());
    }).catchError((error){
      emit(searchErrorState());
    });
  }


}
