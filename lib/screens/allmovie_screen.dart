import 'package:cinemaze/models/discover_model.dart';
import 'package:cinemaze/service/http_service.dart';
import 'package:cinemaze/variables/variables.dart';
import 'package:cinemaze/widgets/appbar_widget.dart';
import 'package:cinemaze/widgets/load_more_movie.dart';
import 'package:cinemaze/widgets/now_playing.dart';
import 'package:flutter/material.dart';
import 'package:shape_of_view/shape_of_view.dart';

import 'package:cinemaze/variables/variables.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AllMovieScreen extends StatefulWidget {
  final bool isMovie;

  const AllMovieScreen({Key key, this.isMovie}) : super(key: key);

  @override
  _AllMovieScreenState createState() => _AllMovieScreenState();
}

class _AllMovieScreenState extends State<AllMovieScreen> {
  ScrollController _scrollController = new ScrollController();
  int page = 1;
  bool loadMore = false;

  int get count => listMovies.length;
  List<DiscoverModel> listMovies = [];
  HttpService httpService = new HttpService();

  @override
  void initState() {
    super.initState();
    fetchMovies();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          page < 10) {
        page++;
        fetchMovies();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchMovies() async {
    setState(() {
      loadMore = true;
    });
    List<DiscoverModel> discoverModel =
        await httpService.fetchPopularMovie(page: page.toString());
    setState(() {
      listMovies.addAll(discoverModel);
      loadMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String _imageName = "images/cinema.jpg";
    String _title =
        widget.isMovie ? "Browse All Movies" : "Browse All TV Series";
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            elevation: 0,
            collapsedHeight: MediaQuery.of(context).size.height * 0.25,
            backgroundColor: Colors.white.withOpacity(0),
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Stack(children: [
                Image.asset(_imageName,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    width: double.infinity),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                        Colors.black,
                        Colors.black.withAlpha(200),
                      ])),
                  child: SafeArea(
                    child: Container(
                        child: Center(
                      child: Text(
                        _title,
                        style: headingSliver,
                      ),
                    )),
                  ),
                ),
              ]),
            ),
            // leading: SizedBox(),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 2 / 3,
            ),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlutterItem(data: listMovies[index], loadMore: loadMore,),
              );
            }, childCount: listMovies.length),
          ),
          if (loadMore)
            SliverToBoxAdapter(
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()))),
        ],
      ),
    );
  }
}

class FlutterItem extends StatelessWidget {
  final DiscoverModel data;
  final bool loadMore;

  FlutterItem({this.data, this.loadMore});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage.assetNetwork(
          placeholder: "assets/loading.gif",
          image: data.poster(),
        )
    );
  }
}
