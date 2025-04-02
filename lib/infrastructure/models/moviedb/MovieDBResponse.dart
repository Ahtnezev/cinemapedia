import 'movie_moviedb.dart';

// Este lo sacamos del response de: https://api.themoviedb.org/3/movie/now_playing?api_key=b9bdb1ad0b85dc7752dcb2bd8ba46e52&language=es-MX
// Lo convertimos en: https://quicktype.io/ y lo modificamos con el archivo `movie_moviedb.dart`

class MovieDBResponse {
    MovieDBResponse({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    final Dates? dates;
    final int page;
    final List<MovieMovieDB> results;
    final int totalPages;
    final int totalResults;

    factory MovieDBResponse.fromJson(Map<String, dynamic> json) => MovieDBResponse(
        dates: json["dates"] != null ? Dates.fromJson(json["dates"]) : null,
        page: json["page"],
        results: List<MovieMovieDB>.from(json["results"].map((x) => MovieMovieDB.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Dates {
    Dates({
        required this.maximum,
        required this.minimum,
    });

    final DateTime maximum;
    final DateTime minimum;

    factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

    Map<String, dynamic> toJson() => {
        "maximum": "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
    };
}

