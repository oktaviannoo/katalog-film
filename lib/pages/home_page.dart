import 'package:flutter/material.dart';
import '../models/film_model.dart';
import '../services/api_service.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<FilmModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService().fetchFilms();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<List<FilmModel>> _load() {
    final q = _controller.text.trim();
    return q.isEmpty
        ? ApiService().fetchFilms()
        : ApiService().searchFilms(q);
  }

  void _reload() {
    setState(() {
      _future = _load();
    });
  }

  Widget _poster(FilmModel film) {
    if (film.posterUrl.isEmpty) {
      return const SizedBox(
        width: 90,
        height: 130,
        child: Icon(Icons.movie, size: 40),
      );
    }
    return Image.network(
      film.posterUrl,
      width: 90,
      height: 130,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const SizedBox(
          width: 90,
          height: 130,
          child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
      errorBuilder: (context, error, stackTrace) => const SizedBox(
        width: 90,
        height: 130,
        child: Icon(Icons.broken_image, size: 40),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: TextField(
        controller: _controller,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => _reload(),
        decoration: InputDecoration(
          hintText: 'Cari judul film...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _controller.clear();
              _reload();
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return FutureBuilder<List<FilmModel>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 12),
                  Text('${snapshot.error}', textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _reload,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          );
        }
        final films = snapshot.data ?? [];
        if (films.isEmpty) {
          return const Center(child: Text('Film tidak ditemukan'));
        }
        return RefreshIndicator(
          onRefresh: () async => _reload(),
          child: ListView.builder(
            itemCount: films.length,
            itemBuilder: (context, i) {
              final film = films[i];
              return Card(
                margin:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetailPage(film: film)),
                  ),
                  child: Row(
                    children: [
                      _poster(film),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(film.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text(film.releaseDate),
                              const SizedBox(height: 4),
                              Row(children: [
                                const Icon(Icons.star,
                                    size: 16, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(film.rating.toStringAsFixed(1)),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Film')),
      body: Column(
        children: [
          _searchBar(),
          Expanded(child: _content()),
        ],
      ),
    );
  }
}