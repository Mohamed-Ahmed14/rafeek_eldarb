import 'package:dio/dio.dart';

import 'end_points.dart';

class DioHelper{

  static Dio? _dio;

  static void init()
  {
    _dio=Dio(
        BaseOptions(
            baseUrl: EndPoints.baseUrl,
            receiveDataWhenStatusError: true,
            // headers: {
            //   "Accept":"application/json",
            //   "Content-Type":"application/json"
            // }
        )
    );
  }

  static Future<Response> get(
      {required String endPoint,
        Map<String,dynamic>? queryParameters,
        Map<String,dynamic>? headers,
        Map<String,dynamic>? body,
        bool? withToken=false,
      })async{
    try{

      _dio!.options.headers=headers;
      // if(withToken!)
      // {
      //   _dio?.options.headers={
      //     "Authorization": "Bearer ${ await SecureStorage.raedSecure(key: SharedKeys.token)}",
      //   };
      // }

      return _dio!.get(endPoint,
        queryParameters: queryParameters,
        data: body,
      );

    }catch(e){
      rethrow;
    }

  }

  static Future<Response> post ({required String endPoint,Map<String,
      dynamic>? queryParameters,Map<String,
      dynamic>? body,Map<String,dynamic>? headers,
    FormData? formData,
    bool? withToken=false,
  })async{

    try{
      _dio!.options.headers = headers;
      // if(withToken!)
      // {
      //   _dio?.options.headers={
      //     "Authorization": "Bearer ${ await SecureStorage.raedSecure(key: SharedKeys.token)}",
      //   };
      // }
      return _dio!.post(endPoint,
        queryParameters: queryParameters,
        data: formData?? body,
      );
    }catch(e){
      rethrow;
    }

  }

  static Future<Response> put (
      {required String endPoint,
        Map<String,dynamic>? queryParameters,
        Map<String,dynamic>? body,
        Map<String,dynamic>? headers}){

    try{
      _dio!.options.headers = headers;
      return _dio!.put(endPoint,
        queryParameters: queryParameters,
        data: body,
      );
    }catch(e){
      rethrow;
    }

  }

  static Future<Response> patch (
      {required String endPoint,Map<String,
          dynamic>? queryParameters,Map<String,dynamic>? body,
        Map<String,dynamic>? headers}){

    try{
      _dio!.options.headers = headers;
      return _dio!.patch(endPoint,
        queryParameters: queryParameters,
        data: body,
      );
    }catch(e){
      rethrow;
    }

  }

  static Future<Response> delete ({required String endPoint,
    Map<String,dynamic>? queryParameters,
    Map<String,dynamic>? body,
    Map<String,dynamic>? headers,
    bool? withToken=false,

  })async{

    try{
      _dio!.options.headers = headers;
      // if(withToken!)
      // {
      //   _dio?.options.headers={
      //     "Authorization": "Bearer ${ await SecureStorage.raedSecure(key: SharedKeys.token)}",
      //   };
      // }
      return _dio!.delete(endPoint,
        queryParameters: queryParameters,
        data: body,
      );
    }catch(e){
      rethrow;
    }

  }

}