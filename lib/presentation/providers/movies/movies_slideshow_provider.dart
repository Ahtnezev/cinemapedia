
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'movies_providers.dart';

// nuevo concepto para realizar pagination
final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayinMovies = ref.watch( nowPlayingMoviesProvider );
  if (nowPlayinMovies.isEmpty) return [];

  return nowPlayinMovies.sublist(0,6);
});
