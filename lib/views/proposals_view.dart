import 'package:flutter/material.dart';
import 'package:residents_app/widgets/proposal_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProposalsView extends StatelessWidget {
  ProposalsView({super.key});

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposals View'),
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
                return ProposalCard(
                  title: doc['title'],
                  description: doc['description'],
                  name: doc['user']['name'],
                  lastName: doc['user']['lastName'],
                  apartment: doc['user']['apartment'],
                  block: doc['user']['block'],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
