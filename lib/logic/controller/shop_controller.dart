import 'package:colt_app/logic/controller/auth_controller.dart';
import 'package:colt_app/model/cart_model.dart';
import 'package:colt_app/model/order_item_model.dart';
import 'package:colt_app/model/order_model.dart';
import 'package:colt_app/service/supabase_service.dart';
import 'package:colt_app/view/screens/pages/bottomBar/cart/order_paced_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';

class ShopController extends GetxController {
  final SupabaseService _service = SupabaseService();

  final favoriteProductIds = <int>{}.obs;
  final orders = <OrderModel>[].obs;

  final Rx<String> size = "S".obs;
  final Rx<Color> color = const Color(0xFFFF9800).obs;
  final RxInt quantity = 1.obs;

  var cartItems = <CartItem>[].obs;
  @override
  void onInit() {
    super.onInit();

    final auth = Get.find<AuthController>();

    if (auth.isLoggedIn.value) {
      loadCartFromLocal();
      loadFavorites();
      getOrders();
    }

    ever(auth.isLoggedIn, (bool loggedIn) async {
      if (loggedIn) {
        await loadFavorites();
        await getOrders();
      } else {
        favoriteProductIds.clear();
        orders.clear();
        cartItems.clear();
      }
    });
  }

  // ---------------- FAVORITES ----------------
  Future<void> loadFavorites() async {
    final ids = await _service.getFavoriteProductIds();
    favoriteProductIds.assignAll(ids);
  }

  Future<void> toggleFavorite(int productId) async {
    if (Supabase.instance.client.auth.currentUser == null) {
      Get.snackbar('Login required', 'Please login first');
      return;
    }

    await _service.toggleFavorite(productId);

    favoriteProductIds.contains(productId)
        ? favoriteProductIds.remove(productId)
        : favoriteProductIds.add(productId);
  }

  bool isFavorite(int productId) => favoriteProductIds.contains(productId);

  // ---------------- CART ----------------
  void addToCart(CartItem item) {
    final index = cartItems.indexWhere(
      (i) =>
          i.productId == item.productId &&
          i.size == item.size &&
          i.color == item.color,
    );

    if (index >= 0) {
      cartItems[index].quantity += item.quantity;
      cartItems.refresh();
    } else {
      cartItems.add(item);
    }
    saveCartToLocal();
  }

  void clearCart() {
    cartItems.clear();
    saveCartToLocal();
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  Future<void> saveCartToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> cartJson = cartItems
        .map((item) => jsonEncode(item.toJson()))
        .toList();
    await prefs.setStringList('cart_items', cartJson);
  }

  Future<void> loadCartFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? cartJson = prefs.getStringList('cart_items');
    if (cartJson != null) {
      cartItems.value = cartJson
          .map((item) => CartItem.fromJson(jsonDecode(item)))
          .toList();
    }
  }

  // ---------------- CREATE ORDER (FROM CART) ----------------
  Future<void> createOrderFromCart() async {
    if (Supabase.instance.client.auth.currentUser == null) {
      Get.snackbar('Login required', 'Please login first');
      return;
    }

    if (cartItems.isEmpty) return;

    final items = cartItems.map((item) {
      return OrderItemModel(
        productId: item.productId,
        title: item.title,
        price: item.price,
        color: item.color, // String
        size: item.size,
        quantity: item.quantity,
      );
    }).toList();

    await _service.createOrder(totalPrice: totalPrice, items: items);

    clearCart();
    await getOrders();
    Get.offAll(OrderPacedScreen());
  }

  // ---------------- ORDERS ----------------
  var isLoadingOrders = true.obs;
  Future<void> getOrders() async {
    isLoadingOrders.value = true;

    try {
      orders.value = await _service.getOrders();
    } catch (e) {
      orders.clear();
    } finally {
      isLoadingOrders.value = false;
    }
  }

  void resetSelection() {
    size.value = "S";
    color.value = const Color(0xFFFF9800);
    quantity.value = 1;
  }

  //-------------------Search---------------------

  final RxString searchQuery = ''.obs;
  final filteredOrders = <OrderModel>[].obs;

  void searchOrders(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      filteredOrders.value = orders;
      return;
    }

    filteredOrders.value = orders.where((order) {
      final orderId = order.id.toString().toLowerCase();
      final itemsText = order.items.map((e) => e.title.toLowerCase()).join(' ');

      return orderId.contains(query.toLowerCase()) ||
          itemsText.contains(query.toLowerCase());
    }).toList();
  }
}
