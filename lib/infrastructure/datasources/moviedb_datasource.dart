import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/config/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/MovieDBResponse.dart';
import 'package:dio/dio.dart';

// utilizaremos `dio` para peticiones http
class MoviedbDatasource extends MoviesDatasource {
  //! esta configuracion es propia para este datasource
  // a nivel propiedad de la clase
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page
    });
    final movieDBResponse = MovieDBResponse.fromJson(response.data);

    final List<Movie> movies =
        movieDBResponse.results
            .where((moviedb) => moviedb.posterPath != 'no-poster')
            .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
            .toList();

    return movies;
  }
}
