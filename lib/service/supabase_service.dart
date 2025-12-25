import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/order_item_model.dart';
import '../model/order_model.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  /// helper
  String _requireUserId() {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    return user.id;
  }

  /// ---------------- FAVORITES ----------------

  Future<List<int>> getFavoriteProductIds() async {
    final userId = _requireUserId();

    final response = await _client
        .from('favorites')
        .select('product_id')
        .eq('user_id', userId);

    return (response as List)
        .map((e) => e['product_id'] as int)
        .toList();
  }

  Future<void> toggleFavorite(int productId) async {
    final userId = _requireUserId();

    final exists = await _client
        .from('favorites')
        .select()
        .eq('user_id', userId)
        .eq('product_id', productId)
        .maybeSingle();

    if (exists != null) {
      await _client
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('product_id', productId);
    } else {
      await _client.from('favorites').insert({
        'user_id': userId,
        'product_id': productId,
      });
    }
  }

  /// ---------------- ORDERS ----------------

  Future<void> createOrder({
    required double totalPrice,
    required List<OrderItemModel> items,
  }) async {
    final userId = _requireUserId();

    final order = await _client
        .from('orders')
        .insert({
          'user_id': userId,
          'total_price': totalPrice,
        })
        .select()
        .single();

    final orderId = order['id'];

    final itemsJson =
        items.map((item) => item.toJson(orderId)).toList();

    await _client.from('order_items').insert(itemsJson);
  }

  Future<List<OrderModel>> getOrders() async {
    final userId = _requireUserId();

    final response = await _client
        .from('orders')
        .select('*, order_items(*)')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((e) => OrderModel.fromJson(e))
        .toList();
  }
}
