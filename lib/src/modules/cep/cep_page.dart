import 'package:first_proj_flutter_dio/src/modules/cep/viacep_model.dart';
import 'package:first_proj_flutter_dio/src/modules/cep/viacep_repository.dart';
import 'package:first_proj_flutter_dio/src/shared/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CepPage extends StatefulWidget {
  final String title;
  const CepPage({super.key, required this.title});

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  final cepEC = TextEditingController();
  var viaCepModel = ViaCepModel();
  final viaCepRepository = ViaCepRepository();

  bool loading = false;

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            SizedBox(
              width: 200,
              child: CustomTextField(
                controller: cepEC,
                maxLenght: 8,
                onChanged: (value) async {
                  setState(() {
                    loading = true;
                  });

                  var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                  if (cep.length == 8) {
                    viaCepModel = await viaCepRepository.listCEP(cep);
                  }
                  setState(() {
                    loading = false;
                  });
                },
                label: 'Buscar CEP',
              ),
            ),
            Visibility(
              visible: loading,
              replacement: Column(
                children: [
                  const SizedBox(height: 50),
                  Text(
                    viaCepModel.logradouro ?? '',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "${viaCepModel.localidade ?? ""} - ${viaCepModel.uf ?? ""}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              child: const CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
