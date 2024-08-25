import 'package:flutter/material.dart';

class ProposalsView extends StatelessWidget {
  const ProposalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposals View'),
      ),
      body: const Center(
        child: Text('Proposals View'),
      ),
    );
  }
}
