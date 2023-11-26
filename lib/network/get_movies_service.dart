import 'dart:convert';
import '../model/movie_model.dart';
import 'package:flutter/services.dart';

class GetMoviesService {
  final MethodChannel channel = const MethodChannel('openNetworkChannel');

  Future<List<Movie>?> getMovies() async {
    try {
      final String moviesList =
          await channel.invokeMethod('show', {'message': "OK"});

      var data = jsonDecode(moviesList) as Map<String, dynamic>;

      if (data != null) {
        final listMovies = GetMovies.fromJson(data);
        return listMovies.results;
      }
    } catch (e) {
    }
    return null;
  }
}
