import 'package:cinemaze/models/discover_model.dart';
import 'package:cinemaze/providers/user_provider.dart';
import 'package:cinemaze/screens/movie_detail.dart';
import 'package:cinemaze/services/http_service.dart';
import 'package:cinemaze/variables/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shape_of_view/shape_of_view.dart';

class UserInfoScreen extends StatefulWidget {
  final bool isMovie;

  const UserInfoScreen({Key key, this.isMovie = true}) : super(key: key);

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
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
    String _imageName = "assets/images/bg.png";
    String _title = widget.isMovie ? "Your Favorite Movies" : "Your Favorite TV Series";
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
            backgroundColor: Colors.white.withAlpha(0).withOpacity(0),
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Stack(children: [
                ShapeOfView(
                    elevation: 0,
                    shape: ArcShape(
                        direction: ArcDirection.Outside,
                        height: 30,
                        position: ArcPosition.Bottom),
                    child: Image.asset(_imageName,
                        fit: BoxFit.cover,
                        height:  MediaQuery.of(context).size.height,
                        width:  MediaQuery.of(context).size.width,
                    )
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Consumer<UserProvider>(
                          builder: (BuildContext context, UserProvider userProvider, child){
                            return Container(
                                child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(userProvider.userData.photoURL),
                                    )
                                )
                            );
                          },
                        ),
                        Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Center(
                              child: Text(
                                _title,
                                style: headingSliver,
                              ),
                            )
                        ),
                      ]
                    ),
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
                child: ListItem(data: listMovies[index], loadMore: loadMore,),
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

class ListItem extends StatelessWidget {
  final DiscoverModel data;
  final bool loadMore;

  ListItem({this.data, this.loadMore});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context)=> MovieDetail(discoverModel: data,) ));
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage.assetNetwork(
            placeholder: "assets/loading.gif",
            image: data.poster(),
          )
      ),
    );
  }
}
