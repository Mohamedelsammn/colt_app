import 'package:colt_app/model/category_model.dart';
import 'package:colt_app/model/products_model.dart';
import 'package:colt_app/service/category_service.dart';
import 'package:colt_app/service/products_service.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final ProductsService _productsService = ProductsService();
  final CategoriesService _categoriesService = CategoriesService();

  /// Loading states
  var isProductsLoading = false.obs;
  var isCategoriesLoading = false.obs;

  /// Data
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var categories = <Categories>[].obs;

  /// Selected category slug
  var selectedCategorySlug = ''.obs;

  /// Favorite products
  var favoriteProductIds = <int>[].obs;
  var categoriesWithProducts = <Categories>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
    _initData();
  }

  /// Initialize data
  Future<void> _initData() async {
    await fetchCategories();
    await fetchProducts();
    mapCategoriesWithProducts();
  }

  /// Toggle favorite
  void toggleFavorite(int productId) {
    if (favoriteProductIds.contains(productId)) {
      favoriteProductIds.remove(productId);
    } else {
      favoriteProductIds.add(productId);
    }
  }

  bool isFavorite(int productId) => favoriteProductIds.contains(productId);

  /// Fetch products from API
  Future<void> fetchProducts() async {
    try {
      isProductsLoading(true);
      final result = await _productsService.fetchProducts();
      products.assignAll(result);

      // Apply filter if a category is selected
      if (selectedCategorySlug.value.isNotEmpty) {
        filteredProducts.assignAll(
          products.where((p) => p.category == selectedCategorySlug.value),
        );
      } else {
        filteredProducts.assignAll(products);
      }
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isProductsLoading(false);
    }
  }

  void mapCategoriesWithProducts() {
    categoriesWithProducts.assignAll(
      categories.where((category) {
        return products.any((product) => product.category == category.slug);
      }).toList(),
    );
  }

  /// Fetch categories from API
  Future<void> fetchCategories() async {
    try {
      isCategoriesLoading(true);
      final result = await _categoriesService.fetchCategories();
      categories.assignAll(result);

      // Select first category by default
      if (result.isNotEmpty) {
        selectedCategorySlug.value = result.first.slug;
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isCategoriesLoading(false);
    }
  }

  /// Filter products by category
  void filterByCategory(Categories category) {
    selectedCategorySlug.value = category.slug;
    searchProducts(searchQuery.value);
  }

  /// Clear category filter
  void clearFilter() {
    selectedCategorySlug.value = '';
    searchProducts(searchQuery.value);
  }

  //---------------Search--------------------------

  /// في ProductsController
  var searchQuery = ''.obs;

  /// دالة البحث
  void searchProducts(String query) {
    searchQuery.value = query.toLowerCase();

    if (query.isEmpty) {
      // لو مفيش بحث، خلي الفلترة على الكاتيجوري الحالية
      if (selectedCategorySlug.value.isNotEmpty) {
        filteredProducts.assignAll(
          products.where((p) => p.category == selectedCategorySlug.value),
        );
      } else {
        filteredProducts.assignAll(products);
      }
    } else {
      // البحث على كل المنتجات بغض النظر عن الكاتيجوري
      filteredProducts.assignAll(
        products.where(
          (p) => p.title.toLowerCase().contains(searchQuery.value),
        ),
      );
    }
  }
}
