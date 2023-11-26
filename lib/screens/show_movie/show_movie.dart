import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/get_movies_bloc.dart';
import '../../component/error_widget.dart';
import '../../component/progress_loading_simple.dart';
import '../../model/movie_model.dart';
import '../../network/cashing.dart';
import '../../utilies/app_strings.dart';
import '../../utilies/common.dart';
import '../detail_movie/detail_movie_screen.dart';

class ShowMovieScreen extends StatefulWidget {
  static String routeName = "showMovie";

  @override
  State<StatefulWidget> createState() {
    return _ShowMoviewState();
  }
}

class _ShowMoviewState extends State<ShowMovieScreen> {
  int _selectedIndex = 0;

  GetMoviesBloc mGetMovieBloc = new GetMoviesBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetMoviesBloc>(
        create: (context) =>
            mGetMovieBloc..add(LoadGetMoviesEvent(typeFilm: "discover")),
        child: BlocBuilder<GetMoviesBloc, GetMoviesState>(
            builder: (context, state) {
          if (state is LoadingGetMoviesState) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(AppStrings.ShowMovies),
                  centerTitle: true,
                ),
                body: Center(child: ProgressLoadingSimple()));
          } else if (state is LoadedGetMoviesState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.ShowMovies),
                centerTitle: true,
              ),
              body: state.mGetMovies.length == 0 || state.mGetMovies == null
                  ? TextCentWidgetComp(text: "No Data Available")
                  : buildGrid(state.mGetMovies),
            );
          } else if (state is FailedGetMoviesState) {
            return TextCentWidgetComp();
          } else if (state is NoInterntConnectionState) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(AppStrings.ShowMovies),
                  centerTitle: true,
                ),
                body: TextCentWidgetComp(
                  text: AppStrings.noInternet,
                ));
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text(AppStrings.ShowMovies),
                  centerTitle: true,
                ),
                body: TextCentWidgetComp());
          }
        }));
  }

  buildGrid(List<Movie> movie) {
    return GridView.builder(
      padding: EdgeInsets.all(0),
      itemCount: movie?.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: InkResponse(
            splashColor: Colors.red,
            enableFeedback: true,
            child: CachedNetworkImage(
              cacheManager: CustomCacheManager(),
              imageUrl: baseImgurl + '${movie?[index].posterPath}',
              fit: BoxFit.fill,
              errorWidget: (context, url, error) =>
                  new Icon(Icons.network_check_rounded),
            ),
            onTap: () {
              goToMoviesDetailPage(movie![index]);
            },
          ),
        );
      },
    );
  }

  goToMoviesDetailPage(Movie mMovie) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailMovie(mMovie);
    }));
  }

  void _onItemTapped(int index) {
    String type = "favorite";
    if (index == 0) {
      type = "discover";
      _selectedIndex = 0;
    } else {
      type = "favorite";
      _selectedIndex = 1;
    }
    mGetMovieBloc.add(LoadGetMoviesEvent(typeFilm: type));
  }
}
