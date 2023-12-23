import 'dart:convert';
// import 'dart:html';

import 'package:flutter_application_1_restapi/model/product.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  final url = "http://10.0.2.2:3000";
  var isLoading = false.obs;
  List<Product> products = <Product>[].obs;
  late Product product;

  @override
  void onInit() {
    super.onInit();
    getProducts(1);
  }

  refreshProduct() async {
    products.clear();
    await getProducts(1);
  }

  createProduct() {
    product = Product(
        id: 0,
        title: '',
        description: '',
        price: 0,
        discountPercentage: 0,
        rating: 0,
        stock: 0,
        brand: '',
        category: '',
        thumbnail: '',
        images: '');
  }

  getProducts(int page) async {
    isLoading(true);
    final response =
        await http.get(Uri.parse('$url/products?page=$page&perpage=100'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      var list =
          List<Product>.from(data['data'].map((item) => Product.fromMap(item)));
      products.addAll(list);
    }
    isLoading(false);
  }

  getProduct(int id) async {
    final response = await http.get(Uri.parse('$url/products/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      product = Product.fromMap(data);
      print(data);
    }
  }

  insertProduct() async {
    isLoading(true);
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final response = await http.post(Uri.parse('$url/products'),
        headers: headers, body: jsonEncode(product.toMap()));
    if (response.statusCode == 200) {
      return true;
    }
    isLoading(false);
    return false;
  }

  updateProduct(int id) async {
    isLoading(true);
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final response = await http.put(Uri.parse('$url/products/$id'),
        headers: headers, body: jsonEncode(product.toMap()));
    if (response.statusCode == 200) {
      return true;
    }
    isLoading(false);
    return false;
  }

  deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$url/products/$id'));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
