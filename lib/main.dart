// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_1_restapi/controller/product_controller.dart';
import 'package:flutter_application_1_restapi/model/product_detail.dart';
import 'package:get/get.dart';

void main(List<String> args) {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter RestAPI',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter RestAPI'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.createProduct();
              Get.to(ProductDetail());
            },
            child: Icon(Icons.add),
          ),
          body: Obx(
            () => Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      itemCount: controller.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.65),
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return InkWell(
                          onTap: () async {
                            await controller.getProduct(product.id);
                            Get.to(ProductDetail());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(
                                      product.images,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 25,
                                        child: Text(
                                          product.category,
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.blue),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: Text(
                                          product.title,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: Text(
                                          '\$ ${product.price}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 15,
                                            ),
                                          ),
                                          Text(
                                              '${product.rating} | ${product.stock}')
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          )),
    );
  }
}
