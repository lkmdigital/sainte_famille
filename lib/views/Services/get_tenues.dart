import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../api/api.dart';
import '../../models/scolarite.dart';
// import 'autre_montant.dart';
import 'mode_paiement.dart';

class GetTenueScolaire extends StatefulWidget {
  Map data;
  GetTenueScolaire({Key? key, required this.data}) : super(key: key);

  @override
  State<GetTenueScolaire> createState() => _GetTenueScolaireState();
}

class _GetTenueScolaireState extends State<GetTenueScolaire> {
  final formatter = NumberFormat.currency(locale: 'fr_XOF', symbol: 'XOF');
  NumberFormat myFormat = NumberFormat.decimalPattern('eu');

  Future<List<Scolarite>> getMontant() async {
    List<Scolarite> listMontant = [];
    var response = await http.post(
      Uri.parse(Api.getTenueScolaire),
      body: {
        'classe': "${widget.data['classe']}",
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listMontant.add(Scolarite.fromJson(element));
        }
      }
    }
    return listMontant;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // floatingActionButton: Container(
        //     height: size.height * 0.055,
        //     width: size.width * 0.9,
        //     decoration: BoxDecoration(
        //       color:
        //           Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
        //       borderRadius: BorderRadius.circular(20.0),
        //       border: const Border.fromBorderSide(BorderSide.none),
        //     ),
        //     child: InkWell(
        //       onTap: () {
        //         // Get.to(
        //         //   () => AutreMontant(data: widget.data),
        //         //   fullscreenDialog: true,
        //         // );
        //       },
        //       child: Row(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           AutoSizeText(
        //             "Saisir un montant",
        //             style: TextStyle(
        //                 color: Theme.of(context)
        //                     .buttonTheme
        //                     .colorScheme!
        //                     .onPrimary,
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 16),
        //             maxLines: 1,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ],
        //       ),
        //     )),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const AutoSizeText(
            "TENUES SCOLAIRES",
            maxFontSize: 15,
            minFontSize: 14,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
        ),
        body: buildAll());
  }

  Widget buildAll() {
    return FutureBuilder(
      future: getMontant(),
      builder: (context, AsyncSnapshot<List<Scolarite>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
              //Chargement shimmer
              baseColor: const Color.fromARGB(255, 212, 208, 208),
              highlightColor: const Color.fromARGB(255, 253, 250, 250),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ));
        }
        if (snapshot.data == null) {
          return const Center(
            child: Text('Vide'),
          );
        }
        if (snapshot.data!.isNotEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  // color: Colors.amber,
                  height: MediaQuery.of(context).size.height * 1,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Scolarite scolarite = snapshot.data![index];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).padding.bottom,
                                // vertical: 15
                              ),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  radius: 35,
                                  child: Icon(
                                    Icons.school,
                                
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  size: 20,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      scolarite.libelle,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                subtitle: Text('${scolarite.montant} FCFA'),
                                onTap: (() {
                                  var montantInital = scolarite.montant
                                      .replaceAll(RegExp(r"\s+"), "");
                                  var montant = int.parse(montantInital);
                                  // print(montant);

                                  int selectedCount = 1; // Valeur par défaut
                                  int maxItemCount =
                                      5; // Nombre maximum d'articles que vous voulez autoriser

                                  showAdaptiveDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (context, setState) {
                                          int montantTotal = montant *
                                              selectedCount; // Calcul du montant total

                                          return AlertDialog.adaptive(
                                            title: Text(
                                              'Choisissez le nombre d\'articles',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.remove),
                                                        onPressed: () {
                                                          if (selectedCount >
                                                              1) {
                                                            setState(() {
                                                              selectedCount--;
                                                            });
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Text(
                                                      selectedCount.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                    CircleAvatar(
                                                      child: IconButton(
                                                        icon: const Icon(
                                                            Icons.add),
                                                        onPressed: () {
                                                          if (selectedCount <
                                                              maxItemCount) {
                                                            setState(() {
                                                              selectedCount++;
                                                            });
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 16),
                                                Text(
                                                    'Montant total : ${myFormat.format(montantTotal)} F CFA',
                                                    // 'Montant total: $montantTotal FCFA',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Anuuler")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    // Naviguer vers l'écran de paiement avec les données mises à jour
                                                    var data = widget.data;
                                                    Get.to(
                                                      () => ModePaiement(
                                                        data: data,
                                                        montant: montantTotal,
                                                        echeancier:
                                                            "$selectedCount ${scolarite.libelle}",
                                                      ),
                                                    );
                                                  },
                                                  child: const Text("Valider")),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                }),
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.02,
                // )
              ],
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.4),
            child: const Center(child: Text('Vide')),
          );
        }
      },
    );
  }
}
