import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:residents_app/widgets/form_container_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:residents_app/widgets/toast.dart';

class CreateAnnouncementView extends StatefulWidget {
  const CreateAnnouncementView({super.key});

  @override
  State<CreateAnnouncementView> createState() => _CreateAnnouncementViewState();
}

class _CreateAnnouncementViewState extends State<CreateAnnouncementView> {
  bool _isLoading = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  void _createAnnouncement() async {
    User? user = FirebaseAuth.instance.currentUser;
    final docRef = db.collection("users").doc(user?.uid);
    final userInfo = await docRef.get();

    if (!userInfo.exists) {
      throw Exception("User document not found");
    }

    final usersAnnouncement = <String, dynamic>{
      "title": _titleController.text,
      "description": _descriptionController.text,
      "user": userInfo.data()
    };

    await db.collection("announcement").add(usersAnnouncement);

    _descriptionController.text = "";
    _titleController.text = "";
    setState(() {
      _isLoading = false;
    });

    showToast(message: "El anuncio se agrego correctamente");
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
    );
  }
}
