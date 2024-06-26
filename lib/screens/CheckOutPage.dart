import 'package:flutter/material.dart';

class CheckOutPage extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  CheckOutPage({required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];
                  return ListTile(
                    leading: item['imageUrl'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              item['imageUrl'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : null,
                    title: Text('${item['first']} ${item['last']}'),
                    subtitle: Text('Rp: ${item['price']}'),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement purchase logic here
                  // For example, add order to Firebase or navigate to payment gateway

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Purchase successful!')),
                  );
                },
                child: Text(
                  'Confirm Purchase',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrangeAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
