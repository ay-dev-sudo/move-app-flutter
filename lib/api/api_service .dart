import 'package:dio/dio.dart';
import 'package:move/api/end_points.dart';
import 'package:move/model/GetProfile.dart';
import 'package:move/model/MovieIsFavorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/AddMovieToFavorite.dart';
import '../model/GetAllFavoritesMovies.dart';
import '../model/LoginResponse.dart';
import '../model/MovieDetailsResponse.dart';
import '../model/MovieSuggestionsResponse.dart';
import '../model/MoviesResponse.dart';
import '../model/RegisterResponse.dart';
import 'api_constants.dart';
 class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );

  Future<RegisterResponse> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required int avatarId,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.registerApi,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": password,
          "phone": phone,
          "avaterId": avatarId,
        },
      );
      return RegisterResponse.fromJson(response.data);

    } on DioException catch (e) {
      final serverMessage = e.response?.data?['message'] ;
      throw Exception(serverMessage);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.loginApi,
        data: {
          "email": email,
          "password": password,
        },
      );

      return LoginResponse.fromJson(response.data); // ← الصحيsح
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception("Error: ${e.response?.data}");
      } else {
        throw Exception("Network Error");
      }
    }
  }

  Future<String> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    try {
      final response = await dio.patch(
        EndPoints.restPasswordApi,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),

      );
      return response.data['message'] ;
    }  on DioException catch (e) {
      if (e.response != null) {
        throw Exception("Error: ${e.response?.data}");
      } else {
        throw Exception("Network Error");
      }
    }
  }
  Future<GetProfile?> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";
      final response = await dio.get(
        EndPoints.getProfileApi,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return GetProfile.fromJson(response.data);
    } on DioException catch (e) {
      final serverMessage = e.response?.data['message'] ?? '';
      throw Exception(serverMessage);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateProfile({
    required String name,
    required String phone,
    required int avaterId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";
      final response = await dio.patch(
        EndPoints.updateProfileApi,
        data: {
          "name": name,
          "phone": phone,
          "avaterId": avaterId,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response.data["message"] ;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> delProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";

      final response = await dio.delete(
        EndPoints.deleteProfileApi,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return response.data['message'] ;
    }on DioException catch (e) {
      if (e.response != null) {
        throw Exception("Error: ${e.response?.data}");
      } else {
        rethrow;
      }
    }
  }

    Future<MoviesResponse> getMovieList({String? genre,String? sort_by,String? searchByName,int?  limit}) async {
      try {
        final response = await dio.get(EndPoints.getMovieListApi
        ,
            queryParameters: {
              "genre":genre,
              "sort_by":sort_by,
              "query_term":searchByName,
              "limit":limit
            }
        );

        return MoviesResponse.fromJson(response.data);

      }
      on DioException catch (e) {
        if (e.response != null) {
          throw Exception("Error: ${e.response?.data}");
        } else {
          rethrow;
        }
      }
    }
    Future<MovieDetailsResponse> getMovieDetails({int movie_id=1}) async {
      try {
        final response = await dio.get(EndPoints.getMovieDetailsApi
        ,
            queryParameters: {
              "movie_id":movie_id,
            }
        );
        print(response.data);

        return MovieDetailsResponse.fromJson(response.data);

      }
      on DioException catch (e) {
        if (e.response != null) {
          throw Exception("Error: ${e.response?.data}");
        } else {
          rethrow;
        }
      }
    }

    Future<MovieSuggestionsResponse> getMovieSuggestions({int movie_id=1}) async {
      try {
        final response = await dio.get(EndPoints.getMovieSuggestionsApi,
            queryParameters: {
              "movie_id":movie_id,
            }
        );
        return MovieSuggestionsResponse.fromJson(response.data);

      }
      on DioException catch (e) {
        if (e.response != null) {
          throw Exception("Error: ${e.response?.data}");
        } else {
          rethrow;
        }
      }
    }

  Future<AddMovieToFavorite> addMovieToFavorite({
    required int movieId,
    required String name,
    required double rating,
    required String imageURL,
    required int year,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";
      final response = await dio.post(
        EndPoints.addMovieToFavoriteApi,
        data: {
          "movieId": movieId,
          "name": name,
          "rating": rating,
          "imageURL": imageURL,
          "year": year,
        },
      options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return AddMovieToFavorite.fromJson(response.data);
    } on DioException catch (e) {
      final serverMessage = e.response?.data?['message'] ;
      throw Exception(serverMessage);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }

  }
  Future<MovieIsFavorite> movieIsFavorite({required int movieId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";
      final response = await dio.get(
        "${EndPoints.movieIsFavoriteApi}$movieId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return MovieIsFavorite.fromJson(response.data);

    } on DioException catch (e) {
      final serverMessage = e.response?.data?['message'];
      throw Exception(serverMessage);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
  Future<MovieIsFavorite> removeMovie({required int movieId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";
      final response = await dio.delete(
        "${EndPoints.removeMovieApi}$movieId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      return MovieIsFavorite.fromJson(response.data);
    } on DioException catch (e) {
      final serverMessage = e.response?.data?['message'];
      throw Exception(serverMessage);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
  Future<GetAllFavoritesMovies> getAllFavoritesMovies() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token") ?? "";

      final response = await dio.get(
        EndPoints.getAllFavoriteMoviesApi,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return GetAllFavoritesMovies.fromJson(response.data);

    } on DioException catch (e) {
      print("🔥 DIO ERROR: ${e.response?.data}");
      final serverMessage = e.response?.data?['message'];
      throw Exception(serverMessage);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
  }
