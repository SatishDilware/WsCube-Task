import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/product_models.dart';

class ProductController extends GetxController {
  RxList<ProductModels> products = <ProductModels>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> productsData = responseData['products'];

      // Update products using .value or .assign
      products.assignAll(productsData
          .map((productData) => ProductModels.fromJson(productData))
          .toList());

      // Upload the fetched products to Firestore
      await uploadProductsToFirestore(products);
    }
  }

  Future<void> uploadProductsToFirestore(List<ProductModels> products) async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    for (final product in products) {
      final docRef = firestore.collection('all_products').doc('${product.id}');
      batch.set(docRef, {
        'id': product.id,
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'discountPercentage': product.discountPercentage,
        'rating': product.rating,
        'stock': product.stock,
        'brand': product.brand,
        'category': product.category,
        'thumbnail': product.thumbnail,
        'images': product.images,
      });
    }

    try {
      await batch.commit();
    } catch (error) {
      print('Error uploading products: $error');
    }
  }
}
