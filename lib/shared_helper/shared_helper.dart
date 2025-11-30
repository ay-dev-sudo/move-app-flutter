import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }
  static Future<void> saveMovie(Map<String, dynamic> movie) async {
    final prefs = await SharedPreferences.getInstance();
    final token = await getToken();
    if (token.isEmpty) return;

    List<String> saved = prefs.getStringList("saved_movies_$token") ?? [];
    String movieJson = jsonEncode(movie);

    saved.removeWhere((movie) => movie == movieJson); //احذفه و ارجع خذنه في 0
    saved.insert(0, movieJson);

    await prefs.setStringList("saved_movies_$token", saved);
  }
  static Future<List<Map<String, dynamic>>> getSavedMovies() async { //{"movie_id : 11, "title" : "sasa"} و هكذا

    final prefs = await SharedPreferences.getInstance();
    final token = await getToken();
    if (token.isEmpty) return [];
    List<String> savedMovies = prefs.getStringList("saved_movies_$token") ?? [];

    return savedMovies
        .map((movie) => jsonDecode(movie) as Map<String, dynamic>)
        .toList();
  }


}
