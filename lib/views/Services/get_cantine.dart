import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../api/api.dart';
import '../../models/scolarite.dart';
import 'autre_montant.dart';
import 'mode_paiement.dart';


class GetCantine extends StatefulWidget {
  Map data;
  GetCantine({Key? key, required this.data}) : super(key: key);

  @override
  State<GetCantine> createState() => _GetCantineState();
}

class _GetCantineState extends State<GetCantine> {
  final formatter = NumberFormat.currency(locale: 'fr_XOF', symbol: 'XOF');

  Future<List<Scolarite>> getMontant() async {
    List<Scolarite> listMontant = [];
    var response = await http.post(
      Uri.parse(Api.getScolarite),
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
        floatingActionButton: Container(
            height: size.height * 0.055,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
              borderRadius: BorderRadius.circular(20.0),
              border: const Border.fromBorderSide(BorderSide.none),
            ),
            child: InkWell(
              onTap: () {
                Get.to(
                  () => AutreMontant(data: widget.data),
                  fullscreenDialog: true,
                );
              },
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    "Saisir un montant",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const AutoSizeText(
            "ECHEANCIER CANTINE",
            maxFontSize: 15,
            minFontSize: 14,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
        ),
      
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    child: Icon(
                      Icons.school,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  trailing: Text(
                    '180.000 FCFA',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  title: const Text(
                    "1er Versement",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  
                  onTap: (() {
                    var data = widget.data;
                    Get.to(
                      () => ModePaiement(
                          data: data,
                          montant: 180000,
                          echeancier: '1er Versement'),
                    );
                  }),
                ),
                const Divider(),
                ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    child: Icon(
                      Icons.school,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  trailing: Text(
                    '100.000 FCFA',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                   title: const Text(
                    "2e Versement",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  
                  onTap: (() {
                    var data = widget.data;
                    Get.to(
                      () => ModePaiement(
                          data: data,
                          montant: 80000,
                          echeancier: '2e Versement'),
                    );
                  }),
                ),
               const Divider(),
                ListTile(
                  leading: CircleAvatar(
                    radius: 35,
                    child: Icon(
                      Icons.school,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  trailing: Text(
                    '80.000 FCFA',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                   title: const Text(
                    "3e Versement",
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  onTap: (() {
                    var data = widget.data;
                    Get.to(
                      () => ModePaiement(
                          data: data,
                          montant: 50000,
                          echeancier: '3e Versement'),
                    );
                  }),
                ),
                // const Divider(),
                // ListTile(
                //   leading: CircleAvatar(
                //     radius: 35,
                //     child: Icon(
                //       Icons.school,
                //       color: Theme.of(context).scaffoldBackgroundColor,
                //     ),
                //   ),
                //   trailing: Text(
                //     '50.000 FCFA',
                //     style: Theme.of(context).textTheme.titleSmall,
                //   ),
                //   title: const Text(
                //     "1 Voyage",
                //     style: TextStyle(fontWeight: FontWeight.w900),
                //   ),
                //   subtitle: const Text(
                //     "Matin ou Soir",
                //   ),
                //   onTap: (() {
                //     var data = widget.data;
                //     Get.to(
                //       () => ModePaiement(
                //           data: data,
                //           montant: 50000,
                //           echeancier: '1 voyage matin ou soir'),
                //     );
                //   }),
                // ),
                // const Divider(),
                // ListTile(
                //   leading: CircleAvatar(
                //     radius: 35,
                //     child: Icon(
                //       Icons.school,
                //       color: Theme.of(context).scaffoldBackgroundColor,
                //     ),
                //   ),
                //   trailing: Text(
                //     '270.000 FCFA',
                //     style: Theme.of(context).textTheme.titleSmall,
                //   ),
                //   title: const Text(
                //     "2 Voyages",
                //     style: TextStyle(fontWeight: FontWeight.w900),
                //   ),
                //   subtitle: const Text(
                //     "Matin et Soir",
                //   ),
                //   onTap: (() {
                //     var data = widget.data;
                //     Get.to(
                //       () => ModePaiement(
                //           data: data,
                //           montant: 270000,
                //           echeancier: 'voyage matin et soir'),
                //     );
                //   }),
                // ),
                // const Divider(),
                // ListTile(
                //   leading: CircleAvatar(
                //     radius: 35,
                //     child: Icon(
                //       Icons.school,
                //       color: Theme.of(context).scaffoldBackgroundColor,
                //     ),
                //   ),
                //   trailing: Text(
                //     '120.000 FCFA',
                //     style: Theme.of(context).textTheme.titleSmall,
                //   ),
                //   title: const Text(
                //     "2 Voyages",
                //     style: TextStyle(fontWeight: FontWeight.w900),
                //   ),
                //   subtitle: const Text(
                //     "Matin et Soir",
                //   ),
                //   onTap: (() {
                //     var data = widget.data;
                //     Get.to(
                //       () => ModePaiement(
                //           data: data,
                //           montant: 120000,
                //           echeancier: 'voyage matin et soir'),
                //     );
                //   }),
                // ),
                // const Divider(),
                // ListTile(
                //   leading: CircleAvatar(
                //     radius: 35,
                //     child: Icon(
                //       Icons.school,
                //       color: Theme.of(context).scaffoldBackgroundColor,
                //     ),
                //   ),
                //   trailing: Text(
                //     '75.000 FCFA',
                //     style: Theme.of(context).textTheme.titleSmall,
                //   ),
                //   title: const Text(
                //     "2 Voyages",
                //     style: TextStyle(fontWeight: FontWeight.w900),
                //   ),
                //   subtitle: const Text(
                //     "Matin et Soir",
                //   ),
                //   onTap: (() {
                //     var data = widget.data;
                //     Get.to(
                //       () => ModePaiement(
                //           data: data,
                //           montant: 75000,
                //           echeancier: 'voyage matin et soir'),
                //     );
                //   }),
                // ),
                // const Divider(),
                // ListTile(
                //   leading: CircleAvatar(
                //     radius: 35,
                //     child: Icon(
                //       Icons.school,
                //       color: Theme.of(context).scaffoldBackgroundColor,
                //     ),
                //   ),
                //   trailing: Text(
                //     '75.000 FCFA',
                //     style: Theme.of(context).textTheme.titleSmall,
                //   ),
                //   title: const Text(
                //     "2 Voyages",
                //     style: TextStyle(fontWeight: FontWeight.w900),
                //   ),
                //   subtitle: const Text(
                //     "Matin et Soir",
                //   ),
                //   onTap: (() {
                //     var data = widget.data;
                //     Get.to(
                //       () => ModePaiement(
                //           data: data,
                //           montant: 75000,
                //           echeancier: 'voyage matin et soir'),
                //     );
                //   }),
                // ),
              ],
            ),
          ),
        );
        }}