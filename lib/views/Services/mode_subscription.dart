import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/api.dart';
import '../../controllers/c_user.dart';
import '../../widgets/info_message.dart';
import 'package:http/http.dart' as http;

class ModeSubscription extends StatefulWidget {
  Map data;
  final montant;
  final String echeancier;

  ModeSubscription(
      {Key? key,
      required this.data,
      required this.montant,
      required this.echeancier})
      : super(key: key);

  @override
  State<ModeSubscription> createState() => _ModeSubscriptionState();
}

class _ModeSubscriptionState extends State<ModeSubscription> {
  final TextEditingController _telephoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CUser _cUser = Get.find();

    NumberFormat myFormat = NumberFormat.decimalPattern('eu');
    Size size = MediaQuery.of(context).size;
    var v1 = widget.montant.toString();

    var v11 = v1.replaceAll(RegExp(r"\s+"), "");
    var v2 = int.parse(v11);
    var fraisWave = (v2 * 1 / 100).ceil();
    var fraisMTN = (v2 * 1 / 100).ceil();
    var fraisVISA = (v2 * 2.5 / 100).ceil();
    var fraisOrange = (v2 * 1 / 100).ceil();

    var fraisEliah = (v2 / 100).ceil();

    var wave = v2 + fraisWave;
    var mtn = v2 + fraisMTN;
    var orange = v2 + fraisOrange;
    var visa = v2 + fraisVISA;
    final formKey = GlobalKey<FormState>();

    Future<void> makePayment(String mode) async {
      try {
        var response = await http.post(
          Uri.parse(Api.paySubscription),
          body: {
            'id_user': '${_cUser.user.id_user}',
            'mode_paiement': mode.toUpperCase(),
            'montant': '9900',
          },
        );
        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body);
          Uri url = Uri.parse(responseBody);

          {
            Get.back();
            print(url);
            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
              throw 'Could not launch $url';
            }
          }
        } else {
          InfoMessage.snackbar(Get.context!, 'Échec de la connexion');
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choix de l'opérateur"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                makePayment('WAVECI');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(color: Colors.white)),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: backgroundColor,
                        image: const DecorationImage(
                          image: AssetImage("assets/images/wave.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        "Wave",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: Text("Paiement via Wave",
                          style: TextStyle(fontSize: 12)),
                    ),
                    // trailing: const Text(
                    //   "1%",
                    //   style: TextStyle(fontSize: 15),
                    // ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                makePayment('OMCI');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      border: Border.all(color: Colors.white)),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // color: backgroundColor,
                        image: const DecorationImage(
                          image: AssetImage("assets/images/orange.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    title: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        "Orange Money",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    subtitle: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: Text("Paiement via Orange Money",
                          style: TextStyle(fontSize: 12)),
                    ),
                    // trailing: Container(
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.red),
                    //         borderRadius: BorderRadius.circular(5)),
                    //     child: const Padding(
                    //       padding: EdgeInsets.all(3.0),
                    //       child: Text(
                    //         'Indisponible',
                    //         style: TextStyle(
                    //             color: Colors.red, fontWeight: FontWeight.bold),
                    //       ),
                    //     )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
