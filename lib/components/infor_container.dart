import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_example/models/movie.dart';

import '../db/database_helper.dart';

class InforContainer extends StatelessWidget {
  const InforContainer({
    super.key,
    required this.movie,
  });

  final Movie movie;

  void _saveMovieToDatabase(Movie movie) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    int id = await dbHelper.insertMovie(movie);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    children: [
                      Text('Release date: ',
                          style: GoogleFonts.aBeeZee(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text(movie.realseDate,
                          style: GoogleFonts.aBeeZee(
                              fontSize: 14, fontWeight: FontWeight.w400))
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      children: [
                        Text('Rating: ',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text('${movie.voteAverage.toStringAsFixed(1)}/10',
                            style: GoogleFonts.aBeeZee(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey)),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _saveMovieToDatabase(movie);
                    },
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite),
                          color: Colors.red,
                          onPressed: () {
                            _saveMovieToDatabase(movie);
                          },
                        ),
                        const Text(
                          'Add to Favorites',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
