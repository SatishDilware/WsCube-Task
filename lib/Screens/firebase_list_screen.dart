import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseListScreen extends StatefulWidget {
  const FirebaseListScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseListScreen> createState() => _FirebaseListScreenState();
}

class _FirebaseListScreenState extends State<FirebaseListScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen =
        screenSize.width < 600; // Adjust the threshold as needed

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'All Products',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('all_products')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SizedBox(
                            height: 30, child: CircularProgressIndicator()));
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final products = snapshot.data!.docs;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: isSmallScreen ? 1 : 1,
                      mainAxisExtent: isSmallScreen ? 150 : 200,
                      maxCrossAxisExtent: isSmallScreen ? 150 : 200,
                      crossAxisSpacing: isSmallScreen ? 5 : 10,
                      mainAxisSpacing: isSmallScreen ? 5 : 10,
                    ),
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = products[index];
                      final data = product.data() as Map<String, dynamic>;
                      return Card(
                        color: Colors.blueGrey.shade800,
                        child: Column(
                          children: [
                            Image.network(
                              data['thumbnail'],
                              fit: BoxFit.cover,
                              width: isSmallScreen ? 80 : 100,
                              height: isSmallScreen ? 80 : 100,
                            ),
                            Text(
                              data['title'],
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              data['description'],
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 15,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
