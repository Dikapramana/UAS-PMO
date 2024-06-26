import 'package:aplikasi_online/components/UserLocation.dart';
import 'package:aplikasi_online/screens/cartPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cart.dart';

class CoffeePage extends StatefulWidget {
  const CoffeePage({super.key});

  @override
  State<CoffeePage> createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
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
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext contex) {
                return const SimpleMapScreen();
              }));
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: db.collection('users').snapshots(),
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

      //Map
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => MapScreen(),
      //         ));
      //   },
      //   child: Icon(Icons.location_on),
      // ),

      // Add data
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     final user = <String, dynamic>{
      //       "first": "coffe",
      //       "last": "luak",
      //       "price": "20,000",
      //       "imageUrl":
      //           "https://th.bing.com/th/id/OIP.s-YZQh3dS5KPsWiI00yYAAHaE8?rs=1&pid=ImgDetMain" // Replace with actual URL
      //     };
      //     db.collection('users').add(user).then((DocumentReference doc) =>
      //         print('DocumentSnapshot added with ID: ${doc.id}'));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
