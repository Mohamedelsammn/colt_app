import 'package:colt_app/model/payment_card_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class PaymentCardService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // ---------------- ADD CARD ----------------
  Future<void> addCard({
    required String cardHolderName,
    required String cardNumber,
    required String cvv,
    required int expiryMonth,
    required int expiryYear,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await _supabase.from('payment_cards').insert({
      'user_id': user.id,
      'cardholder_name': cardHolderName,
      'card_number': cardNumber, // نخزن النص الكامل
      'cvv': cvv,
      'expiry_month': expiryMonth,
      'expiry_year': expiryYear,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  // ---------------- FETCH USER CARDS ----------------
  Future<List<PaymentCard>> fetchUserCards() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final data = await _supabase
        .from('payment_cards')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (data as List)
        .map((e) => PaymentCard.fromMap(e))
        .toList();
  }

  // ---------------- EDIT CARD ----------------
  Future<void> editCard({
    required String cardId,
    required String cardHolderName,
    required String cardNumber,
    required String cvv,
    required int expiryMonth,
    required int expiryYear,
  }) async {
    await _supabase.from('payment_cards').update({
      'cardholder_name': cardHolderName,
      'card_number': cardNumber,
      'cvv': cvv,
      'expiry_month': expiryMonth,
      'expiry_year': expiryYear,
    }).eq('id', cardId);
  }
}
