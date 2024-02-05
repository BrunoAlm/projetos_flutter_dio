import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:projetos_flutter_dio/main.dart';
import 'package:projetos_flutter_dio/src/modules/counter/counter_mobx_service.dart';
import 'package:projetos_flutter_dio/src/modules/counter/counter_mobx_store.dart';
import 'package:projetos_flutter_dio/src/modules/counter/counter_provider_service.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  var counterMobxService = di<CounterMobxService>();
  var counterMobXStore = di<CounterMobXStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    const Text(
                      'Contador com Provider',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Você pressionou o botão:',
                    ),
                    Consumer<CounterProviderService>(
                      builder: (context, counterService, child) => Text(
                        '${counterService.counter} vezes',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    const Text(
                      'Contador com MobX',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Você pressionou o botão:',
                    ),
                    Observer(
                      builder: (context) => Text(
                        '${counterMobxService.counter} vezes',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    const Text(
                      'Contador com MobX Codegen',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Você pressionou o botão:',
                    ),
                    Observer(
                      builder: (context) => Text(
                        '${counterMobXStore.counter} vezes',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterProviderService>(context, listen: false)
              .increment();
          counterMobxService.increment();
          counterMobXStore.increment();
        },
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
