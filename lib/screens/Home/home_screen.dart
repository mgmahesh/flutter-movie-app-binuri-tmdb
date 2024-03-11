import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_example/client/api.dart';
import 'package:movie_app_example/components/text.dart';
import 'package:movie_app_example/components/top_list.dart';
import 'package:movie_app_example/components/trending_slider.dart';
import 'package:movie_app_example/constants/colors.dart';
import 'package:movie_app_example/constants/size.dart';
import 'package:movie_app_example/models/movie.dart';
import 'package:provider/provider.dart';
import '../../components/drawer.dart';
import '../Drawer/singin_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingList;
  late Future<List<Movie>> topList;
  late Future<List<Movie>> upcomingList;
  late Future<List<Movie>> searchList;

  @override
  void initState() {
    trendingList = ApiService().getTrendingMovie();
    topList = ApiService().getTopMovie();
    upcomingList = ApiService().getUpcomingMovie();
    searchList = ApiService().getSearchMovie('the boss');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    String getFirstName() {
      String? fullName = user?.displayName;
      if (fullName != null) {
        List<String> nameParts = fullName.split(' ');
        return nameParts.isNotEmpty ? nameParts.first : '';
      }
      return '';
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              BottomSearch(context);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              SingIn(context);
            },
            icon: const Icon(Icons.supervised_user_circle),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(getFirstName()),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/flutflix.png',
          fit: BoxFit.cover,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textTitleInHome('Trending Movies', 24),
              SizedBox(
                child: FutureBuilder(
                  future: trendingList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return TrendingSlider(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const sizeHeight(),
              textTitleInHome('Top rated movies', 25),
              const sizeHeight(),
              SizedBox(
                child: FutureBuilder(
                  future: topList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return TopListMovies(
                        snapshot: snapshot,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              const sizeHeight(),
              textTitleInHome('Upcoming movies', 25),
              const sizeHeight(),
              SizedBox(
                child: FutureBuilder(
                  future: upcomingList,
                  builder: (context, snapshop) {
                    if (snapshop.hasError) {
                      return Center(
                        child: Text(snapshop.error.toString()),
                      );
                    } else if (snapshop.hasData) {
                      return TopListMovies(snapshot: snapshop);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> BottomSearch(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;
    bool isSearch = false;
    TextEditingController searchController = TextEditingController();

    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      elevation: 0,
      backgroundColor: Colours.scaffoldBgColor,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: navigationBarHeight,
                left: 12.0,
                right: 12.0,
                top: statusBarHeight + 12.0,
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.cancel_outlined),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 15,
                            ),
                            hintText: "Search",
                            suffixIcon: IconButton(
                              onPressed: () async {
                                setState(() {
                                  isSearch = true;
                                  var query = searchController.text;
                                  print(query);
                                });
                              },
                              icon: const Icon(Icons.search),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (isSearch) ...[
                          Container(
                            child: FutureBuilder(
                              future: searchList,
                              builder: (context, snapshot) {
                                print(snapshot.data);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  print(snapshot.error.toString());
                                  return Center(
                                    child: Text(
                                        'error fetch ${snapshot.error?.toString()}'),
                                  );
                                } else if (snapshot.hasData) {
                                  print('have data');
                                  print(snapshot.data);
                                  return TopListMovies(snapshot: snapshot);
                                } else {
                                  return const Center(
                                    child: Text('No data available'),
                                  );
                                }
                              },
                            ),
                          )
                        ],
                        // Hiển thị nội dung mặc định khi không tìm kiếm hoặc khi isSearch = false
                        if (!isSearch) ...[
                          Container(
                            margin: EdgeInsets.only(top: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textTitleInHome('Trending Nearly', 22),
                                const SizedBox(height: 16),
                                FutureBuilder(
                                  future: trendingList,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                        child: Text(snapshot.error.toString()),
                                      );
                                    } else if (snapshot.hasData) {
                                      return TopListMovies(snapshot: snapshot);
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
