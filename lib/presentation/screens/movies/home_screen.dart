import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _HomeView()),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

//> Una vez que configuramos el widget en ConsumerStatefulWidget y ConsumerState ya tendremos
//> acceso al ref de manera global en el scope del initState()
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    // puente, sino colocamos el `.notifier` estaremos recibiendo el estado
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayinMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch( moviesSlideshowProvider );
    final popularMovies = ref.watch( popularMoviesProvider );
    final upcomingMovies = ref.watch( upcomingMoviesProvider );
    final topRatedMovies = ref.watch( topRatedMoviesProvider );

    if (slideShowMovies.isEmpty) {
      return CircularProgressIndicator();
    }


    //* CustomScrollView -> si tenemos varios widgets y hace desbordamiento con este queda al 100 y pasadito
    //* esto lo hacemos para poder tener control del scroll y mostrar el "header"
    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),

        SliverList(delegate: SliverChildBuilderDelegate( 
          (context, index) {
            return Column(
              children: [
            
                // const CustomAppbar(),
            
                MoviesSlideshow(movies: slideShowMovies),
            
                MovieHorizontalListview(
                  movies: nowPlayinMovies,
                  title: 'En Cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    // print('llamdo del padre');
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
            
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  subTitle: 'En este mes',
                  loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage()
                ),
            
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  // subTitle: '',
                  loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()
                ),
            
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  subTitle: 'Desde siempre',
                  loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage()
                ),
            
                SizedBox(height: 20),
            
            
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: nowPlayinMovies.length,
                //     itemBuilder: (context, index) {
                //       final movie = nowPlayinMovies[index];
                //       return ListTile(title: Text(movie.title));
                //     },
                //   ),
                // ),
            
            
              ],
            );
          },
          childCount: 1 //> numero de veces que se repetira, creo xd
        ))

      ]
    );
  }
}
