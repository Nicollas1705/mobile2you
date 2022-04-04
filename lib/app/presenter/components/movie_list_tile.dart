import 'package:flutter/material.dart';
import 'package:mobile2you/app/domain/entities/movie_entity.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            cover(),
            const SizedBox(width: 16),
            content(),
            movie.check
                ? const Align(
                    alignment: Alignment.topCenter,
                    child: Icon(Icons.check_circle, size: 16),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget cover() {
    return SizedBox(
      height: 100,
      width: 60,
      child: Container(
        color: Colors.amber, // TODO
      ),
    );
  }

  Widget content() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          subContent(),
        ],
      ),
    );
  }

  Widget subContent() {
    String genres = movie.genres.toString();
    genres = genres.replaceAll("[", "").replaceAll("]", "");
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Text(movie.year.toString()),
          const SizedBox(width: 8),
          Text(genres.toString()),
        ],
      ),
    );
  }
}
