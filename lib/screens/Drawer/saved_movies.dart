import 'package:flutter/material.dart';
import 'package:movie_app_example/constants/colors.dart';

import '../../db/database_helper.dart';

Future<dynamic> SavedMovies(BuildContext context) {
  final double statusBarHeight = MediaQuery.of(context).padding.top;
  final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

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
                      FutureBuilder<List<dynamic>>(
                        future: DatabaseHelper().getMovies(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  var movie = snapshot.data?[index];
                                  return InkWell(
                                    onTap: () {
                                      print(movie);
                                    },
                                    child: ListTile(
                                      title: Text(movie.title),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
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
