
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name  = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _HomeView(),
      ),
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
    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayinMovies = ref.watch(nowPlayingMoviesProvider);

    if (nowPlayinMovies.isEmpty) {
      return CircularProgressIndicator();
    }

    return ListView.builder(
      itemCount: nowPlayinMovies.length,
      itemBuilder: (context, index) {
        final movie = nowPlayinMovies[index];
        return ListTile(
          title: Text(movie.title),
        );

      },
    );
  }
}






