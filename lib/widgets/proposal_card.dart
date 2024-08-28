import 'package:flutter/material.dart';

class ProposalCard extends StatelessWidget {
  const ProposalCard({
    super.key,
  });

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
            const ListTile(
              title: Text(
                'Cambio de empresa de seguridad',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                  'La empresa que esta actualmente no esta cumpliendo con la reglas basicas'),
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
                            text: 'Andres Tejada',
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
                            text: '5',
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
                            text: '101',
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
