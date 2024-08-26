class SearchModel {
  bool status;
  String? message;
  SearchData data;

  SearchModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      status: json['status'],
      message: json['message'],
      data: SearchData.fromJson(json['data']),
    );
  }
}

class SearchData {
  int currentPage;
  List<ProductData> products;

  SearchData({
    required this.currentPage,
    required this.products,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) {
    var productsList = json['data'] as List;
    List<ProductData> productsData =
        productsList.map((i) => ProductData.fromJson(i)).toList();

    return SearchData(
      currentPage: json['current_page'],
      products: productsData,
    );
  }
}

class ProductData {
  dynamic id;
  dynamic price;
  dynamic image;
  dynamic name;
  dynamic description;
  List<String> images;
  bool inFavorites;
  bool inCart;

  ProductData({
    required this.id,
    required this.price,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      price: json['price'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      images: List<String>.from(json['images']),
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}
