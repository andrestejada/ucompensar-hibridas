import 'package:flutter/material.dart';
import 'package:residents_app/widgets/announcement_card.dart';
import 'package:go_router/go_router.dart';

class AnnouncementView extends StatelessWidget {
  const AnnouncementView({super.key});

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
                AnnouncementCard(
                    title: 'test',
                    description: 'test description',
                    imageUrl: 'https://elfrente.com.co/content/images/size/w1304/format/webp/2024/01/Receta-de-Lechona-Tolimense.webp'
                ),
                AnnouncementCard(
                    title: 'test',
                    description: 'test description',
                    imageUrl: 'https://elfrente.com.co/content/images/size/w1304/format/webp/2024/01/Receta-de-Lechona-Tolimense.webp'
                ),
                AnnouncementCard(
                    title: 'test',
                    description: 'test description',
                    imageUrl: 'https://elfrente.com.co/content/images/size/w1304/format/webp/2024/01/Receta-de-Lechona-Tolimense.webp'
                ),
                AnnouncementCard(
                    title: 'test',
                    description: 'test description',
                    imageUrl: 'https://elfrente.com.co/content/images/size/w1304/format/webp/2024/01/Receta-de-Lechona-Tolimense.webp'
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
