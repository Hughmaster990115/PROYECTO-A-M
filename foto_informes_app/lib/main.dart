import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Importaremos la pantalla principal (la crearemos después)

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foto Informes App',
      // --- Tema Oscuro ---
      themeMode: ThemeMode.dark, // Forzar tema oscuro
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal, // Puedes cambiar el color primario
        // Puedes personalizar más aspectos del tema oscuro aquí
        // por ejemplo, color de fondo del scaffold:
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850], // Color de la barra de navegación
        ),
        // Otros colores, fuentes, etc.
      ),
      // --- Fin Tema Oscuro ---
      home: const HomeScreen(), // La primera pantalla que se mostrará
      debugShowCheckedModeBanner: false, // Oculta la cinta de "Debug"
    );
  }
}