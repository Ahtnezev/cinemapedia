
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! cuando queramos consultar aquellas peliculas usare este provider
// clase que lo controla o que notifica es el MoviesNotifer y la data/state es el listado de Movie 
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

// para saber que funcion debo de recibir
typedef MovieCallBack = Future<List<Movie>> Function({int page});

// State_Notifier_Provider -> proveedor que notifica cuando cambie el estado
class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  MovieCallBack fetchMoreMovies;   

  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    // en este momento el state es un array vacio -> : super([]);
    state = [...state, ...movies];
  }

}
