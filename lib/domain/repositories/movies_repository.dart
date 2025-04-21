
import 'package:cinemapedia/domain/entities/movie.dart';

//! Mandan a llamar el datasource
abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({int page = 1});

  // Al momento de modicar nuestro datasource (lib/domain/datasources/...) tenemos que agregarlo en nuestro repository
  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});

    Future<Movie> getMovieById( String id );

}