import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Firebase Storage
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Image Picker
import 'dart:io';
import 'package:residents_app/widgets/form_container_widget.dart';
import 'package:residents_app/widgets/toast.dart';

class CreateAnnouncementView extends StatefulWidget {
  const CreateAnnouncementView({super.key});

  @override
  State<CreateAnnouncementView> createState() => _CreateAnnouncementViewState();
}

class _CreateAnnouncementViewState extends State<CreateAnnouncementView> {
  bool _isLoading = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance; // Firebase Storage

  File? _imageFile; // Variable para la imagen capturada
  final picker = ImagePicker();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  // Método para seleccionar una imagen desde la cámara
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Método para subir la imagen a Firebase Storage y obtener la URL
  Future<String?> _uploadImage(File image) async {
    try {
      // Generar una referencia única para la imagen en Firebase Storage
      final storageRef = storage.ref().child('announcements/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await storageRef.putFile(image);

      // Obtener la URL de la imagen subida
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print('Error al subir la imagen: $e');
      return null;
    }
  }

  void _createAnnouncement() async {
    setState(() {
      _isLoading = true;
    });

    User? user = FirebaseAuth.instance.currentUser;
    final docRef = db.collection("users").doc(user?.uid);
    final userInfo = await docRef.get();

    if (!userInfo.exists) {
      setState(() {
        _isLoading = false;
      });
      throw Exception("User document not found");
    }

    // Si hay imagen seleccionada, sube la imagen primero
    String? imageUrl;
    if (_imageFile != null) {
      imageUrl = await _uploadImage(_imageFile!);
    }

    final usersAnnouncement = <String, dynamic>{
      "title": _titleController.text,
      "description": _descriptionController.text,
      "user": userInfo.data(),
      "imageUrl": imageUrl, // Añadir la URL de la imagen (si existe)
    };

    await db.collection("announcement").add(usersAnnouncement);

    // Limpiar los campos y restablecer el estado
    _descriptionController.text = "";
    _titleController.text = "";
    setState(() {
      _isLoading = false;
      _imageFile = null; 
    });

    showToast(message: "El anuncio se agregó correctamente");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Crear Anuncio",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                FormContainerWidget(
                  controller: _titleController,
                  hintText: "Título",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa un título';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                FormContainerWidget(
                  controller: _descriptionController,
                  hintText: "Descripción",
                  isTextArea: true,
                ),
                SizedBox(height: 20),
                _imageFile != null
                    ? Image.file(_imageFile!, height: 150) 
                    : Container(),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage, 
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Abrir Cámara",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _createAnnouncement,
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Crear",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
