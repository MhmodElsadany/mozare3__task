import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../component/trailers.dart';
import '../../database/database.dart';
import '../../model/movie_model.dart';
import '../../network/cashing.dart';
import '../../utilies/app_colors.dart';
import '../../utilies/common.dart';

class DetailMovie extends StatefulWidget {
  final Movie mMovie;

  DetailMovie(this.mMovie);

  @override
  State<StatefulWidget> createState() {
    return _DetailMovie(this.mMovie);
  }
}

class _DetailMovie extends State<DetailMovie> {
  final Movie mMovie;

  SQLHelper helper = new SQLHelper();
  Movie result = Movie();

  _DetailMovie(this.mMovie);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: false,
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    cacheManager: CustomCacheManager(),
                    imageUrl: "$detailUrl${widget.mMovie.posterPath}",
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        new Icon(Icons.network_check_outlined),
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20.h,
                  ),
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 4.0, //
                    direction: Axis.horizontal,

                    children: [
                      AutoSizeText(
                        widget.mMovie.title! +
                            "  (${widget.mMovie.voteAverage.toString()}/10)",
                        maxLines: 1,
                        minFontSize: 10,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 4.h,
                  ),
                  Text(
                    widget.mMovie.releaseDate.toString(),
                    style: TextStyle(
                        fontSize: 12.sp, color: AppColors.grey),
                    textAlign: TextAlign.end,
                  ),
                  Container(margin: EdgeInsets.only(top: 10.0, bottom: 8.0)),
                  Text(
                    "Storyline",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Container(margin: EdgeInsets.only(top: 6.0, bottom: 8.0)),
                  Text(widget.mMovie.overview!),
                  Container(margin: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                  Text(
                    "Trailers",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Container(margin: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                  listTailer(this.mMovie.id.toString(), mMovie.posterPath!),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  @override
  void initState() {}

  void showAlerDialog(String title, String mssg) {
    AlertDialog alertDialog = new AlertDialog(
      title: Text(title),
      content: Text(mssg),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
