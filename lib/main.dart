import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final double unitPrice;
  final Color color;
  final String size;

  Product({required this.name, required this.unitPrice, required this.color, required this.size});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shopping Cart'),
        ),
        body: ShoppingCartScreen(),
      ),
    );
  }
}

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  int itemCount = 0;
  double totalAmount = 0.0;

  List<Product> products = [
    Product(name: 'T-shirt', unitPrice: 15.0, color: Colors.blue, size: 'M'),
    Product(name: 'School Bag', unitPrice: 25.0, color: Colors.black, size: 'One Size'),
    Product(name: 'Pullover', unitPrice: 30.0, color: Colors.red, size: 'L'),
    Product(name: 'Sport Dress', unitPrice: 40.0, color: Colors.green, size: 'S'),
  ];

  void _increaseItemCount() {
    setState(() {
      itemCount++;
      totalAmount += products.last.unitPrice;
      if (itemCount % 5 == 0) {
        _showAddToCartDialog(products.last.name);
      }
    });
  }

  void _decreaseItemCount() {
    setState(() {
      if (itemCount > 0) {
        itemCount--;
        totalAmount -= products.last.unitPrice;
      }
    });
  }

  void _checkout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Your order has been placed. Total: \$${totalAmount.toStringAsFixed(2)}'),
      ),
    );
  }

  void _viewItems() {
    if (itemCount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You have $itemCount item(s) in your bag.'),
        ),
      );
    }
  }

  Future<void> _showAddToCartDialog(String productName) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Item Added to Cart'),
          content: Text('You have added 5 $productName(s) to your bag!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Color: ${product.color.toString()}'),
                Text('Size: ${product.size}'),
              ],
            ),
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: _increaseItemCount,
                child: Text('Add to Cart'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: _decreaseItemCount,
              ),
              Text(
                '$itemCount',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: _increaseItemCount,
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _checkout,
            child: Text('CHECK OUT'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _viewItems,
            child: Text('VIEW ITEMS'),
          ),
          SizedBox(height: 20),
          _buildProductCard(products[0]), // T-shirt
          _buildProductCard(products[1]), // School Bag
          _buildProductCard(products[2]), // Pullover
          _buildProductCard(products[3]), // Sport Dress
        ],
      ),
    );
  }
}
