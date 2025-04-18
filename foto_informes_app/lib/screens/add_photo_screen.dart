import 'package:flutter/material.dart';
import 'dart:io'; // Necesario para manejar File
import 'package:image_picker/image_picker.dart'; // Para cámara y galería
import 'package:permission_handler/permission_handler.dart'; // Para solicitar permisos

class AddPhotoScreen extends StatefulWidget {
  const AddPhotoScreen({super.key});

  @override
  State<AddPhotoScreen> createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  File? _selectedImage; // Guarda la imagen seleccionada/tomada
  final ImagePicker _picker = ImagePicker(); // Instancia de ImagePicker

  // --- Helper para mostrar mensajes ---
  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return; // Verifica si el widget está todavía en el árbol
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  // --- Función para solicitar un permiso específico ---
  Future<bool> _requestPermission(Permission permission) async {
    var status = await permission.status;
    if (status.isGranted) {
      return true; // Permiso ya concedido
    } else {
      var result = await permission.request();
      if (result.isGranted) {
        return true; // Permiso concedido ahora
      } else {
        // El usuario negó el permiso
        _showSnackBar(
            'Permiso de ${permission.toString().split('.').last} denegado. No se puede continuar.',
            isError: true);
        // Opcional: abrir ajustes de la app si el permiso fue denegado permanentemente
        if (result.isPermanentlyDenied) {
            // Considera mostrar un diálogo que lleve a los ajustes
             print("Permiso denegado permanentemente para ${permission.toString()}");
            // openAppSettings(); // Función de permission_handler
        }
        return false;
      }
    }
  }

  // --- Función para tomar foto ---
  Future<void> _takePicture() async {
    // 1. Solicitar permiso de cámara
    bool cameraPermissionGranted = await _requestPermission(Permission.camera);
    if (!cameraPermissionGranted) return; // Salir si no hay permiso

    // 2. Usar image_picker para tomar la foto
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        // Opcional: ajustar calidad, tamaño máximo, etc.
        // imageQuality: 85,
        // maxWidth: 1080,
        // maxHeight: 1920,
      );

      // 3. Actualizar la imagen seleccionada si se tomó una
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path); // Convierte XFile a File
        });
        _showSnackBar('Foto tomada correctamente.');
      } else {
        _showSnackBar('No se tomó ninguna foto.', isError: true);
      }
    } catch (e) {
      print("Error al tomar foto: $e");
      _showSnackBar('Error al acceder a la cámara: ${e.toString()}', isError: true);
    }
  }

  // --- Función para seleccionar desde galería ---
  Future<void> _pickImageFromGallery() async {
    // 1. Solicitar permiso (Storage en Android <= 12, Photos en Android >= 13 y iOS)
    // Permission_handler gestiona esto internamente al pedir Permission.photos
     bool photosPermissionGranted = await _requestPermission(Permission.photos);
     // Si falla photos, podrías intentar con storage como fallback en Android viejo,
     // pero photos es lo recomendado ahora.
    if (!photosPermissionGranted) return; // Salir si no hay permiso

    // 2. Usar image_picker para seleccionar de la galería
    try {
       final XFile? pickedFile = await _picker.pickImage(
         source: ImageSource.gallery,
         // imageQuality: 85, // También puedes ajustar calidad aquí
       );

       // 3. Actualizar la imagen seleccionada si se eligió una
       if (pickedFile != null) {
         setState(() {
           _selectedImage = File(pickedFile.path);
         });
         _showSnackBar('Imagen seleccionada de la galería.');
       } else {
         _showSnackBar('No se seleccionó ninguna imagen.', isError: true);
       }
    } catch (e) {
      print("Error al seleccionar de galería: $e");
      _showSnackBar('Error al acceder a la galería: ${e.toString()}', isError: true);
    }
  }

  // --- Lógica pendiente para Obligaciones y Actividades ---
   void _selectObligation() {
     print("Acción: Seleccionar Obligación");
     _showSnackBar('Funcionalidad (Obligación) pendiente', isError: true);
   }

   void _selectActivity() {
     print("Acción: Seleccionar Actividad");
      _showSnackBar('Funcionalidad (Actividad) pendiente', isError: true);
   }

   void _savePhoto() {
      // Primero verificar si hay imagen seleccionada y categorías elegidas
      if (_selectedImage == null) {
         _showSnackBar('Por favor, toma o selecciona una foto primero.', isError: true);
         return;
      }
      // TODO: Verificar si se seleccionó Obligación y Actividad
      print("Acción: Guardar Foto");
      _showSnackBar('Funcionalidad (Guardar) pendiente', isError: true);
      // TODO: Implementar guardado de archivo y datos
   }

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
        title: const Text('Agregar Foto'),
        leading: IconButton( // Añadimos explícitamente el botón de regreso
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Sección para mostrar la imagen ---
                  Container(
                    height: 250, // Un poco más de altura para la preview
                    decoration: BoxDecoration(
                       color: Colors.grey[850], // Un gris un poco más oscuro
                       border: Border.all(color: Colors.grey[700]!),
                       borderRadius: BorderRadius.circular(8), // Bordes redondeados
                    ),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 20), // Margen inferior
                    child: _selectedImage == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined, size: 60, color: Colors.grey),
                              SizedBox(height: 8),
                              Text(
                                'Vista previa de la foto',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        : ClipRRect( // Para aplicar bordes redondeados a la imagen
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover, // Cubrir el área
                              width: double.infinity, // Ocupar todo el ancho
                              height: 250, // Misma altura que el contenedor
                            ),
                          ),
                  ),

                  // --- Botones para obtener la imagen ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Tomar Foto'),
                        onPressed: _takePicture,
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.photo_library),
                        label: const Text('Galería'),
                        onPressed: _pickImageFromGallery,
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Divider(), // Separador visual
                  const SizedBox(height: 20),


                  // --- Sección para Obligación Contractual ---
                   const Text('Obligación Contractual:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 8),
                   // TODO: Reemplazar este Placeholder con la lógica real
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey),
                       borderRadius: BorderRadius.circular(4),
                     ),
                     child: const Text('Ninguna seleccionada (Pendiente)', style: TextStyle(color: Colors.grey)),
                   ),
                   const SizedBox(height: 8),
                   ElevatedButton(
                     onPressed: _selectObligation,
                     child: const Text('Seleccionar / Crear Obligación'),
                   ),
                   const SizedBox(height: 25),


                  // --- Sección para Actividad ---
                  const Text('Actividad:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 8),
                   // TODO: Reemplazar este Placeholder
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                     decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey),
                       borderRadius: BorderRadius.circular(4),
                     ),
                     child: const Text('Ninguna seleccionada (Pendiente)', style: TextStyle(color: Colors.grey)),
                   ),
                  const SizedBox(height: 8),
                   ElevatedButton(
                     // TODO: Deshabilitar este botón si no hay obligación seleccionada
                     onPressed: _selectActivity,
                     child: const Text('Seleccionar / Crear Actividad'),
                   ),
                  const SizedBox(height: 40), // Más espacio antes de guardar

                  // --- Botón para Guardar ---
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar Foto y Datos'),
                    onPressed: _savePhoto, // Llama a la función _savePhoto
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.teal, // Color distintivo para guardar
                      foregroundColor: Colors.white, // Texto blanco
                      textStyle: const TextStyle(fontSize: 16)
                    ),
                  ),
                   const SizedBox(height: 20), // Espacio antes del footer
                ],
              ),
            ),
          ),
          _buildFooter(), // El footer al final
        ],
      ),
    );
  }
}