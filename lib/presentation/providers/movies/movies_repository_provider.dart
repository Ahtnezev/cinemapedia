
import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! Este repositorio es inmutable
final movieRepositoryProvider = Provider((ref) {

  return MovieRepositoryImpl(MoviedbDatasource());

  // si al dia de mañana ya no se utiliza MoviedbDatasource podremos cambiar facilmente
  // return MovieRepositoryImpl( IMDBDatasource() );
});