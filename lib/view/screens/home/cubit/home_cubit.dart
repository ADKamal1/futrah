import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futrah/controller/constants/logger.dart';
import 'package:futrah/controller/constants/strings.dart';
import 'package:futrah/controller/services/helpers/di.dart';
import 'package:futrah/controller/services/local/cache_helper.dart';
import 'package:futrah/controller/services/remote/dio_helper.dart';
import 'package:futrah/controller/services/remote/end_points.dart';
import 'package:futrah/view/screens/home/cubit/home_states.dart';
import 'package:futrah/view/screens/home/model/categories_model.dart';
import 'package:futrah/view/screens/home/model/get_all_product_model.dart';
import 'package:futrah/view/screens/home/model/get_product_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  final CacheHelper prefs = instance<CacheHelper>();

  /// ================== get total price in cart======================

  void clearCart() {
    productList.clear();
    priceList.clear();
    idList.clear();
    emit(ClearCartHomeState());
  }

  Map<String, dynamic> idList = {};
  List<int> productList = <int>[];
  List<num> priceList = <num>[];
  void updateList() => emit(UpdateListHomeState());

  num get total {
    num total = 0;
    for (var i = 0; i < priceList.length; i++) {
      total += priceList[i];
    }
    return total;
  }

  /// ================== Get Category for tapBar ======================

  CategoriesModel? categoriesModel;
  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.get(key: 'token')}'
    };
    var data = FormData.fromMap({
      'password': '12345689',
      'email': 'user@user.com'
    });

    var dio = Dio();
   await dio.request(
      'https://futrah.com/public/api/category/all',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
      data: data,
    ).then((value) {
       categoriesModel = CategoriesModel.fromJson(value.data);
      emit(GetCategoriesSuccessState());

       categoriesModel!.data!.isNotEmpty
          ? getProduct(index: 0)
          : emit(GetProductSuccessState());

      if(value.statusCode !=200)
        {
          emit(GetCategoriesErrorState());
          print("error");
        }

    });
  }

  /// ================== Get Products Lists ======================
  GetProductModel? getProductModel;
  Future<void> getProduct({int? index}) async {
    int categoryId = categoriesModel!.data![index!].id ?? 0;
    emit(GetProductLoadingState());
    await DioHelper.getData(
      url: '${EndPoints.getProductsStore}/${categoryId}',
    ).then((value) {
      getProductModel = GetProductModel.fromJson(value.data);
      emit(GetProductSuccessState());
    }).catchError((error) {
      PrintLog.d(error.toString());
      emit(GetProductErrorState(error.toString()));
    });
  }

  /// ================== Get All Products Lists ======================
  GetAllProductModel? getAllProductModel;



  Future<void> getAllProduct() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.get(key: 'token')}'

    };
    emit(GetAllProductLoadingState());

    //await DioHelper.getData(url: EndPoints.getProductsStore)
    var dio = Dio();
      await dio.request(
      'https://futrah.com/public/api/products',
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    )
        .then((value) {

        if (value.statusCode == 200) {

          getAllProductModel = GetAllProductModel.fromJson(value.data);
          print(value.statusCode.toString());  }
        else {

        }

      emit(GetAllProductSuccessState());
    });
  }




}


