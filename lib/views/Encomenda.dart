import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pingou_app/src/Style.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Encomenda extends StatefulWidget {
  final String cod;
  Encomenda({Key? key, required this.cod}) : super(key: key);

  @override
  State<Encomenda> createState() => _EncomendaState();
}

List<String> statusFrases = [
  "Corre para o abraço",
  "Pode ir ficar esperando na calçada",
  "Apenas sente e espere",
  "Não passa nem wi-fi",
  "Algum dia chega",
  "Ai o core não aguenta",
  "O começo do sofrimento",
];

List<String> statusEncomenda = [
  "Objeto entregue ao destinatário",
  "Objeto saiu para entrega ao destinatário",
  "Objeto encaminhado",
  "Fiscalização aduaneira finalizada",
  "Objeto recebido pelos Correios do Brasil",
  "Objeto postado após o horário limite da unidade",
  "Objeto postado"
];

class _EncomendaState extends State<Encomenda> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> encomenda = jsonDecode(widget.cod);

    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
        backdropEnabled: true,
        header: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 1,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
          ),
          child: Text(
            "Status",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: corPrincipal,
              fontFamily: 'Roboto',
              fontSize: MediaQuery.of(context).size.width * 0.14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
        panel: Padding(
          padding: const EdgeInsets.only(
            top: 101,
            left: 15,
            right: 15,
          ),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Data: ${encomenda["eventos"][index]["data"]}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Hora: ${encomenda["eventos"][index]["hora"]}",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          FaIcon(iconStatus(index, encomenda),
                              color: corStatus(index, encomenda)),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              "${encomenda["eventos"][index]["status"]}",
                              style: TextStyle(
                                color: corStatus(index, encomenda),
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.053,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${encomenda["eventos"][index]["local"]}",
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.045,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.black,
            ),
            itemCount: encomenda["quantidade"],
          ),
        ),
        body: Container(
          color: corPrincipal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.box,
                      size: MediaQuery.of(context).size.width * 0.1,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Encomenda",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: MediaQuery.of(context).size.width * 0.12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "${encomenda["codigo"]}",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.blue,
                    fontFamily: 'Roboto',
                    fontSize: MediaQuery.of(context).size.width * 0.085,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.robot,
                      size: MediaQuery.of(context).size.width * 0.08,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        "${textoStatus(encomenda)}",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: MediaQuery.of(context).size.width * 0.07,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: FloatingActionButton(
          backgroundColor: corSecundaria,
          child: const FaIcon(
            FontAwesomeIcons.arrowLeftLong,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Color corStatus(int i, Map item) {
    if (statusEncomenda[0] == item["eventos"][i]["status"]) {
      return Colors.green;
    } else if (statusEncomenda[1] == item["eventos"][i]["status"]) {
      return Colors.blue;
    } else if (statusEncomenda[2] == item["eventos"][i]["status"]) {
      return Colors.orange.shade700;
    } else if (statusEncomenda[3] == item["eventos"][i]["status"]) {
      return Colors.red;
    } else if (statusEncomenda[4] == item["eventos"][i]["status"]) {
      return Colors.black;
    } else if (statusEncomenda[5] == item["eventos"][i]["status"]) {
      return Colors.grey;
    } else if (statusEncomenda[6] == item["eventos"][i]["status"]) {
      return Colors.grey;
    } else {
      return Colors.black;
    }
  }

  IconData iconStatus(int i, Map item) {
    if (statusEncomenda[0] == item["eventos"][i]["status"]) {
      return FontAwesomeIcons.check;
    } else if (statusEncomenda[1] == item["eventos"][i]["status"]) {
      return FontAwesomeIcons.truckFast;
    } else if (statusEncomenda[2] == item["eventos"][i]["status"]) {
      return FontAwesomeIcons.dolly;
    } else if (statusEncomenda[3] == item["eventos"][i]["status"]) {
      return FontAwesomeIcons.personMilitaryPointing;
    } else if (statusEncomenda[4] == item["eventos"][i]["status"]) {
      return FontAwesomeIcons.parachuteBox;
    } else if (statusEncomenda[5] == item["eventos"][i]["status"]) {
      return FontAwesomeIcons.peopleCarryBox;
    } else if (statusEncomenda[6] == item["eventos"][i]["status"]) {
      return FontAwesomeIcons.peopleCarryBox;
    } else {
      return FontAwesomeIcons.question;
    }
  }

  String? textoStatus(Map item) {
    if (item["quantidade"] == 0) {
      return "Acalma o coração que ainda não dá para rastreiar";
    } else {
      for (var i = 0; i <= item["quantidade"] - 1; i++) {
        if (statusEncomenda[i] == item["eventos"][i]["status"]) {
          return statusFrases[i];
        }
      }
    }
    return "Eita boy";
  }
}
