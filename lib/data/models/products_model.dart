// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<Product> productModelFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productModelToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.id,
    required this.name,
    required this.parent,
    required this.type,
    required this.variation,
    required this.permalink,
    required this.sku,
    required this.shortDescription,
    required this.description,
    required this.onSale,
    required this.prices,
    required this.priceHtml,
    required this.averageRating,
    required this.reviewCount,
    required this.images,
    required this.categories,
    required this.tags,
    required this.attributes,
    required this.variations,
    required this.hasOptions,
    required this.isPurchasable,
    required this.isInStock,
    required this.isOnBackorder,
    required this.lowStockRemaining,
    required this.soldIndividually,
    required this.quantityLimit,
    required this.addToCart,
   // required this.quantity,
    //required this.counter,
  });

  int? id;
  String? name;
  int? parent;
 // Type? type;
  String? type;
  String? variation;
  String? permalink;
  String? sku;
  String? shortDescription;
  String? description;
  bool? onSale;
  Prices? prices;
  String? priceHtml;
  String? averageRating;
  int? reviewCount;
  List<Image2>? images;
  List<Category2>? categories;
  List<dynamic>? tags;
  List<dynamic>? attributes;
  List<dynamic>? variations;
  bool? hasOptions;
  bool? isPurchasable;
  bool? isInStock;
  bool? isOnBackorder;
  dynamic? lowStockRemaining;
  bool? soldIndividually;
  int? quantityLimit;
  AddToCart? addToCart;
  //  int quantity = 1;
 // Quantity counter =1;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        parent: json["parent"],
        //type: typeValues.map[json["type"]],
    type: json["type"],
        variation: json["variation"],
        permalink: json["permalink"],
        sku: json["sku"],
        shortDescription: json["short_description"],
        description: json["description"],
        onSale: json["on_sale"],
        prices: Prices.fromJson(json["prices"]),
        priceHtml: json["price_html"],
        averageRating: json["average_rating"],
        reviewCount: json["review_count"],
        images: List<Image2>.from(json["images"].map((x) => Image2.fromJson(x)))
            .toList(),
        categories: List<Category2>.from(
            json["categories"].map((x) => Category2.fromJson(x))),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        variations: List<dynamic>.from(json["variations"].map((x) => x)),
        hasOptions: json["has_options"],
        isPurchasable: json["is_purchasable"],
        isInStock: json["is_in_stock"],
        isOnBackorder: json["is_on_backorder"],
        lowStockRemaining: json["low_stock_remaining"],
        soldIndividually: json["sold_individually"],
        quantityLimit: json["quantity_limit"],
        addToCart: AddToCart.fromJson(json["add_to_cart"]),
      //  quantity: 1,
       // counter: Quantity(counter: 1),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent": parent,
        "type": typeValues.reverse![type],
        "variation": variation,
        "permalink": permalink,
        "sku": sku,
        "short_description": shortDescription,
        "description": description,
        "on_sale": onSale,
        "prices": prices!.toJson(),
        "price_html": priceHtml,
        "average_rating": averageRating,
        "review_count": reviewCount,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "attributes": List<dynamic>.from(attributes!.map((x) => x)),
        "variations": List<dynamic>.from(variations!.map((x) => x)),
        "has_options": hasOptions,
        "is_purchasable": isPurchasable,
        "is_in_stock": isInStock,
        "is_on_backorder": isOnBackorder,
        "low_stock_remaining": lowStockRemaining,
        "sold_individually": soldIndividually,
        "quantity_limit": quantityLimit,
        "add_to_cart": addToCart!.toJson(),
      };
}

class Quantity {
  int counter = 1;
  Quantity({required this.counter});

  void increaseCounter(){
    counter++;
  }
  void decreaseCounter(){
   if(counter>1)
     counter--;
  }
}

class AddToCart {
  AddToCart({
    required this.text,
    required this.description,
    required this.url,
  });

