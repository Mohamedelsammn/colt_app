// category_model.dart

const Map<String, String> categoryNetworkImages = {
  "beauty": "https://images.pexels.com/photos/774866/pexels-photo-774866.jpeg",
  "fragrances":
      "https://cdn.sanity.io/images/vxy259ii/production/d4b33b69c008aa7df93d9cfb59833546f76c2779-2700x1134.jpg?auto=format&crop=entropy&fit=crop&h=810&q=80&w=1440",
  "furniture":
      "https://images.pexels.com/photos/1866149/pexels-photo-1866149.jpeg",
  "home-decoration":
      "https://images.pexels.com/photos/112811/pexels-photo-112811.jpeg",
  "groceries": "https://thumbs.dreamstime.com/b/lots-groceries-17001094.jpg",
  "kitchen-accessories":
      "https://images.pexels.com/photos/302680/pexels-photo-302680.jpeg",
  "laptops": "https://images.pexels.com/photos/18105/pexels-photo.jpg",
  "mens-shirts":
      "https://images.pexels.com/photos/428338/pexels-photo-428338.jpeg",
  "mens-shoes": "https://images.pexels.com/photos/19090/pexels-photo.jpg",
  "mens-watches":
      "https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg",
  "mobile-accessories":
      "https://images.pexels.com/photos/699122/pexels-photo-699122.jpeg",
  "motorcycle":
      "https://images.pexels.com/photos/210019/pexels-photo-210019.jpeg",
  "skin-care":
      "https://images.pexels.com/photos/4348404/pexels-photo-4348404.jpeg",
  "smartphones":
      "https://images.pexels.com/photos/5077045/pexels-photo-5077045.jpeg",
  "sports-accessories":
      "https://images.pexels.com/photos/257920/pexels-photo-257920.jpeg",
  "sunglasses":
      "https://images.pexels.com/photos/46710/pexels-photo-46710.jpeg",
  "tablets":
      "https://images.pexels.com/photos/5082576/pexels-photo-5082576.jpeg",
  "tops": "https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg",
  "vehicle": "https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg",
  "womens-bags":
      "https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg",
  "womens-dresses":
      "https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg",
  "womens-jewellery":
      "https://images.pexels.com/photos/2101187/pexels-photo-2101187.jpeg",
  "womens-shoes":
      "https://images.pexels.com/photos/298863/pexels-photo-298863.jpeg",
  "womens-watches":
      "https://images.pexels.com/photos/277319/pexels-photo-277319.jpeg",
  "default": "https://images.pexels.com/photos/326278/pexels-photo-326278.jpeg",
};

class Categories {
  final String slug;
  final String name;
  final String url;
  final String imageUrl;

  Categories({
    required this.slug,
    required this.name,
    required this.url,
    required this.imageUrl,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      slug: json['slug'],
      name: json['name'],
      url: json['url'],
      imageUrl:
          categoryNetworkImages[json['slug']] ??
          categoryNetworkImages["default"]!,
    );
  }
}
