
//! No queremos instancias de esta clase
import 'package:cinemapedia/domain/entities/movie.dart';

//! Origenes de datos
abstract class MoviesDatasource {
  // Lista de tipo Movie
  Future<List<Movie>> getNowPlaying({int page = 1});

  // Listado de peliculas populares
  Future<List<Movie>> getPopular({int page = 1});
  
  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

}