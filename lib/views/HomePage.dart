import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pingou_app/classes/Pacote.dart';
import 'package:pingou_app/src/Style.dart';
import 'package:pingou_app/views/Encomenda.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final chaveForm = GlobalKey<FormState>();
  TextEditingController codigoController = TextEditingController();
  dynamic iconeBtn = FaIcon(FontAwesomeIcons.arrowRightLong);
  Color corBtn = Colors.blue;
  Pacote pacoteEncomenda = Pacote();
  String? cod;
  var pacote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: corPrincipal,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.truck,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Text(
                    "Pingou!",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Text(
                "Rastreio de encomendas de uma forma fácil!",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.043,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.15,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Form(
                    key: chaveForm,
                    child: TextFormField(
                      validator: (codigoDeRastreio) {
                        if (codigoDeRastreio == null ||
                            codigoDeRastreio.isEmpty) {
                          return "Favor preencher o campo";
                        }
                        if (codigoDeRastreio.length < 12) {
                          return "Favor informar o código completo";
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.purple[50],
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                      textAlign: TextAlign.center,
                      controller: codigoController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (chaveForm.currentState!.validate()) {
                              setState(() {
                                iconeBtn = const CircularProgressIndicator();
                              });

                              try {
                                pacote = await pacoteEncomenda.Rastreiar(
                                    codigoController.text.trim());
                                setState(
                                  () {
                                    corBtn = Colors.green;
                                    iconeBtn = const FaIcon(
                                        FontAwesomeIcons.circleCheck);
                                  },
                                );
                                await Future.delayed(
                                  const Duration(
                                    milliseconds: 200,
                                  ),
                                );

                                setState(() {
                                  corBtn = Colors.blue;
                                  iconeBtn = const FaIcon(
                                      FontAwesomeIcons.arrowRightLong);
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Encomenda(
                                      cod: pacote,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                setState(() {
                                  iconeBtn = const FaIcon(
                                      FontAwesomeIcons.arrowRightLong);
                                });
                                erro(e.toString());
                              }
                            }
                          },
                          icon: iconeBtn,
                          iconSize: MediaQuery.of(context).size.width * 0.075,
                          color: corBtn,
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 30,
                          ),
                        ),
                        hintText: "Digite seu código de rastreio",
                        hintStyle: TextStyle(
                          color: Colors.purple[600],
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: corSecundaria,
                            width: 4,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10.00),
                            bottomLeft: Radius.circular(40.00),
                            topRight: Radius.circular(40.00),
                            topLeft: Radius.circular(10.00),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurpleAccent,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10.00),
                            bottomLeft: Radius.circular(40.00),
                            topRight: Radius.circular(40.00),
                            topLeft: Radius.circular(10.00),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: corErro,
                            width: 3,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10.00),
                            bottomLeft: Radius.circular(40.00),
                            topRight: Radius.circular(40.00),
                            topLeft: Radius.circular(10.00),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: CorErroFocus,
                            width: 3,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10.00),
                            bottomLeft: Radius.circular(40.00),
                            topRight: Radius.circular(40.00),
                            topLeft: Radius.circular(10.00),
                          ),
                        ),
                        errorStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: corTerciaria,
        child: const FaIcon(FontAwesomeIcons.question),
        onPressed: sobre,
      ),
    );
  }

  void sobre() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(
              "Sobre",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: corPrincipal,
                fontSize: MediaQuery.of(context).size.width * 0.063,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "É um sistema de rastreio de encomendas que utiliza a API do Link & Track.\nFoi idealizado como um projeto de estudo para portfolio, por isso possíveis erros podem aparecer.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.043,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: corTerciaria,
                      fontSize: MediaQuery.of(context).size.width * 0.063,
                    ),
                  ))
            ],
          );
        });
  }

  void erro(String error) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: Text(
              "Erro",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: corPrincipal,
                fontSize: MediaQuery.of(context).size.width * 0.063,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "${error}",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.043,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: corTerciaria,
                      fontSize: MediaQuery.of(context).size.width * 0.063,
                    ),
                  ))
            ],
          );
        });
  }
}
