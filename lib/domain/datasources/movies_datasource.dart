
//! No queremos instancias de esta clase
import 'package:cinemapedia/domain/entities/movie.dart';

//! Origenes de datos
abstract class MoviesDatasource {
  // Lista de tipo Movie
  Future<List<Movie>> getNowPlaying({int page = 1});

}