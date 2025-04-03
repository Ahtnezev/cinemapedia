import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/config/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {

  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    
    final colors = Theme.of(context).colorScheme;

    // we start it with sizedbox 'cause we need to set height 
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.8, // es para ver una parte del ambos prev/next items
        scale: 0.9, // hace mas peque a los prev/next
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary
          )
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index])
      ),
    );
  }
}


class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
       borderRadius: BorderRadius.circular(20),
       boxShadow: [
        BoxShadow(
          color: Colors.black45, // fondo 
          blurRadius: 10, // difuminado
          offset: Offset(0,10) // cambiar de pos la sombra
        )
       ]
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect( // me permite crear bordes redondeados
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            fit: BoxFit.cover,
            // nos ayuda a saber cuando la imagen se construyo
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) { // signifca que esta cargandolo
                return const DecoratedBox(decoration: BoxDecoration(color: Colors.black12));
              }

              return FadeIn(child: child);
            },
          )
        )
      ),
    );
  }
}

