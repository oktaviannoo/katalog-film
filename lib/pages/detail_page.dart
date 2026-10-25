import 'package:flutter/material.dart';
import '../models/film_model.dart';

class DetailPage extends StatelessWidget {
  final FilmModel film;
  const DetailPage({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(film.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                film.posterUrl,
                height: 300,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.movie, size: 100),
              ),
            ),
            const SizedBox(height: 16),
            Text(film.title,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Rilis: ${film.releaseDate}'),
            Text('Rating: ${film.rating.toStringAsFixed(1)}'),
            const SizedBox(height: 16),
            Text(film.overview),
          ],
        ),
      ),
    );
  }
}