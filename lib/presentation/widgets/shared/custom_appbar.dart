import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      // bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity, // dale todo el ancho que puedas
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5,),
              Text('Cinemapedia', style: titleStyle,),
      
              // ocupa todo el espacio y empuja los demas al final, podria decir que es un tipo
              // d-flex justify-content-between xD
              const Spacer(),
      
              IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined))
            ],
          ),
        ),
      ),
    );
  }
}
