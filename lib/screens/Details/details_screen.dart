import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app_example/client/api_video.dart';
import 'package:movie_app_example/components/infor_container.dart';
import 'package:movie_app_example/constants/colors.dart';
import 'package:movie_app_example/constants/constants.dart';
import 'package:movie_app_example/models/movie.dart';
import 'package:movie_app_example/models/video_movie.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key, required this.movie});

  final Movie movie;

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  late Future<VideoMovie> video;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    video = ApiVideo().getVideo(widget.movie);
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.only(
                top: 16,
                left: 16,
              ),
              decoration: BoxDecoration(
                color: Colours.scaffoldBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Center(child: Icon(Icons.arrow_back)),
              ),
            ),
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.movie.title,
                style: GoogleFonts.aBeeZee(
                    fontSize: 18, fontWeight: FontWeight.w900),
              ),
              background: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "${Constants.imagePath}${widget.movie.posterPath}",
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '${widget.movie.overview}',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 20, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InforContainer(movie: widget.movie),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Trailer',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FutureBuilder(
                      future: video,
                      builder: (context, AsyncSnapshot<VideoMovie> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child:
                                  CircularProgressIndicator()); // Placeholder for loading state
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final videoMovie = snapshot.data!;
                          _controller = YoutubePlayerController(
                            initialVideoId: videoMovie
                                .key, // Accessing videoId from VideoMovie
                            flags: const YoutubePlayerFlags(
                              autoPlay: true,
                              mute: false,
                            ),
                          );
                          return YoutubePlayer(controller: _controller);
                        } else {
                          return const Text(
                              'No data available'); // Placeholder for empty state
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Watch now',
                        style: GoogleFonts.aBeeZee(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Comments',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
