import 'package:projetos_flutter_dio/src/modules/cep/models/back4app_cep_model.dart';
import 'package:projetos_flutter_dio/src/modules/cep/models/viacep_cep_model.dart';
import 'package:projetos_flutter_dio/src/modules/cep/repositories/back4app_cep_repository.dart';
import 'package:projetos_flutter_dio/src/modules/cep/repositories/viacep_repository.dart';
import 'package:projetos_flutter_dio/src/shared/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CepPage extends StatefulWidget {
  final String title;
  const CepPage({super.key, required this.title});

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  late ViaCepRepository _viaCepRepository;
  late Back4AppCepRepository _back4AppCepRepository;
  late ViaCepCepModel _viaCepModel;
  late Back4AppCEPsModel _back4appCeps;

  final _cepEC = TextEditingController();
  bool loading = false;
  bool loadingBack4app = false;

  @override
  void initState() {
    _viaCepModel = ViaCepCepModel();
    _back4appCeps = Back4AppCEPsModel(ceps: []);
    _back4AppCepRepository = Back4AppCepRepository();
    _viaCepRepository = ViaCepRepository();
    super.initState();
  }

  @override
  void dispose() {
    _cepEC.dispose();
    super.dispose();
  }

  getCepFromViaCEP(String value) async {
    setState(() {
      loading = true;
    });

    var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cep.length == 8) {
      _viaCepModel = await _viaCepRepository.listCEP(cep);
    }
    setState(() {
      loading = false;
    });
  }

  createCepOnBack4App() async {
    _back4appCeps = await _back4AppCepRepository.listCEP();

    if (_back4appCeps.ceps.isNotEmpty) {
      setState(() {
        loadingBack4app = true;
      });
      var ceps = _back4appCeps.ceps;
      for (var cep in ceps) {
        if (cep.cep != _viaCepModel.cep) {
          await _back4AppCepRepository.createCEP(cep);
        }
      }

      _back4appCeps = await _back4AppCepRepository.listCEP();

      setState(() {
        loadingBack4app = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createCepOnBack4App(),
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 200,
                child: CustomTextField(
                  controller: _cepEC,
                  maxLenght: 8,
                  onChanged: (value) => getCepFromViaCEP(value),
                  label: 'Buscar CEP',
                ),
              ),
            ),
            Center(
              child: Visibility(
                visible: loading,
                replacement: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      _viaCepModel.logradouro,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "${_viaCepModel.localidade} - ${_viaCepModel.uf}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                child: const CircularProgressIndicator(),
              ),
            ),
            const Text('CEPs salvos'),
            Expanded(
              child: loadingBack4app
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: _back4appCeps.ceps.length,
                      itemBuilder: (context, index) {
                        var _cep = _back4appCeps.ceps[index];
                        return DataTable(
                          columns: [DataColumn(label: Text('CEP'))],
                          rows: [],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
