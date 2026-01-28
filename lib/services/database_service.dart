import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream of marketplace items
  Stream<List<MarketplaceItem>> getItems() {
    return _db.collection('items').orderBy('createdAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => MarketplaceItem.fromFirestore(doc)).toList(),
        );
  }

  // Create a new listing
  Future<void> createItem(MarketplaceItem item) {
    return _db.collection('items').add(item.toFirestore());
  }

  // Get item by ID
  Future<MarketplaceItem?> getItem(String id) async {
    var doc = await _db.collection('items').doc(id).get();
    if (doc.exists) {
      return MarketplaceItem.fromFirestore(doc);
    }
    return null;
  }
}
