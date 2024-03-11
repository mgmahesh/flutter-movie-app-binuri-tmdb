import 'package:flutter/material.dart';
import 'package:movie_app_example/constants/colors.dart';

Future<dynamic> MyProfile(BuildContext context) {
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
