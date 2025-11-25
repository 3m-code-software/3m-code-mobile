import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final String image;
  final List<String> images;
  final double price;
  final double rating;
  final int reviewCount;
  final String category;
  final bool isAvailable;
  final List<String> tags;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.images,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.category,
    required this.isAvailable,
    required this.tags,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      image: json['image'] as String? ?? 'assets/test/test.png',
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [json['image'] as String? ?? 'assets/test/test.png'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      category: json['category'] as String? ?? '',
      isAvailable: json['isAvailable'] as bool? ?? true,
      tags: List<String>.from(json['tags'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'images': images,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'category': category,
      'isAvailable': isAvailable,
      'tags': tags,
    };
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    List<String>? images,
    double? price,
    double? rating,
    int? reviewCount,
    String? category,
    bool? isAvailable,
    List<String>? tags,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      images: images ?? this.images,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    image,
    images,
    price,
    rating,
    reviewCount,
    category,
    isAvailable,
    tags,
  ];
}
