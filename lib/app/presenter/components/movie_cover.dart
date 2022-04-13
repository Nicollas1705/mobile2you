import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile2you/app/data/endpoints/themoviedb_endpoint.dart';
import 'package:mobile2you/app/domain/entities/movie_entity.dart';
import 'package:mobile2you/app/presenter/controllers/movie_cover_controller.dart';
import 'package:mobile2you/shared/utils/like_count.dart';

class MovieCover extends StatelessWidget {
  MovieCover({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final MovieEntity movie;

  final controller = MovieCoverController();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * .8,
      stretch: true,
      backgroundColor: Colors.black,
      shadowColor: Colors.amber,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(66),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors([0, .3, .6, .9, 1, 1]),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: GestureDetector(
                        child: Stack(
                          children: [
                            Observer(
                              builder: (_) {
                                return AnimatedScale(
                                  scale: controller.liked ? 0 : 1,
                                  duration: const Duration(milliseconds: 300),
                                  child: const Icon(Icons.favorite, size: 30),
                                );
                              },
                            ),
                            const Icon(Icons.favorite_outline, size: 30),
                          ],
                        ),
                        onTap: controller.likeChanger,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Icon(Icons.favorite, size: 18),
                      const SizedBox(width: 8),
                      Text(LikeCount.getText(movie.likes)),
                      const SizedBox(width: 32),
                      popularityIcon(),
                      const SizedBox(width: 8),
                      Text(
                        "${movie.popularity.toString().replaceFirst(".", ",")} of Popularity",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: gradientColors([.5, .3, .1, .05, 0, .05, .3, .6, 1, 1]),
            ),
          ),
          child: Image.network(
            TheMovieDbEndpoint.urlImage + movie.cover,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ? This icon can be filled according to the gradientFill() method
  Widget popularityIcon() {
    const double size = 18;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.white,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientFill(.3),
        ),
      ),
    );
  }

  List<Color> gradientColors(List<double> opacities) {
    List<Color> result = [];
    for (var element in opacities) {
      result.add(Colors.black.withOpacity(element));
    }
    return result;
  }

  // ? Filled space inside the popularityIcon
  List<Color> gradientFill(double filledRatio) {
    const Color color = Colors.white;
    const int total = 10;
    int filled = (total * filledRatio).toInt();
    List<Color> result = [];
    for (var i = 0; i < total; i++) {
      if (i < filled) {
        result.add(color.withOpacity(1));
      } else {
        result.add(color.withOpacity(0));
      }
    }
    return result.reversed.toList();
  }
}
