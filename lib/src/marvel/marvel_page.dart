import 'package:first_proj_flutter_dio/src/marvel/characters/marvel_characters_model.dart';
import 'package:first_proj_flutter_dio/src/marvel/marvel_repository.dart';
import 'package:flutter/material.dart';

class MarvelPage extends StatefulWidget {
  final String title;
  const MarvelPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MarvelPage> createState() => _MarvelPageState();
}

class _MarvelPageState extends State<MarvelPage> {
  late MarvelRepository marvelRepository;
  MarvelCharactersModel characters = MarvelCharactersModel();
  final ScrollController _scrollController = ScrollController();

  int offset = 0;
  bool loading = false;

  @override
  void initState() {
    if (mounted) {
      _scrollController.addListener(() {
        var nextPagePosition = _scrollController.position.maxScrollExtent * 0.7;
        if (_scrollController.position.pixels > nextPagePosition) {
          getCharacters();
        }
      });
      marvelRepository = MarvelRepository();
      getCharacters();
    }
    super.initState();
  }

  getCharacters() async {
    if (loading) return;
    if (characters.data == null || characters.data!.results == null) {
      characters = await marvelRepository.getCharacters(offset);
    } else {
      setState(() {
        loading = true;
      });
      offset += characters.data!.count!;
      var tempList = await marvelRepository.getCharacters(offset);
      characters.data!.results!.addAll(tempList.data!.results!);
      setState(() {
        loading = false;
      });
    }
    setState(() {});
  }

  int getTotalCharacters() {
    try {
      return characters.data!.count!;
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: characters.data == null
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title),
                    Text(
                        'Heróis: ${characters.data!.count! + offset} de ${characters.data!.total}')
                  ],
                ),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: (characters.data == null ||
                                  characters.data!.results == null)
                              ? 0
                              : characters.data!.results!.length,
                          itemBuilder: (_, index) {
                            var character = characters.data!.results![index];
                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    '${character.thumbnail!.path!}.${character.thumbnail!.extension!}',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(character.name!),
                                        const SizedBox(height: 10),
                                        Center(
                                          child: Text(character.description!),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      !loading
                          ? ElevatedButton(
                              onPressed: () => getCharacters(),
                              child: const Text('Carregar mais'),
                            )
                          : const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
