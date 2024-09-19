import 'package:flutter/material.dart';
import 'package:residents_app/widgets/proposal_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:residents_app/widgets/toast.dart';
import 'package:go_router/go_router.dart';

class ProposalsView extends StatelessWidget {
  ProposalsView({super.key});

  FirebaseFirestore db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser; // Usuario autenticado

  void _toggleLike(DocumentSnapshot doc) async {
    if (user == null) return; // Asegúrate de que el usuario esté autenticado

    final String userId = user!.uid;
    final List<dynamic> likedBy = doc['likedBy'] ?? [];

    if (likedBy.contains(userId)) {
      // Si el usuario ya ha dado like, quita el like
      final int currentLikes = doc['likes'] ?? 0;
      await db.collection('proposals').doc(doc.id).update({
        'likes': currentLikes - 1,
        'likedBy':
            FieldValue.arrayRemove([userId]), // Quita el usuario de la lista
      });
    } else {
      // Si el usuario no ha dado like, añade el like
      final int currentLikes = doc['likes'] ?? 0;
      await db.collection('proposals').doc(doc.id).update({
        'likes': currentLikes + 1,
        'likedBy':
            FieldValue.arrayUnion([userId]), // Añade el usuario a la lista
      });
    }
  }

  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: const Text(
          'Listado De Propuestas',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: db.collection('proposals').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No proposals found.'));
          }

          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.docs.map((doc) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    ProposalCard(
                      title: doc['title'],
                      description: doc['description'],
                      name: doc['user']['name'],
                      lastName: doc['user']['lastName'],
                      apartment: doc['user']['apartment'],
                      block: doc['user']['block'],
                      likes: doc['likes'] ?? 0,
                      onLike: () => _toggleLike(doc),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