  Text2? text;
  String? description;
  String? url;

  factory AddToCart.fromJson(Map<String, dynamic> json) => AddToCart(
        text: textValues.map[json["text"]],
        description: json["description"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "text": textValues.reverse![text],
        "description": description,
        "url": url,
      };
}

enum Text2 { EMPTY }

final textValues = EnumValues({"إضافة إلى السلة": Text2.EMPTY});

class Category2 {
  Category2({
    required this.id,
    required this.name,
    required this.slug,
    required this.link,
  });

  int? id;
  Name? name;
  String? slug;
  String? link;

  factory Category2.fromJson(Map<String, dynamic> json) => Category2(
        id: json["id"],
        name: nameValues.map[json["name"]],
        slug: json["slug"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse![name],
        "slug": slug,
        "link": link,
      };
}

enum Name { EMPTY, NAME, PURPLE }

final nameValues = EnumValues({
  "انظمة امنية ومراقبة": Name.EMPTY,
  "اكسسوار رجالي": Name.NAME,
  "اكسسوار نسائي": Name.PURPLE
});

class Image2 {
  Image2({
    required this.id,
    required this.src,
    required this.thumbnail,
    required this.srcset,
    required this.sizes,
    required this.name,
    required this.alt,
  });

  int? id;
  String? src;
  String? thumbnail;
  String? srcset;
  Sizes? sizes;
  String? name;
  String? alt;

