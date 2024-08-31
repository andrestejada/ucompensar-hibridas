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
  TextEditingController _titleController =
      TextEditingController(text: "cambio de jardinero");
  TextEditingController _descriptionController =
      TextEditingController(text: "se duerme cortando el pasto");

  void _createProposal() async {
    setState(() {
      _isLoading = true;
    });

    //validate fields

    User? user = FirebaseAuth.instance.currentUser;
    final docRef = db.collection("users").doc(user?.uid);
    final userInfo = await docRef.get();

    if (!userInfo.exists) {
      throw Exception("User document not found");
    }
    final usersProposal = <String, dynamic>{
      "title": _titleController.text,
      "description": _titleController.text,
      "user": userInfo.data()
    };

    await db.collection("proposals").add(usersProposal);

    setState(() {
      _isLoading = false;
    });

    showToast(message: "La Propuesta se agrego correctamente");
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
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _titleController,
                hintText: "Titulo",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _descriptionController,
                hintText: "Descripción",
                isTextArea: true,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _createProposal,
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
