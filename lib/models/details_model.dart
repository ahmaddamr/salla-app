class DetailsModel {
  final bool status;
  final dynamic message;
  final Data data;

  DetailsModel({
    required this.status,
    this.message,
    required this.data,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final int currentPage;
  final List<Product> products;

  Data({
    required this.currentPage,
    required this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var productsList = json['data'] as List;
    List<Product> products =
        productsList.map((i) => Product.fromJson(i)).toList();

    return Data(
      currentPage: json['current_page'],
      products: products,
    );
  }
}

class Product {
  final dynamic id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final dynamic image;
  final dynamic name;
  final dynamic description;
  final List<String> images;
  final bool inFavorites;
  final bool inCart;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var imagesList = json['images'] as List;
    List<String> images = imagesList.map((i) => i as String).toList();

    return Product(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      images: images,
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }
}
