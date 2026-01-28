import 'package:cloud_firestore/cloud_firestore.dart';

class MarketplaceItem {
  final String id;
  final String ownerId;
  final String name;
  final String category;
  final String description;
  final double price;
  final String duration; // day, week, month, flat
  final List<String> imageUrls;
  final String location;
  final String type; // lend, sell
  final DateTime createdAt;

  MarketplaceItem({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.duration,
    required this.imageUrls,
    required this.location,
    required this.type,
    required this.createdAt,
  });

  factory MarketplaceItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return MarketplaceItem(
      id: doc.id,
      ownerId: data['ownerId'] ?? '',
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      duration: data['duration'] ?? 'day',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      location: data['location'] ?? '',
      type: data['type'] ?? 'lend',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'ownerId': ownerId,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'duration': duration,
      'imageUrls': imageUrls,
      'location': location,
      'type': type,
      'createdAt': createdAt,
    };
  }
}
