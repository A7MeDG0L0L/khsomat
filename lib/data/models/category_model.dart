// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.parent,
    required this.count,
    required this.image,
    required this.reviewCount,
    required this.permalink,
  });

  int id;
  String name;
  String slug;
  String description;
  int parent;
  int count;
  ImageCategory? image;
  int reviewCount;
  String permalink;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    description: json["description"],
    parent: json["parent"],
    count: json["count"],
    image: json["image"] == null ? null : ImageCategory.fromJson(json["image"]),
    reviewCount: json["review_count"],
    permalink: json["permalink"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "description": description,
    "parent": parent,
    "count": count,
    "image": image == null ? null : image!.toJson(),
    "review_count": reviewCount,
    "permalink": permalink,
  };
}

class ImageCategory {
  ImageCategory({
    required this.id,
    required this.src,
    required this.thumbnail,
    required this.srcset,
    required this.sizes,
    required this.name,
    required this.alt,
  });

  int id;
  String src;
  String thumbnail;
  String srcset;
  Sizes? sizes;
  String name;
  String alt;

  factory ImageCategory.fromJson(Map<String, dynamic> json) => ImageCategory(
    id: json["id"],
    src: json["src"],
    thumbnail: json["thumbnail"],
    srcset: json["srcset"],
    sizes: sizesValues.map[json["sizes"]],
    name: json["name"],
    alt: json["alt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "src": src,
    "thumbnail": thumbnail,
    "srcset": srcset,
    "sizes": sizesValues.reverse![sizes],
    "name": name,
    "alt": alt,
  };
}

enum Sizes { MAX_WIDTH_187_PX_100_VW_187_PX }

final sizesValues = EnumValues({
  "(max-width: 187px) 100vw, 187px": Sizes.MAX_WIDTH_187_PX_100_VW_187_PX
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
