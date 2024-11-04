import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/c_user.dart';
import '../views/history/historique_paiement.dart';

class BottomNavigate extends StatefulWidget {
  const BottomNavigate({super.key});

  @override
  State<BottomNavigate> createState() => _BottomNavigateState();
}

class _BottomNavigateState extends State<BottomNavigate> {
  final CUser _cUser = Get.put(CUser());

  int _selectedIndex = 0;

  Future<void> _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        Get.to(() => (const Historique()));

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CUser(),
        initState: (state) {
          _cUser.getUser();
        },
        builder: (controller) {
          return BottomNavigationBar(
            // backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.house,
                  size: 20,
                ),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(
                  FontAwesomeIcons.arrowRightArrowLeft,
                  size: 20,
                ),
                label: "Transactions",
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).buttonTheme.colorScheme!.primary,
            onTap: _onItemTapped,
          );
        });
  }
}
