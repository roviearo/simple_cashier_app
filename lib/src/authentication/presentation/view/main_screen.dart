import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_cashier_app/core/utils/router.dart';
import 'package:simple_cashier_app/src/authentication/presentation/authentication/authentication_bloc.dart';
import 'package:simple_cashier_app/src/authentication/presentation/widget/nav_model.dart';
import 'package:simple_cashier_app/src/category/presentation/view/category_screen.dart';
import 'package:simple_cashier_app/src/home/presentation/view/home_screen.dart';
import 'package:simple_cashier_app/src/menu/presentation/view/menu_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final menuNavKey = GlobalKey<NavigatorState>();
  final categoryNavKey = GlobalKey<NavigatorState>();

  late int _selectedIndex;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    items = [
      NavModel(page: const HomeScreen(), navKey: homeNavKey),
      NavModel(page: const MenuScreen(), navKey: menuNavKey),
      NavModel(page: const CategoryScreen(), navKey: categoryNavKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerButton(),
        title: const Text('Simple Cashier App'),
      ),
      drawer: SafeArea(
          child: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text('Simple Cahier Appp'),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                selected: _selectedIndex == 0,
                selectedTileColor: Theme.of(context).colorScheme.primary,
                leading: SvgPicture.asset(
                  'icons/${_selectedIndex == 0 ? 'home' : 'home_outline'}.svg',
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 0
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSecondaryContainer,
                    BlendMode.srcIn,
                  ),
                ),
                title: Text(
                  'Beranda',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _selectedIndex == 0
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                onTap: () {
                  if (_selectedIndex != 0) {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                selected: _selectedIndex == 1,
                selectedTileColor: Theme.of(context).colorScheme.primary,
                leading: SvgPicture.asset(
                  'icons/${_selectedIndex == 1 ? 'menu' : 'menu_outline'}.svg',
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 1
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSecondaryContainer,
                    BlendMode.srcIn,
                  ),
                ),
                title: Text(
                  'Menu',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _selectedIndex == 1
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                onTap: () {
                  if (_selectedIndex != 1) {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                selected: _selectedIndex == 2,
                selectedTileColor: Theme.of(context).colorScheme.primary,
                leading: SvgPicture.asset(
                  'icons/${_selectedIndex == 2 ? 'category' : 'category_outline'}.svg',
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 2
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSecondaryContainer,
                    BlendMode.srcIn,
                  ),
                ),
                title: Text(
                  'Kategori',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: _selectedIndex == 2
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSecondaryContainer),
                ),
                onTap: () {
                  if (_selectedIndex != 2) {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  }
                  Navigator.pop(context);
                },
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                selected: false,
                selectedTileColor: Theme.of(context).colorScheme.primary,
                leading: SvgPicture.asset(
                  'icons/logout.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.error,
                    BlendMode.srcIn,
                  ),
                ),
                title: Text(
                  'Keluar',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.error),
                ),
                onTap: () {
                  context.read<AuthenticationBloc>().add(const SignOutEvent());
                  router.goNamed('login');
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      )),
      body: IndexedStack(
        index: _selectedIndex,
        children: items
            .map((page) => Navigator(
                  key: page.navKey,
                  onGenerateInitialRoutes: (navigator, initialRoute) {
                    return [MaterialPageRoute(builder: (context) => page.page)];
                  },
                ))
            .toList(),
      ),
    );
  }
}
