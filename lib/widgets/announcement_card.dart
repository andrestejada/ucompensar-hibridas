import 'package:flutter/material.dart';

class AnnouncementCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl; 

  const AnnouncementCard({
    Key? key,
    required this.title,
    required this.description,
    this.imageUrl, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth, 
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null) 
                SizedBox(
                  width: double.infinity, 
                  height: 200, 
                  child: Image.network(
                    imageUrl!,
                    fit: BoxFit.cover, 
                  ),
                ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(description),
            ],
          ),
        ),
      ),
    );
  }
}
