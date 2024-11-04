import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quickalert/quickalert.dart';
import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../models/user.dart';
import '../../widgets/event_pref.dart';
import '../../widgets/info_message.dart';
import '../../widgets/root.dart';
import '../first_page.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomsController = TextEditingController();
  final _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isPhone = false;
  bool isPassword = false;
  bool isPasswordConfirm = false;
  bool isNom = false;
  bool isPrenoms = false;
  bool isEmail = false;
  bool isEmailConfirm = false;
  bool isObscurityText = true;
  bool _isEmailValid = false;
  bool isLoading = false;

  void _onSubmit() {
    setState(() => isLoading = true);
    setState(() {
      isLoading = true;
    });

    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() {
        // isLoading = false;
        // checkFamilyCode();
        checkEmail();
      }),
    );
  }

  void checkFamilyCode() async {
    print('checkfamilly');
    try {
      var response = await http.post(
        Uri.parse(Api.checkFamilyCode),
        body: {
          // 'code_famille': _matriculeFamilleController.text,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        inspect(response.body);
        var responseBody = jsonDecode(response.body);
        if (responseBody['exist']) {
          checkEmail();
        } else {
          QuickAlert.show(
            context: context,
            title: 'Echec',
            type: QuickAlertType.warning,
            text: "Ce matricule famille n'est pas reconnu.",
            confirmBtnColor: Theme.of(context).buttonTheme.colorScheme!.primary,
          );

          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void login() async {
    try {
      var response = await http.post(
        Uri.parse(Api.login),
        body: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          InfoMessage.snackbar(Get.context!, 'Connecté(e)');
          User user = User.fromJson(responseBody['data']);
          await EventPref.saveUser(user);
          Get.offAll(() => const FirstPage());
          // Get.offAll(() => const Root());

          // });
        } else {
          setState(() {
            isLoading = false;
          });
        }
        print(responseBody['data']);
      } else {
        InfoMessage.snackbar(Get.context!, 'Echec de la connexion');
      }
    } catch (e) {
      print(e);
    }
  }

  void checkEmail() async {
    try {
      var response = await http.post(
        Uri.parse(Api.checkEmail),
        body: {
          'email': _emailController.text,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // inspect(response.body);
        var responseBody = jsonDecode(response.body);
        // print(responseBody);
        if (responseBody['exist']) {
          // ignore: use_build_context_synchronously
          QuickAlert.show(
            context: context,
            title: 'Echec',
            type: QuickAlertType.warning,
            text: "L'e-mail saisie existe déjà",
            confirmBtnColor: Theme.of(context).buttonTheme.colorScheme!.primary,
          );

          setState(() {
            isLoading = false;
          });
        } else {
          register();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void register() async {
    User user = User(
        1,
        _nomController.text,
        _prenomsController.text,
        _emailController.text,
        _phoneController.text,
        _passwordController.text,
        '0');
    try {
      // print(user.toJson());
      var response = await http.post(
        Uri.parse(Api.register),
        body: user.toJson(),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        if (responseBody['success']) {
          await EventPref.saveUser(user);

          // ignore: use_build_context_synchronously
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Inscription réussie !',
            confirmBtnText: 'Continuer',
            // ignore: use_build_context_synchronously
            confirmBtnColor: Theme.of(context).buttonTheme.colorScheme!.primary,
            onConfirmBtnTap: () {
              login();
            },
          );

          setState(() {
            isLoading = false;
          });
        } else {
          InfoMessage.snackbar(Get.context!, "Echec d'enregistrement");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  String? _verifierFormatMatricule(String? value) {
    if (value!.isEmpty) {
      return 'Veuillez saisir le matricule famille';
    }
    // if (!value.startsWith('FA_')) {
    //   return 'Le matricule doit commencer par "FA_".';
    // }
    if (value.length < 7) {
      return 'Le matricule famille inferieur à 7 caractères';
    }
    if (value.length > 7) {
      return 'Le matricule famille doit contenir 7 caractères';
    }

    // String nombrePartie = value.substring(3);
    // try {
    //   int.parse(nombrePartie); // Vérifie si la partie numérique est valide
    // } catch (e) {
    //   return 'La partie numérique du matricule est invalide.';
    // }
    return null;
  }

  void showModal(BuildContext context) {
    Color cTA = Theme.of(context).buttonTheme.colorScheme!.primary;
    Size size = MediaQuery.of(context).size;

    showModalBottomSheet(
      showDragHandle: true,
      enableDrag: false,
      isDismissible: false,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        bool isCheked = false;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Scaffold(
                floatingActionButton: Column(
                  children: [
                    Expanded(child: Container()), // Espace extensible
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isCheked) {
                              // Logique d'inscription
                              isLoading ? null : _onSubmit();
                            } else {
                              // Afficher une alerte ou un message indiquant que la case doit être cochée
                            }
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
                                Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .primary,
                              )),
                          child: isLoading
                              ? Center(
                                  child: Container(
                                    width: size.width * 0.06,
                                    height: size.height * 0.03,
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context)
                                          .buttonTheme
                                          .colorScheme!
                                          .onPrimary,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                )
                              : Text(
                                  "Je m'inscris",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context)
                                        .buttonTheme
                                        .colorScheme!
                                        .onPrimary,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: OutlinedButton(
                          onPressed: () {
                            Get.back();
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
                          ),
                          child: const Text(
                            "Annuler",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      Image(
                        image: const AssetImage("assets/images/logo.png"),
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Découvrez votre nouvelle application dédiée  aux paiements de frais de scolarité.",
                          textAlign: TextAlign.center,
                          style: Theme.of(this.context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        title: Text(
                          "Suivez les actualités de l'école et celles relatives à votre enfant.",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        title: Text(
                          "Réglez les frais de scolarité en toute simplicité.",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                          elevation: 8,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Forfait annuel',
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "9.900 F CFA / an",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Icon(
                                Icons.check_circle_outline_outlined,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            value: isCheked,
                            activeColor: cTA,
                            onChanged: (value) {
                              setState(() {
                                isCheked = value!;
                              });
                            },
                            title: Text(
                              "En cochant cette case, vous acceptez les conditions d'utilisation",
                              style:
                                  Theme.of(this.context).textTheme.titleSmall,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Couleurs.CouleurSecondaire,
        centerTitle: true,
        elevation: 0,
        bottomOpacity: 0,
        title: Text(
          "Inscription",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // height: 80,
                  TextFormField(
                    controller: _nomController,
                    //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))],
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Ex: KOUAKOU',
                      prefixIcon: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                          child: Icon(
                            Icons.person_add_alt,
                          )),
                      labelText: "Entrez votre nom",
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                          )),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                        // color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre nom';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextFormField(
                    controller: _prenomsController,
                    //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))],
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Ex: Albert',
                      prefixIcon: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                          child: Icon(
                            Icons.person_add_alt,
                          )),
                      labelText: "Entrez votre prénom",
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(style: BorderStyle.solid)),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                        // color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre prenom';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  IntlPhoneField(
                    initialCountryCode: 'CI',
                    // onChanged: (phone) {
                    //   _phoneController.text = phone.completeNumber;
                    //   setState(() {});
                    // },
                    controller: _phoneController,
                    decoration: InputDecoration(
                      // error: _phoneController.text == ""
                      //     ? const Text(
                      //         'Veuillez saisir le numéro de téléphone',
                      //         style: TextStyle(color: Colors.red),
                      //       )
                      //     : null,
                      filled: true,
                      hintText: 'Numéro de téléphone',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextFormField(
                    controller: _emailController,
                    onChanged: (text) {
                      setState(() {
                        _isEmailValid =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(text.trim());
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Ex: email@example.com',
                      prefixIcon: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                        child: Icon(
                          Icons.email_outlined,
                        ),
                      ),
                      labelText: "Email",
                      // fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          style: BorderStyle.none,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.redAccent,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Couleurs.CouleurSecondaire,
                          width: 1.0,
                        ),
                      ),
                      suffixIcon: _isEmailValid
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.error_outline,
                              color: Colors.redAccent,
                            ),
                    ),
                    validator: (value) {
                      if (!_isEmailValid) {
                        return 'Veuillez saisir une adresse e-mail valide';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: isObscurityText,
                    decoration: InputDecoration(
                      hintText: 'Ex: ******',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Icon(
                          Icons.lock,
                        ),
                      ),
                      suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscurityText = !isObscurityText;
                              });
                            },
                            icon: Visibility(
                              visible: isObscurityText,
                              replacement: const Icon(
                                Icons.visibility_off,
                              ),
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                              ),
                            ),
                          )),
                      labelText: "Entrez votre mot de passe",
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(style: BorderStyle.solid)),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir un mot de passe';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: isObscurityText,
                    //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))],
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      // hintText: 'Ex: *******',
                      prefixIcon: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                          child: Icon(
                            Icons.lock,
                          )),
                      suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isObscurityText = !isObscurityText;
                              });
                            },
                            icon: Visibility(
                              visible: isObscurityText,
                              replacement: const Icon(
                                Icons.visibility_off,
                              ),
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                              ),
                            ),
                          )),
                      labelText: "Confirmez le mot de passe",
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(style: BorderStyle.solid)),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez confirmer nouveau mot de passe';
                      } else if (value != _passwordController.text) {
                        return 'Les mots de passe ne correspondent pas';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  FilledButton(
                    onPressed: () {
                      // print(_phoneController.text);
                      if (_formKey.currentState!.validate() &&
                          _phoneController.text != "") {
                        // isLoading ? null : _onSubmit();
                        showModal(context);
                      }
                    },
                    style: ButtonStyle(
                      fixedSize: WidgetStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 55),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Continuer",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // FilledButton(
                  //   onPressed: () {
                  //     // print(_phoneController.text);
                  //     if (_formKey.currentState!.validate() &&
                  //         _phoneController.text != "") {
                  //       isLoading ? null : _onSubmit();
                  //     }
                  //   },
                  //   style: ButtonStyle(
                  //     fixedSize: WidgetStateProperty.all(
                  //       Size(MediaQuery.of(context).size.width, 55),
                  //     ),
                  //     shape: WidgetStateProperty.all(
                  //       RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //     ),
                  //   ),
                  //   child: isLoading
                  //       ? Center(
                  //           child: Container(
                  //             width: size.width * 0.06,
                  //             height: size.height * 0.03,
                  //             padding: const EdgeInsets.all(2.0),
                  //             child: CircularProgressIndicator(
                  //               color: Theme.of(context)
                  //                   .buttonTheme
                  //                   .colorScheme!
                  //                   .onPrimary,
                  //               strokeWidth: 3,
                  //             ),
                  //           ),
                  //         )
                  //       : const Text(
                  //           "S'inscrire",
                  //           style: TextStyle(
                  //             fontSize: 18,
                  //           ),
                  //         ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
