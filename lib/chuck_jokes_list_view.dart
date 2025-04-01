import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chuck_joke_detail_view.dart';

class ChuckJokesListView extends StatefulWidget {
  const ChuckJokesListView({super.key});

  @override
  State<ChuckJokesListView> createState() => _ChuckJokesListViewState();
}

class _ChuckJokesListViewState extends State<ChuckJokesListView> {
  late Future<List<Map<String, String>>> _futureJokes;

  @override
  void initState() {
    super.initState();
    _futureJokes = _fetchJokes();
  }

  Future<List<Map<String, String>>> _fetchJokes() async {
    try {
      final response = await http.get(Uri.parse('https://api.chucknorris.io/jokes/search?query=all'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List jokes = data['result'];
        return jokes
            .map<Map<String, String>>((joke) => {
                  'id': joke['id'],
                  'value': joke['value'],
                  'icon_url': joke['icon_url'],
                })
            .toList();
      } else {
        throw Exception('Error al cargar los chistes.');
      }
    } catch (e) {
      throw Exception('No se pudo conectar con el servidor.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chistes de Chuck Norris')),
      body: FutureBuilder<List<Map<String, String>>>(
        future: _futureJokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No se encontraron chistes.'));
          } else {
            final jokes = snapshot.data!;
            return ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return ListTile(
                  leading: Image.network(joke['icon_url'] ?? ''),
                  title: Text(
                    joke['value']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChuckJokeDetailView(joke: joke['value'] ?? ''),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
