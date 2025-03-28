
import 'package:cinemapedia/config/domain/entities/movie.dart';

//! Mandan a llamar el datasource
abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({int page = 1});

}