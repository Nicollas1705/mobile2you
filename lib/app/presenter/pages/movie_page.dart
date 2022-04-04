import 'package:flutter/material.dart';
import 'package:mobile2you/app/domain/entities/movie_entity.dart';
import 'package:mobile2you/app/presenter/components/movie_cover.dart';
import 'package:mobile2you/app/presenter/components/movie_list_tile.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({
    Key? key,
    required this.movieId,
  }) : super(key: key);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          MovieCover(
            movie: MovieEntity( // TODO
              id: movieId,
              title: "The Very Best Of Johnny Depp",
              year: 0,
              genres: [],
              cover: "",
              check: false,
              popularity: 0.3,
              likes: 12344,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return MovieListTile(
                  movie: MovieEntity( // TODO
                    id: 0,
                    title: "Fight Club",
                    year: 2022,
                    genres: ["Horror", "Drama"],
                    cover: "",
                    check: true,
                    popularity: 0,
                    likes: 0,
                  ),
                );
              },
              childCount: 15,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 16))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(top: 10),
        width: 32,
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () {}, // TODO: double back to exit
        ),
      ),
    );
  }
}
