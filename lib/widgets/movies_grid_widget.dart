import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/movies_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoviesGridWidget extends ConsumerWidget {
  const MoviesGridWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(moviesProvider);

    return movies.when(
      data: (movieList) => GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          final movie = movieList[index];
          return Column(
            children: [
              CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                height: 150,
                fit: BoxFit.cover,
              ),
              Text(movie.title, textAlign: TextAlign.center),
              Text('Rating: ${movie.rating}'),
            ],
          );
        },
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error loading movies')),
    );
  }
}
