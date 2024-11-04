import 'package:flutter/material.dart';


class AbonnementPage extends StatefulWidget {
  const AbonnementPage({
    Key? key,
  }) : super(key: key);
  @override
  State<AbonnementPage> createState() => _AbonnementPageState();
}

class _AbonnementPageState extends State<AbonnementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ElevatedButton(
          onPressed: () {
            // Get.off(() => const AwaitWebhook());
          },
          style: ButtonStyle(
              fixedSize: WidgetStateProperty.all(
                Size(MediaQuery.of(context).size.width, 45),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              backgroundColor: WidgetStateProperty.all<Color>(
                Theme.of(context).buttonTheme.colorScheme!.primary,
              )),
          child: Text(
            "S'abonner",
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage("assets/images/nav-arc1.png"),
              // image: const AssetImage("assets/images/logo.png"),

              width: MediaQuery.of(context).size.width * 0.2,
              // height: MediaQuery.of(context).size.height * 0.12,
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Incroyable mais',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  // style: GoogleFonts.kaushanScript(fontSize: 25),
                ),
                Text(
                  ' WAVE 🤩',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),

                  // style:
                  //     GoogleFonts.kaushanScript(fontSize: 25, color: Colors.blue),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "FRAIS DE TRANSACTIONS : 0 F",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "durant toute l'année scolaire.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 8,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    // style: ListTileStyle(),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Forfait annuel',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontWeight: FontWeight.w600),
                              ),
                              // SizedBox(height: 50,),
                              Container(
                                  decoration: BoxDecoration(
                                      // border: Border.all(color: Colors.red),
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      'Economisez 37%',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.025,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "13.500 F CFA par an",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // subtitle: Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: Text(
                    //     'Total: 13.500 F CFA par an',
                    //     style: Theme.of(context).textTheme.bodySmall,
                    //   ),
                    // ),
                    trailing: Icon(
                      Icons.check_circle_outline_outlined,
                      size: 50,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Text(
                "Optez pour un abonnement annuel et réglez le coût de la Scolarité, Cantine et Transport de vos enfants via WAVE sans payer aucun frais durant toute l’année scolaire.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        )),
      ),
    );
  }
}
