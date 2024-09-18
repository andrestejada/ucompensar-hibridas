import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl; // Nueva propiedad para la URL de la imagen

  const AnnouncementCard({
    super.key,
    required this.title,
    
    required this.description,
    required this.imageUrl, // Nueva propiedad requerida
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 10),
            // Imagen cargada desde la URL
            Image.network(
              imageUrl,
              fit: BoxFit.cover, // Ajusta la imagen al espacio disponible
              errorBuilder: (context, error, stackTrace) {
                return Text('No se pudo cargar la imagen'); // Mensaje de error si no se puede cargar
              },
            ),
          ],
        ),
      ),
    );
  }
}
