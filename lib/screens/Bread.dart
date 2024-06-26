import 'package:aplikasi_online/screens/cartPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cart.dart';

class BreadPage extends StatefulWidget {
  const BreadPage({super.key});

  @override
  State<BreadPage> createState() => _BreadPageState();
}

class _BreadPageState extends State<BreadPage> {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: Text("HI!"),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: db.collection('bread').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }

          var _data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, index) {
              var user = _data[index].data();
              return ListTile(
                leading: user['imageUrl'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          user['imageUrl'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : null,
                title: Text('${user['first']} ${user['last']}'),
                subtitle: Text('Rp: ${user['price']}'),
                trailing: RawMaterialButton(
                  onPressed: () {
                    Provider.of<CartModel>(context, listen: false)
                        .addItem(user);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Item added to cart!')),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Add To Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      // Add data
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     final user = <String, dynamic>{
      //       "first": "Challah",
      //       "last": "Bread",
      //       "price": "22,000",
      //       "imageUrl":
      //           "https://hicookofficial.com/wp-content/uploads/2023/11/Challah-Bread-768x576.webp" // Replace with actual URL
      //     };
      //     db.collection('bread').add(user).then((DocumentReference doc) =>
      //         print('DocumentSnapshot added with ID: ${doc.id}'));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
