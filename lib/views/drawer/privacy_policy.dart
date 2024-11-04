import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Couleurs.CouleurSecondaire,
        title: const Text("Politique de confidentialité"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "La présente politique de confidentialité décrit comment LKM DIGITAL collecte, utilise et protège les informations personnelles que vous nous fournissez lorsque vous utilisez notre application de paiement de frais d'écolage pour l'école Saint Viateur. Nous accordons une grande importance à la confidentialité de vos informations personnelles et nous nous engageons à les protéger conformément aux lois applicables en matière de protection des données.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Collecte et utilisation des informations",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Lorsque vous utilisez notre application, nous pouvons collecter les informations personnelles suivantes :",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Informations personnelles :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              buildListItem('Nom complet'),
              buildListItem('Adresse électronique'),
              buildListItem('Numéro de téléphone'),
              buildListItem('Informations bancaires / Carte de crédit'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Utilisation des informations personnelles",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Nous utilisons les informations personnelles que nous collectons afin de faciliter le processus de paiement des frais d'écolage de l'école Saint Viateur. Les principales utilisations de vos informations sont les suivantes :",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              buildListItem(
                  'Traiter les paiements et fournir les services demandés'),
              const SizedBox(
                height: 10,
              ),
              buildListItem(
                  "Communiquer avec vous concernant les transactions et les mises à jour de l'application"),
              const SizedBox(
                height: 10,
              ),
              buildListItem(
                  "Résoudre les problèmes techniques ou répondre à vos demandes d'assistance"),
              const SizedBox(
                height: 10,
              ),
              buildListItem(
                  "Améliorer et personnaliser l'expérience utilisateur de l'application"),
              const SizedBox(
                height: 10,
              ),
              buildListItem(
                  "Respecter nos obligations légales et réglementaires"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Partage des informations personnelles",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Nous ne partagerons pas vos informations personnelles avec des tiers, sauf dans les cas suivants :",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              buildListItem(
                  "Lorsque cela est nécessaire pour fournir les services demandés (par exemple, avec les établissements financiers pour traiter les paiements)"),
              const SizedBox(
                height: 10,
              ),
              buildListItem(
                  "Si la loi l'exige ou si nous sommes tenus de le faire par une autorité compétente"),
              const SizedBox(
                height: 10,
              ),
              buildListItem(
                  "Si cela est nécessaire pour protéger nos droits, notre sécurité ou notre propriété"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Sécurité des informations personnelles",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Nous mettons en place des mesures de sécurité appropriées pour protéger vos informations personnelles contre tout accès non autorisé, utilisation abusive ou divulgation. Cependant, veuillez noter qu'aucune méthode de transmission de données sur Internet ou de stockage électronique n'est totalement sécurisée.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Conservation des informations personnelles",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Nous conserverons vos informations personnelles aussi longtemps que nécessaire pour atteindre les objectifs énoncés dans la présente politique de confidentialité, à moins que la loi ne l'exige autrement.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Vos droits en matière de confidentialité des données",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Vous avez le droit d'accéder, de rectifier ou de supprimer vos informations personnelles que nous détenons. Si vous souhaitez exercer ces droits ou avez des questions concernant notre utilisation de vos informations personnelles, veuillez nous contacter à info@lkmdigital.ci.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Modifications de la politique de confidentialité",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Nous nous réservons le droit de modifier la présente politique de confidentialité à tout moment. Toute modification prendra effet dès sa publication sur l'application. Il est recommandé de consulter régulièrement la politique de confidentialité pour rester informé des mises à jour.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  "En utilisant notre application, vous acceptez les termes de la présente politique de confidentialité.",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListItem(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 10,
          child: Icon(
            Icons.circle,
            size: 10,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
