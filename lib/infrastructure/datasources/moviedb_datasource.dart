import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
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

  List<Movie> _jsonToMovies( Map<String, dynamic> json ) {
      final movieDBResponse = MovieDBResponse.fromJson(json);

      final List<Movie> movies =
          movieDBResponse.results
              .where((moviedb) => moviedb.posterPath != 'no-poster')
              .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
              .toList();

      return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page
    });
    
    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
      // segun el api nos devuelve las mismas peliculas xD pero si queremos ver otras diferentes podremos usar por ej.: /upcoming
      // https://developer.themoviedb.org/reference/movie-popular-list
      final response = await dio.get('/movie/popular', queryParameters: {
        'page': page
      });

    return _jsonToMovies(response.data);
  }
}
