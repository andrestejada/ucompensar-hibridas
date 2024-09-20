import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:residents_app/widgets/form_container_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:residents_app/widgets/toast.dart';

class CreateProposalView extends StatefulWidget {
  const CreateProposalView({super.key});

  @override
  State<CreateProposalView> createState() => _CreateProposalViewState();
}

class _CreateProposalViewState extends State<CreateProposalView> {
  bool _isLoading = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  // Método para validar campos y crear propuesta
  void _createProposal() async {
    // Verifica si los campos están vacíos
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      showToast(message: "Todos los campos son obligatorios");  // Mostrar toast si hay campos vacíos
      return;  // Detener ejecución si hay campos vacíos
    }

    setState(() {
      _isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      final docRef = db.collection("users").doc(user?.uid);
      final userInfo = await docRef.get();

      if (!userInfo.exists) {
        throw Exception("User document not found");
      }

      // Crear objeto con la propuesta
      final usersProposal = <String, dynamic>{
        "title": _titleController.text,
        "description": _descriptionController.text,
        "likes": 0,
        "likedBy": [],
        "user": userInfo.data(),
      };

      // Guardar propuesta en Firestore
      await db.collection("proposals").add(usersProposal);

      // Limpiar los campos del formulario
      _descriptionController.text = "";
      _titleController.text = "";

      showToast(message: "La propuesta se agregó correctamente");
      context.go('/proposals');
    } catch (e) {
      showToast(message: "Error al crear la propuesta: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Crear Propuesta",
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
              SizedBox(height: 30),
              GestureDetector(
                onTap: _createProposal,  // Llamar al método de crear propuesta
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
    );
  }
}
