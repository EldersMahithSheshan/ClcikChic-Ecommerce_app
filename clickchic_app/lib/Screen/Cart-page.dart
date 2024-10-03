import 'package:clickchic_app/Screen/notification_page.dart';
import 'package:clickchic_app/Screen/profile.dart';
import 'package:clickchic_app/Services/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_page.dart'; // Import your product page

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Back icon
          onPressed: () {
            // Navigate back to the ProductPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductPage(title: 'Home')),
            );
          },
        ),
        title: Center(child: const Text('Cart')),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              cartProvider.clearCart();
            },
          ),
        ],
      ),
      body: cartProvider.cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty', style: TextStyle(fontSize: 18)),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartProvider.cartItems[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Image.asset(item['image'],
                                    width: 80, height: 80, fit: BoxFit.cover),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item['title'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      const SizedBox(height: 4),
                                      Text(item['subtitle']),
                                      const SizedBox(height: 8),
                                      Text('Rs. ${item['price']}'),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () => cartProvider
                                              .decrementQuantity(index),
                                        ),
                                        Text('${item['quantity']}'),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () => cartProvider
                                              .incrementQuantity(index),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () =>
                                          cartProvider.removeItem(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Total Items: ${cartProvider.totalItems}',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Total: Rs. ${cartProvider.totalPrice}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Proceed to checkout logic
                      },
                      child: const Text('Proceed to Payment',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Theme.of(context).bottomAppBarColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: NavigationBar(
            height: 60,
            selectedIndex: 1,
            backgroundColor: Colors.transparent,
            onDestinationSelected: (int index) {
              switch (index) {
                case 0:
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPage(
                                title: 'Home',
                              )));
                  break;
                case 1:
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                  break;
                case 2:
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                  break;
                case 3:
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                  break;
              }
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.notifications_active),
                label: 'Notification',
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
