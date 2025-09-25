// Archivo: lib/drawer.dart
import 'package:flutter/material.dart';
import 'translations.dart';

class CustomDrawer extends StatelessWidget {
  final ValueNotifier<String> languageNotifier;
  final Widget logoWidget;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  const CustomDrawer({
    super.key,
    required this.languageNotifier,
    required this.logoWidget,
    required this.themeModeNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final menuTextStyle = TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.onSurface,
    );
    
    final logoPath = (logoWidget as Image).image as AssetImage;

    final drawerLogoWidget = Image(
      image: logoPath,
      height: 20, 
    );
    
    // Define el color de fondo del DrawerHeader según el modo del tema
    final isDarkMode = themeModeNotifier.value == ThemeMode.dark;
    final drawerHeaderColor = isDarkMode 
      ? Theme.of(context).primaryColor 
      : const Color(0xFFBEBEBE); // Usamos el color gris claro (#bebebe) aquí.

    return Drawer(
      child: ValueListenableBuilder<String>(
        valueListenable: languageNotifier,
        builder: (context, language, _) {
          final menuItems = appTranslations[language]!;
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: drawerHeaderColor,
                ),
                child: Center(child: drawerLogoWidget),
              ),
              _buildDrawerItem(context, menuItems['home'], menuTextStyle),
              _buildDrawerExpansionTile(context, menuItems['about_us'], [
                menuItems['our_mission'],
                menuItems['our_team'],
              ], menuTextStyle),
              _buildDrawerExpansionTile(context, menuItems['services'], [
                menuItems['service_1'],
                menuItems['service_2'],
                menuItems['service_3'],
              ], menuTextStyle),
              _buildDrawerExpansionTile(context, menuItems['research'], [
                menuItems['research_1'],
                menuItems['research_2'],
                menuItems['research_3'],
              ], menuTextStyle),
              _buildDrawerItem(context, menuItems['contact'], menuTextStyle),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, TextStyle style) {
    return ListTile(
      title: Text(title, style: style),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildDrawerExpansionTile(BuildContext context, String title, List<String> subItems, TextStyle style) {
    return ExpansionTile(
      title: Text(title, style: style),
      children: subItems.map((item) {
        return ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(item, style: style),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        );
      }).toList(),
    );
  }
}