  factory Image2.fromJson(Map<String, dynamic> json) => Image2(
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

enum Sizes { MAX_WIDTH_500_PX_100_VW_500_PX }

final sizesValues = EnumValues(
    {"(max-width: 500px) 100vw, 500px": Sizes.MAX_WIDTH_500_PX_100_VW_500_PX});

class Prices {
  Prices({
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
    required this.currencyDecimalSeparator,
    required this.currencyThousandSeparator,
    required this.currencyPrefix,
    required this.currencySuffix,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.priceRange,
  });

  Currency? currencyCode;
  Currency? currencySymbol;
  int? currencyMinorUnit;
  CurrencyDecimalSeparator? currencyDecimalSeparator;
  CurrencyThousandSeparator? currencyThousandSeparator;
  CurrencyPrefix? currencyPrefix;
  String? currencySuffix;
  String? price;
  int? regularPrice;
  int? salePrice;
  dynamic? priceRange;

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        currencyCode: currencyValues.map[json["currency_code"]],
        currencySymbol: currencyValues.map[json["currency_symbol"]],
        currencyMinorUnit: json["currency_minor_unit"],
        currencyDecimalSeparator: currencyDecimalSeparatorValues
            .map[json["currency_decimal_separator"]],
        currencyThousandSeparator: currencyThousandSeparatorValues
            .map[json["currency_thousand_separator"]],
        currencyPrefix: currencyPrefixValues.map[json["currency_prefix"]],
        currencySuffix: json["currency_suffix"],
        price: json["price"],
        regularPrice: int.parse(json["regular_price"]),
        salePrice: int.parse(json["sale_price"]),
        priceRange: json["price_range"],
      );

  Map<String, dynamic> toJson() => {
        "currency_code": currencyValues.reverse![currencyCode],
        "currency_symbol": currencyValues.reverse![currencySymbol],
        "currency_minor_unit": currencyMinorUnit,
        "currency_decimal_separator":
            currencyDecimalSeparatorValues.reverse![currencyDecimalSeparator],
        "currency_thousand_separator":
            currencyThousandSeparatorValues.reverse![currencyThousandSeparator],
        "currency_prefix": currencyPrefixValues.reverse![currencyPrefix],
        "currency_suffix": currencySuffix,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "price_range": priceRange,
      };
}

enum Currency { EGP }

final currencyValues = EnumValues({"EGP": Currency.EGP});

enum CurrencyDecimalSeparator { EMPTY }

final currencyDecimalSeparatorValues =
    EnumValues({".": CurrencyDecimalSeparator.EMPTY});

enum CurrencyPrefix { EGP }

final currencyPrefixValues = EnumValues({"EGP ": CurrencyPrefix.EGP});

enum CurrencyThousandSeparator { EMPTY }

final currencyThousandSeparatorValues =
    EnumValues({",": CurrencyThousandSeparator.EMPTY});

enum Type { SIMPLE }

final typeValues = EnumValues({"simple": Type.SIMPLE});

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

// this fuckin model msh sha8al
//
// // To parse this JSON data, do
// //
// //     final productsModel = productsModelFromJson(jsonString);
//
// import 'dart:convert';
//
// List<Product> productsModelFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));
//
// String productsModelToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Product {
//   Product({
//     required this.id,
//     required this.name,
//     required this.parent,
//     required this.type,
//     required this.variation,
//     required this.permalink,
//     required this.sku,
//     required this.shortDescription,
//     required this.description,
//     required this.onSale,
//     required this.prices,
//     required this.priceHtml,
//     required this.averageRating,
//     required this.reviewCount,
//     required this.images,
//     required this.categories,
//     required this.tags,
//     required this.attributes,
//     required this.variations,
//     required this.hasOptions,
//     required this.isPurchasable,
//     required this.isInStock,
//     required this.isOnBackorder,
//     required this.lowStockRemaining,
//     required this.soldIndividually,
//     required this.quantityLimit,
//     required this.addToCart,
//   });
//
//   int id;
//   String name;
//   int parent;
//   Type? type;
//   String variation;
//   String permalink;
//   String sku;
//   String shortDescription;
//   String description;
//   bool onSale;
//   Prices prices;
//   String priceHtml;
//   String averageRating;
//   int reviewCount;
//   List<ImageP> images;
//   List<Category> categories;
//   List<dynamic> tags;
//   List<ProductsModelAttribute> attributes;
//   List<Variation> variations;
//   bool hasOptions;
//   bool isPurchasable;
//   bool isInStock;
//   bool isOnBackorder;
//   dynamic lowStockRemaining;
//   bool soldIndividually;
//   int quantityLimit;
//   AddToCart addToCart;
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     name: json["name"],
//     parent: json["parent"],
//     type: typeValues.map[json["type"]],
//     variation: json["variation"],
//     permalink: json["permalink"],
//     sku: json["sku"],
//     shortDescription: json["short_description"],
//     description: json["description"],
//     onSale: json["on_sale"],
//     prices: Prices.fromJson(json["prices"]),
//     priceHtml: json["price_html"],
//     averageRating: json["average_rating"],
//     reviewCount: json["review_count"],
//     images: List<ImageP>.from(json["images"].map((x) => ImageP.fromJson(x))),
//     categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
//     tags: List<dynamic>.from(json["tags"].map((x) => x)),
//     attributes: List<ProductsModelAttribute>.from(json["attributes"].map((x) => ProductsModelAttribute.fromJson(x))),
//     variations: List<Variation>.from(json["variations"].map((x) => Variation.fromJson(x))),
//     hasOptions: json["has_options"],
//     isPurchasable: json["is_purchasable"],
//     isInStock: json["is_in_stock"],
//     isOnBackorder: json["is_on_backorder"],
//     lowStockRemaining: json["low_stock_remaining"],
//     soldIndividually: json["sold_individually"],
//     quantityLimit: json["quantity_limit"],
//     addToCart: AddToCart.fromJson(json["add_to_cart"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "parent": parent,
//     "type": typeValues.reverse?[type],
//     "variation": variation,
//     "permalink": permalink,
//     "sku": sku,
//     "short_description": shortDescription,
//     "description": description,
//     "on_sale": onSale,
//     "prices": prices.toJson(),
//     "price_html": priceHtml,
//     "average_rating": averageRating,
//     "review_count": reviewCount,
//     "images": List<dynamic>.from(images.map((x) => x.toJson())),
//     "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
//     "tags": List<dynamic>.from(tags.map((x) => x)),
//     "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
//     "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
//     "has_options": hasOptions,
//     "is_purchasable": isPurchasable,
//     "is_in_stock": isInStock,
//     "is_on_backorder": isOnBackorder,
//     "low_stock_remaining": lowStockRemaining,
//     "sold_individually": soldIndividually,
//     "quantity_limit": quantityLimit,
//     "add_to_cart": addToCart.toJson(),
//   };
// }
//
// class AddToCart {
//   AddToCart({
//     required this.text,
//     required this.description,
//     required this.url,
//   });
//
//   TextP? text;
//   String description;
//   String url;
//
//   factory AddToCart.fromJson(Map<String, dynamic> json) => AddToCart(
//     text: textValues.map[json["text"]],
//     description: json["description"],
//     url: json["url"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "text": textValues.reverse?[text],
//     "description": description,
//     "url": url,
//   };
// }
//
// enum TextP { EMPTY, TEXT, PURPLE }
//
// final textValues = EnumValues({
//   "تحديد أحد الخيارات": TextP.EMPTY,
//   "إضافة إلى السلة": TextP.PURPLE,
//   "قراءة المزيد": TextP.TEXT
// });
//
// class ProductsModelAttribute {
//   ProductsModelAttribute({
//     required this.id,
//     required this.name,
//     required this.taxonomy,
//     required this.hasVariations,
//     required this.terms,
//   });
//
//   int id;
//   Name? name;
//   String taxonomy;
//   bool hasVariations;
//   List<Category> terms;
//
//   factory ProductsModelAttribute.fromJson(Map<String, dynamic> json) => ProductsModelAttribute(
//     id: json["id"],
//     name: nameValues.map[json["name"]],
//     taxonomy: json["taxonomy"],
//     hasVariations: json["has_variations"],
//     terms: List<Category>.from(json["terms"].map((x) => Category.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": nameValues.reverse?[name],
//     "taxonomy": taxonomy,
//     "has_variations": hasVariations,
//     "terms": List<dynamic>.from(terms.map((x) => x.toJson())),
//   };
// }
//
// enum Name { SIZE }
//
// final nameValues = EnumValues({
//   "Size": Name.SIZE
// });
//
// class Category {
//   Category({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.link,
//   });
//
//   int id;
//   String name;
//   String slug;
//   String link;
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json["id"],
//     name: json["name"],
//     slug: json["slug"],
//     link: json["link"] == null ? null : json["link"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "slug": slug,
//     "link": link == null ? null : link,
//   };
// }
//
// class ImageP {
//   ImageP({
//     required this.id,
//     required this.src,
//     required this.thumbnail,
//     required this.srcset,
//     required this.sizes,
//     required this.name,
//     required this.alt,
//   });
//
//   int id;
//   String src;
//   String thumbnail;
//   String srcset;
//   Sizes? sizes;
//   String name;
//   String alt;
//
//   factory ImageP.fromJson(Map<String, dynamic> json) => ImageP(
//     id: json["id"],
//     src: json["src"],
//     thumbnail: json["thumbnail"],
//     srcset: json["srcset"],
//     sizes: sizesValues.map[json["sizes"]],
//     name: json["name"],
//     alt: json["alt"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "src": src,
//     "thumbnail": thumbnail,
//     "srcset": srcset,
//     "sizes": sizesValues.reverse?[sizes],
//     "name": name,
//     "alt": alt,
//   };
// }
//
// enum Sizes { MAX_WIDTH_500_PX_100_VW_500_PX }
//
// final sizesValues = EnumValues({
//   "(max-width: 500px) 100vw, 500px": Sizes.MAX_WIDTH_500_PX_100_VW_500_PX
// });
//
// class Prices {
//   Prices({
//     required this.currencyCode,
//     required this.currencySymbol,
//     required this.currencyMinorUnit,
//     required this.currencyDecimalSeparator,
//     required this.currencyThousandSeparator,
//     required this.currencyPrefix,
//     required this.currencySuffix,
//     required this.price,
//     required this.regularPrice,
//     required this.salePrice,
//     required this.priceRange,
//   });
//
//   Currency? currencyCode;
//   Currency? currencySymbol;
//   int currencyMinorUnit;
//   CurrencyDecimalSeparator? currencyDecimalSeparator;
//   CurrencyThousandSeparator? currencyThousandSeparator;
//   CurrencyPrefix? currencyPrefix;
//   String currencySuffix;
//   String price;
//   String regularPrice;
//   String salePrice;
//   dynamic priceRange;
//
//   factory Prices.fromJson(Map<String, dynamic> json) => Prices(
//     currencyCode: currencyValues.map[json["currency_code"]],
//     currencySymbol: currencyValues.map[json["currency_symbol"]],
//     currencyMinorUnit: json["currency_minor_unit"],
//     currencyDecimalSeparator: currencyDecimalSeparatorValues.map[json["currency_decimal_separator"]],
//     currencyThousandSeparator: currencyThousandSeparatorValues.map[json["currency_thousand_separator"]],
//     currencyPrefix: currencyPrefixValues.map[json["currency_prefix"]],
//     currencySuffix: json["currency_suffix"],
//     price: json["price"],
//     regularPrice: json["regular_price"],
//     salePrice: json["sale_price"],
//     priceRange: json["price_range"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "currency_code": currencyValues.reverse?[currencyCode],
//     "currency_symbol": currencyValues.reverse?[currencySymbol],
//     "currency_minor_unit": currencyMinorUnit,
//     "currency_decimal_separator": currencyDecimalSeparatorValues.reverse?[currencyDecimalSeparator],
//     "currency_thousand_separator": currencyThousandSeparatorValues.reverse?[currencyThousandSeparator],
//     "currency_prefix": currencyPrefixValues.reverse?[currencyPrefix],
//     "currency_suffix": currencySuffix,
//     "price": price,
//     "regular_price": regularPrice,
//     "sale_price": salePrice,
//     "price_range": priceRange,
//   };
// }
//
// enum Currency { EGP }
//
// final currencyValues = EnumValues({
//   "EGP": Currency.EGP
// });
//
// enum CurrencyDecimalSeparator { EMPTY }
//
// final currencyDecimalSeparatorValues = EnumValues({
//   ".": CurrencyDecimalSeparator.EMPTY
// });
//
// enum CurrencyPrefix { EGP }
//
// final currencyPrefixValues = EnumValues({
//   "EGP ": CurrencyPrefix.EGP
// });
//
// enum CurrencyThousandSeparator { EMPTY }
//
// final currencyThousandSeparatorValues = EnumValues({
//   ",": CurrencyThousandSeparator.EMPTY
// });
//
// enum Type { VARIABLE, SIMPLE }
//
// final typeValues = EnumValues({
//   "simple": Type.SIMPLE,
//   "variable": Type.VARIABLE
// });
//
// class Variation {
//   Variation({
//     required this.id,
//     required this.attributes,
//   });
//
//   int id;
//   List<VariationAttribute> attributes;
//
//   factory Variation.fromJson(Map<String, dynamic> json) => Variation(
//     id: json["id"],
//     attributes: List<VariationAttribute>.from(json["attributes"].map((x) => VariationAttribute.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "attributes": List<dynamic>.from(attributes.map((x) => x.toJson())),
//   };
// }
//
// class VariationAttribute {
//   VariationAttribute({
//     required this.name,
//     required this.value,
//   });
//
//   Name? name;
//   String value;
//
//   factory VariationAttribute.fromJson(Map<String, dynamic> json) => VariationAttribute(
//     name: nameValues.map[json["name"]],
//     value: json["value"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": nameValues.reverse?[name],
//     "value": value,
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String>? get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
