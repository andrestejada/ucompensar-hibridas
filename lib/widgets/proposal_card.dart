import 'package:flutter/material.dart';

class ProposalCard extends StatelessWidget {
  final String title;
  final String description;
  final String name;
  final String lastName;
  final String block;
  final String apartment;
  const ProposalCard(
      {super.key,
      required this.title,
      required this.description,
      required this.name,
      required this.lastName,
      required this.block,
      required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment
              .start, // Asegura que los hijos estén alineados a la izquierda
          children: [
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(description),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Nombre: ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '$name $lastName',
                            style: TextStyle(
                              fontSize:
                                  16, // Tamaño de fuente normal para el resto del texto
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Torre: ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: block,
                            style: TextStyle(
                              fontSize:
                                  16, // Tamaño de fuente normal para el resto del texto
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Apartamento: ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: apartment,
                            style: TextStyle(
                              fontSize:
                                  16, // Tamaño de fuente normal para el resto del texto
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite,
                    size: 30,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
