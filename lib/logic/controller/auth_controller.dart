import 'package:colt_app/model/payment_card_model.dart';
import 'package:colt_app/service/paymentCard_service.dart';
import 'package:colt_app/view/screens/auth/email_send_screen.dart';
import 'package:colt_app/view/screens/auth/signin_screen.dart';
import 'package:colt_app/view/screens/pages/bottomBar/main_screen.dart';
import 'package:colt_app/view/screens/pages/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final supabase = Supabase.instance.client;
  RxBool isloading = false.obs;

  RxBool isLoggedIn = false.obs;
  @override
  void onInit() {
    isLoggedIn.value = supabase.auth.currentUser != null;

    supabase.auth.onAuthStateChange.listen((data) {
      isLoggedIn.value = data.session != null;
      if (data.session != null) {
        fetchUserAddresses();
        loadCards();
      } else {
        addresses.clear();
      }
    });

    super.onInit();
  }

  // Sign in
  Future<void> signIn(String email, String password) async {
    try {
      isloading.value = true;

      final response = await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (response.session != null) {
        isLoggedIn.value = true;

        Get.offAll(MainScreen());
      }
    } on AuthApiException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isloading.value = false;
    }
  }

  // Sign up
  Future<void> signUp(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      isloading.value = true;

      final response = await supabase.auth.signUp(
        email: email.trim(),
        password: password.trim(),
        data: {'first_name': firstName, 'last_name': lastName},
      );

      if (response.user != null) {
        Get.snackbar('Success', '');
        Get.offAll(WelcomeScreen());
      }
    } on AuthApiException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isloading.value = false;
    }
  }

  User? get user => supabase.auth.currentUser;

  String get fullName {
    final data = user?.userMetadata;
    if (data == null) return '';
    return '${data['first_name'] ?? ''} ${data['last_name'] ?? ''}';
  }

  String get email => user?.email ?? '';

  //------------------------signout-----------------------------
  Future<void> signOut() async {
    isloading.value = true;
    await supabase.auth.signOut();
    isLoggedIn.value = false;
    addresses.clear(); // كويس
    Get.offAll(() => SigninScreen());
    isloading.value = false;
  }

  //------------------------signout-----------------------------

  Future<void> resetPassword(String email) async {
    try {
      isloading.value = true;
      await supabase.auth.resetPasswordForEmail(email.trim());
      Get.offAll(EmailSendScreen());
    } on AuthApiException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isloading.value = false;
    }
  }

  //-------------------address of user --------------------
  Future<void> addUserAddress({
    required String street,
    required String city,
    required String state,
  }) async {
    try {
      isloading.value = true;

      final user = supabase.auth.currentUser;
      if (user == null) return;

      await supabase.from('addresses').insert({
        'user_id': user.id,
        'street': street,
        'city': city,
        'state': state,
      });

      await fetchUserAddresses(); // refresh list
      Get.back();
      Get.snackbar('Success', 'Address added');
    } finally {
      isloading.value = false;
    }
  }

  RxList<Map<String, dynamic>> addresses = <Map<String, dynamic>>[].obs;
  RxBool isLoadingAddress = false.obs;

  Future<void> fetchUserAddresses() async {
    try {
      isLoadingAddress.value = true;

      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      final data = await supabase
          .from('addresses')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      addresses.assignAll(List<Map<String, dynamic>>.from(data));
    } catch (e) {
      addresses.clear();
    } finally {
      isLoadingAddress.value = false;
    }
  }

  Future<void> deleteAddress(String addressId) async {
    await supabase.from('addresses').delete().eq('id', addressId);
    fetchUserAddresses();
  }

  //-----------------------------------------

  Future<void> setDefaultAddress(String addressId) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;

    await supabase
        .from('addresses')
        .update({'is_default': false})
        .eq('user_id', userId);

    await supabase
        .from('addresses')
        .update({'is_default': true})
        .eq('id', addressId);

    await fetchUserAddresses();
  }

  Future<void> editAddress({
    required String addressId,
    required String street,
    required String city,
    required String state,
  }) async {
    await supabase
        .from('addresses')
        .update({'street': street, 'city': city, 'state': state})
        .eq('id', addressId);

    await fetchUserAddresses();
  }

  //---------------------payment methods-----------------------------

  final PaymentCardService _service = PaymentCardService();

  var cards = <PaymentCard>[].obs;
  var isLoading = false.obs;

  Future<void> loadCards() async {
    try {
      isLoading.value = true;
      cards.value = await _service.fetchUserCards();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addCard({
    required String name,
    required String number,
    required String cvv,
    required int month,
    required int year,
  }) async {
    await _service.addCard(
      cardHolderName: name,
      cardNumber: number,
      cvv: cvv,
      expiryMonth: month,
      expiryYear: year,
    );
    await loadCards();
  }

  Future<void> editCard({
    required String cardId,
    required String name,
    required String number,
    required String cvv,
    required int month,
    required int year,
  }) async {
    await _service.editCard(
      cardId: cardId,
      cardHolderName: name,
      cardNumber: number,
      cvv: cvv,
      expiryMonth: month,
      expiryYear: year,
    );
    await loadCards();
  }
}
