import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/product_controller.dart';
import 'see_all_list_screen.dart';

class ApiListScreen extends StatefulWidget {
  const ApiListScreen({super.key});

  @override
  State<ApiListScreen> createState() => _ApiListScreenState();
}

class _ApiListScreenState extends State<ApiListScreen> {
  ProductController productController = Get.put(ProductController());
  bool isSmallScreen = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    isSmallScreen = screenSize.width < 600; // Adjust the threshold as needed

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'New Launch',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const MyAllListScreen());
                      },
                      child: const Row(
                        children: [
                          Text(
                            'See all',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2,
                    crossAxisCount: 1,
                    mainAxisExtent: 150,
                    crossAxisSpacing: 25.0,
                    mainAxisSpacing: 25.0,
                  ),
                  itemCount: productController.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = productController.products[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: isSmallScreen ? 120 : 160,
                          child: Image.network(
                            fit: BoxFit.fill,
                            product.thumbnail,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          product.title,
                          maxLines: isSmallScreen ? 2 : 3,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Flexible(
                          child: Text(
                            product.description,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const MyAllListScreen());
                      },
                      child: const Row(
                        children: [
                          Text(
                            'See all',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: isSmallScreen ? 2 : 2,
                    crossAxisCount: isSmallScreen ? 1 : 1,
                    mainAxisExtent: isSmallScreen ? 150 : 200,
                    crossAxisSpacing: isSmallScreen ? 10.0 : 25.0,
                    mainAxisSpacing: isSmallScreen ? 10.0 : 25.0,
                  ),
                  itemCount: productController.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = productController.products[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: isSmallScreen ? 120 : 160,
                          child: Image.network(
                            fit: BoxFit.fill,
                            product.thumbnail,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          product.title,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          child: Text(
                            product.description,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
