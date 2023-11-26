import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';

import '../database/database.dart';
import '../model/movie_model.dart';
import '../network/check_internet.dart';
import '../network/get_movies_service.dart';
import '../utilies/app_strings.dart';

class GetMoviesBloc extends Bloc<GetMoviesEvent, GetMoviesState> {
  final mGetMoviesService = GetMoviesService();
  SQLHelper helper = new SQLHelper();
  List<Movie>? MovieList;
  bool firstTime = true;

  GetMoviesBloc() : super(LoadingGetMoviesState());

  @override
  Stream<GetMoviesState> mapEventToState(GetMoviesEvent event) async* {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (event is LoadGetMoviesEvent) {
      yield LoadingGetMoviesState();
      try {
        var mGetMovies;
        bool checkInternet = await CheckInternet().isConected();
        firstTime = (await preferences.getBool(AppStrings.firstTime)) ?? true;

        if (checkInternet) {
          mGetMovies = await (mGetMoviesService.getMovies());
          if (firstTime) {
            preferences.setBool(AppStrings.firstTime, false);
            (mGetMovies).forEach((movie) {
              saveOfflineData(movie);
            });
          }
          yield LoadedGetMoviesState(mGetMovies: mGetMovies);
        } else if (!firstTime && !checkInternet) {
          mGetMovies = await updateListMoviea();
          yield LoadedGetMoviesState(mGetMovies: mGetMovies);
        } else {
          yield NoInterntConnectionState();
        }
      } catch (e) {
        yield FailedGetMoviesState(error: e.toString());
      }
    }
  }

  Future<List<Movie>> updateListMoviea() async {
    final Future<Database> db = helper.inialization();
    List<Movie> results = await helper.getMoviesList();
    MovieList = results;
    return MovieList!;
  }

  Future<void> saveOfflineData(Movie mMovie) async {
    Movie result = Movie();
    int res;
    result.title = mMovie.title;
    result.voteAverage = mMovie.voteAverage;
    result.releaseDate = mMovie.releaseDate;
    result.id = int.parse(mMovie.id.toString());
    result.overview = mMovie.overview;
    result.posterPath = mMovie.posterPath;
    var lens = await helper.searchcont(mMovie.title.toString());
    if (lens < 1) {
      res = await helper.insertMovie(result);
      if (res == 0) {
        print("movie not save");
      }
    }
  }
}

abstract class GetMoviesEvent {}

class LoadGetMoviesEvent extends GetMoviesEvent {
  final String? typeFilm;

  LoadGetMoviesEvent({required this.typeFilm});
}

abstract class GetMoviesState {}

class LoadingGetMoviesState extends GetMoviesState {}

class LoadedGetMoviesState extends GetMoviesState {
  List<Movie> mGetMovies;

  LoadedGetMoviesState({required this.mGetMovies});
}

class NoInterntConnectionState extends GetMoviesState {
  NoInterntConnectionState();
}

class FailedGetMoviesState extends GetMoviesState {
  String? error;

  FailedGetMoviesState({this.error});
}
