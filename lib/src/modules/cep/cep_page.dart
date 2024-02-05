import 'package:projetos_flutter_dio/main.dart';
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
  final _viaCepRepository = di<ViaCepRepository>();
  final _back4AppCepRepository = di<Back4AppCepRepository>();
  final _cepEC = TextEditingController();

  var _viaCepModel = ViaCepCepModel();
  var _back4appCeps = Back4AppCEPsModel(ceps: []);
  bool _loading = false;
  bool _loadingBack4app = true;

  @override
  void initState() {
    loadBack4AppCep();
    super.initState();
  }

  @override
  void dispose() {
    _cepEC.dispose();
    super.dispose();
  }

  loadBack4AppCep() async {
    if (mounted) {
      setState(() {
        _loadingBack4app = true;
      });
      _back4appCeps = await _back4AppCepRepository.listCEP();

      setState(() {
        _loadingBack4app = false;
      });
    }
  }

  Future<void> getCepFromViaCEP(String value) async {
    setState(() {
      _loading = true;
    });

    var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cep.length == 8) {
      _viaCepModel = await _viaCepRepository.listCEP(cep);
      await createCepOnBack4App(_viaCepModel);
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> createCepOnBack4App(ViaCepCepModel cepModel) async {
    setState(() {
      _loadingBack4app = true;
    });
    var ceps = _back4appCeps.ceps;
    if (ceps.isEmpty) {
      await _back4AppCepRepository.createCEP(
        Back4AppCepModel.fromViaCepModel(cepModel),
      );
    } else {
      if (ceps.any((cep) => cep.cep == cepModel.cep)) {
        setState(() {
          _loadingBack4app = false;
        });
        return;
      } else {
        await _back4AppCepRepository.createCEP(
          Back4AppCepModel.fromViaCepModel(cepModel),
        );
      }
    }

    _back4appCeps = await _back4AppCepRepository.listCEP();
    setState(() {
      _loadingBack4app = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 200,
                      child: CustomTextField(
                        controller: _cepEC,
                        maxLenght: 8,
                        onChanged: (value) async =>
                            await getCepFromViaCEP(value),
                        label: 'Digite o CEP aqui',
                        inputBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                    _cepEC.text.length < 8
                        ? const SizedBox.shrink()
                        : _loading
                            ? const CircularProgressIndicator()
                            : Card(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0,
                                    vertical: 9.0,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _viaCepModel.cep,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Text(
                                        '${_viaCepModel.logradouro} - ${_viaCepModel.bairro}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Text(
                                        "${_viaCepModel.localidade} - ${_viaCepModel.uf}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        "DDD ${_viaCepModel.ddd}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                  ],
                ),
                _back4appCeps.ceps.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Text(
                            'Nenhum CEP registrado!',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CEPs salvos',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Divider(),
                          _loadingBack4app
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : DataTable(
                                  sortColumnIndex: 0,
                                  columns: const [
                                    DataColumn(label: Text('ID')),
                                    DataColumn(label: Text('CEP')),
                                    DataColumn(label: Text('CIDADE')),
                                    DataColumn(label: Text('ESTADO')),
                                    DataColumn(label: Text('BAIRRO')),
                                    DataColumn(label: Text('RUA')),
                                    DataColumn(label: Text('DDD')),
                                    DataColumn(label: Text('')),
                                  ],
                                  rows: List.generate(
                                    _back4appCeps.ceps.length,
                                    (index) {
                                      var cep = _back4appCeps.ceps[index];
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Text((index + 1).toString()),
                                          ),
                                          DataCell(
                                            Text(cep.cep.toString()),
                                          ),
                                          DataCell(
                                            Text(cep.cidade.toString()),
                                          ),
                                          DataCell(
                                            Text(cep.estado.toString()),
                                          ),
                                          DataCell(
                                            Text(cep.bairro.toString()),
                                          ),
                                          DataCell(
                                            Text(cep.logradouro.toString()),
                                          ),
                                          DataCell(
                                            Text(cep.ddd.toString()),
                                          ),
                                          DataCell(
                                            IconButton(
                                              onPressed: () async {
                                                await _back4AppCepRepository
                                                    .deleteCEP(cep.objectId);
                                                loadBack4AppCep();
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
