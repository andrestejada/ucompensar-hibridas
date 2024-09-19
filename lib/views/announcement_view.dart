import 'package:flutter/material.dart';
import 'package:residents_app/widgets/announcement_card.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

class AnnouncementView extends StatelessWidget {
  const AnnouncementView({super.key});

  Stream<QuerySnapshot> getAnnouncementsStream() {
    return FirebaseFirestore.instance.collection('announcement').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Anuncios',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
          maxLines: 2,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    context.go('/create-announcement');
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Crear",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // StreamBuilder para cargar los anuncios
                StreamBuilder<QuerySnapshot>(
                  stream: getAnnouncementsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text("Error al cargar anuncios");
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text("No hay anuncios disponibles");
                    }

                    final announcements = snapshot.data!.docs;

                    return Column(
                      children: announcements.map((doc) {
                        final title = doc['title'] ?? 'Sin título';
                        final description =
                            doc['description'] ?? 'Sin descripción';
                        final imageUrl = doc['imageUrl'] as String?;

                        return AnnouncementCard(
                          title: title,
                          description: description,
                          imageUrl: imageUrl, 
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
