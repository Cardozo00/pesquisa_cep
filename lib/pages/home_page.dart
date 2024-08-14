import 'package:flutter/material.dart';
import 'package:pesquisacep/model/back4app_model.dart';
import 'package:pesquisacep/model/via_cep_model.dart';
import 'package:pesquisacep/repository/back4app/back4app_repository.dart';
import 'package:pesquisacep/repository/via_cep_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Back4appRepository back4appRepository = Back4appRepository();
  var cepController = TextEditingController(text: "");
  var viaCepModel = ViaCepModel();
  var viaCepRepository = ViaCepRepository();
  bool loading = false;
  var cepBack4App = Back4AppModel([]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    setState(() {
      loading = true;
    });
    cepBack4App = await back4appRepository.obterCep();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historico de pesquisa"),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            cepController.text = "";
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Digite um cep"),
                    content: TextField(
                      maxLength: 8,
                      onChanged: (String value) async {
                        var cep = value.replaceAll(RegExp(r'[^0-9]'), '');

                        if (cep.length == 8) {
                          viaCepModel =
                              await viaCepRepository.consultarCep(cep);
                        }
                      },
                      controller: cepController,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });

                            viaCepModel = await viaCepRepository
                                .consultarCep(cepController.text);

                            await back4appRepository.criar(
                                Back4appModelCep.criar(
                                    viaCepModel.logradouro ?? "",
                                    viaCepModel.bairro ?? "",
                                    viaCepModel.localidade ?? "",
                                    viaCepModel.uf ?? "",
                                    viaCepModel.cep ?? ""));

                            carregarDados();
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Salvar"))
                    ],
                  );
                });
          }),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            loading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                        itemCount: cepBack4App.results.length,
                        itemBuilder: (BuildContext bc, int index) {
                          var cep = cepBack4App.results[index];

                          return Dismissible(
                              onDismissed:
                                  (DismissDirection dismissDirection) async {
                                await back4appRepository.remover(cep.objectId);
                              },
                              key: Key(cep.cep),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Card(
                                  elevation: 6,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Rua: ${cep.rua},  ${cep.bairro}'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text('Cidade: ${cep.cidade}-${cep.uf}'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text("Cep: ${cep.cep}")
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
