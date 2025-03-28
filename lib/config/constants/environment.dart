


import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {

  static String theMovieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? '404: API_KEY';

}