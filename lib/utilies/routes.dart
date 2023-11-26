import 'package:flutter/widgets.dart';

import '../screens/show_movie/show_movie.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  ShowMovieScreen.routeName: (context) => ShowMovieScreen(),
};
