import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<CartItem> cartItems = [
    CartItem(
      name: 'Pullover',
      color: 'Black',
      size: 'L',
      price: 51,
      image: 'assets/item1.jpg',
    ),
    CartItem(
      name: 'T-Shirt',
      color: 'Gray',
      size: 'L',
      price: 30,
      image: 'assets/item2.jpg',
    ),
    CartItem(
      name: 'Sport Dress',
      color: 'Black',
      size: 'M',
      price: 43,
      image: 'assets/item3.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white30,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            color: Colors.black,
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black12,

        child: ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (BuildContext context, int index) {
            return CartItemWidget(cartItem: cartItems[index]);
          },
        ),
      ),
      floatingActionButton: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
                child: RichText(
              text: TextSpan(
                  text: 'Total amount :',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                        text: "               ${calculateTotal()}\$",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700))
                  ]),
            )),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 250.0,
              height: 40.0,
              child: ElevatedButton(
                  onPressed: () {
                    showCongratulatorySnackbar(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("CHECK OUT")),
            )
          ],
        ),
      ),
    );
  }

  double calculateTotal() {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void showCongratulatorySnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Congratulations! Your order has been placed.'),
      ),
    );
  }
}

class CartItem {
  final String name;
  final String color;
  final String size;
  final double price;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Image.asset(
            cartItem.image,
            width: 120.0,
            height: 122.0,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cartItem.name,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Color:',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " ${cartItem.color}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700))
                            ]),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Size:',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                            children: [
                              TextSpan(
                                  text: " ${cartItem.size}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700))
                            ]),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FloatingActionButton.small(
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: const Icon(
                          Icons.add,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(cartItem.quantity.toString()),
                      const SizedBox(
                        width: 5,
                      ),
                      FloatingActionButton.small(
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: const Icon(
                          Icons.remove,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Implement logic to decrease quantity
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Text('${cartItem.price}\$'),
            ],
          ),
        ],
      ),
    );
  }
}
