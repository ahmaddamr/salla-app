class FavScreenModel {
  bool? status;
  String? message;
  FavData? data;

  FavScreenModel({this.status, this.message, this.data});

  FavScreenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? FavData.fromJson(json['data']) : null;
  }
}

class FavData {
  int? currentPage;
  List<FavDataItem>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  FavData(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  FavData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavDataItem>[];
      json['data'].forEach((v) {
        data!.add(FavDataItem.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavDataItem {
  int? id;
  Product? product;

  FavDataItem({this.id, this.product});

  FavDataItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  dynamic id;
  double? price;
  double? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = (json['price'] as num?)?.toDouble();
    oldPrice = (json['old_price'] as num?)?.toDouble();
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
