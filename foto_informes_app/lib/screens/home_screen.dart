import 'package:flutter/material.dart';
// Importaremos otras pantallas aquí cuando las creemos
// import 'add_photo_screen.dart';
// import 'search_screen.dart';
// import 'generate_report_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Widget reutilizable para el footer
  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Creado por Alejandro Goez Zambrano",
        style: TextStyle(fontSize: 10, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        // No mostramos botón de atrás en la pantalla principal
      ),
      body: Column( // Usamos Column para poner el footer abajo
        children: [
          Expanded( // Para que los botones ocupen el espacio disponible
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Botones anchos
                  children: <Widget>[
                    const Text(
                      'Foto Informes',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40), // Espacio vertical
                    ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Tomar/Agregar Foto'),
                      onPressed: () {
                        // TODO: Navegar a la pantalla AddPhotoScreen
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Funcionalidad pendiente')),
                        );
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => AddPhotoScreen()));
                      },
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.search),
                      label: const Text('Buscar Obligaciones y Actividades'),
                      onPressed: () {
                        // TODO: Navegar a la pantalla SearchScreen
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Funcionalidad pendiente')),
                        );
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                      },
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.file_download),
                      label: const Text('Generar Documento/Descargar'),
                      onPressed: () {
                        // TODO: Navegar a la pantalla GenerateReportScreen
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Funcionalidad pendiente')),
                        );
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => GenerateReportScreen()));
                      },
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildFooter(), // Añadir el footer al final
        ],
      ),
    );
  }
}