import 'package:flutter/material.dart';
import 'package:residents_app/widgets/proposal_card.dart';

class ProposalsView extends StatelessWidget {
  const ProposalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Proposals View'),
        ),
        body: SingleChildScrollView(
          child: Column(
            
            children: [
              ProposalCard(),
              ProposalCard(),
              ProposalCard(),
              ProposalCard(),
              ProposalCard(),
              ProposalCard(),
              ProposalCard(),
            ],
          ),
        ));
  }
}
