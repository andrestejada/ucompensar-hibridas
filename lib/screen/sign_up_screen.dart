import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:residents_app/widgets/form_container_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:residents_app/widgets/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isSigningUp = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController _emailController =
      TextEditingController();
  TextEditingController _passwordController =
      TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController =
      TextEditingController();
  TextEditingController _apartmentController =
      TextEditingController();
  TextEditingController _blockController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _createAccount() async {
    if (_nameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _apartmentController.text.isEmpty ||
        _blockController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      showToast(message: "Por favor completa todos los campos.");
      return;
    }

    setState(() {
      isSigningUp = true;
    });

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      final userId = credential.user?.uid;

      final userToCreate = <String, dynamic>{
        "name": _nameController.text,
        "lastName": _lastNameController.text,
        "apartment": _apartmentController.text,
        "block": _blockController.text,
        "email": _emailController.text
      };

      await db.collection("users").doc(userId).set(userToCreate);

      context.go('/proposals');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast(message: "Ese correo ya existe");
      }
    } catch (e) {
      showToast(message: "Error al registrar usuario.");
      print(e);
    } finally {
      setState(() {
        isSigningUp = false;
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
                "Crear Cuenta",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _nameController,
                hintText: "Nombre",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _lastNameController,
                hintText: "Apellido",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _apartmentController,
                hintText: "Apartamento",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _blockController,
                hintText: "Bloque/Torre",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: _createAccount,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: isSigningUp
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ya tienes cuenta?"),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go('/login');
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
