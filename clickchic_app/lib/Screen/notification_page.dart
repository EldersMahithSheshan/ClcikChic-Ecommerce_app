// ignore_for_file: deprecated_member_use

import 'package:clickchic_app/Screen/product_page.dart';
import 'package:clickchic_app/Screen/profile.dart';
import 'package:flutter/material.dart';

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Notification Page',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: NotificationPage(),
  );
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(
                  title: '',
                ),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NotificationCard(
              icon: Icon(Icons.list_alt, size: 40.0, color: Colors.white),
              title: 'Orders',
              subtitle: 'Order status, tracking updates, dispute progress...',
            ),
            NotificationCard(
              icon: Icon(Icons.local_offer, size: 40.0, color: Colors.white),
              title: 'Promotions',
              subtitle: 'Discounts, sales announcements, price alerts and...',
            ),
            NotificationCard(
              icon: Icon(Icons.star, size: 40.0, color: Colors.white),
              title: 'Coin Notification',
              subtitle: 'Make savings of LKR 60.64 with 20 coins >>',
              date: 'Yesterday',
              isDotted: true,
            ),
            NotificationCard(
              icon: Icon(Icons.money_off, size: 40.0, color: Colors.white),
              title: 'Grow to Get Notification',
              subtitle: 'Get a prize for only US .10!',
              date: 'Yesterday',
              isDotted: true,
            ),
            NotificationCard(
              icon: Icon(Icons.games, size: 40.0, color: Colors.white),
              title: 'GoGo Match Notification',
              subtitle: 'Play daily & earn game boosters',
              date: '12/06',
              isDotted: true,
            ),
            NotificationCard(
              icon: Icon(Icons.merge_type, size: 40.0, color: Colors.white),
              title: 'Merge Boss Notification',
              subtitle: 'Play for fun & earn savings!',
              date: '10/06',
              isDotted: true,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Past messages',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            NotificationCard(
              icon: Icon(Icons.volume_up, size: 40.0, color: Colors.white),
              title: 'Services',
              subtitle: 'Claim your 20 coins to save LKR 59.43',
              date: '03/05',
              isDotted: false,
            ),
            NotificationCard(
              icon: Icon(Icons.shopping_cart, size: 40.0, color: Colors.white),
              title: 'First Automobile Parts Store',
              subtitle: '[Order Confirmation]',
              date: '24/01',
              isDotted: false,
              badgeNumber: 1,
            ),
            NotificationCard(
              icon: Icon(Icons.shopping_cart, size: 40.0, color: Colors.white),
              title: 'Becoming That Girl Store',
              subtitle: '[Order Confirmation]',
              date: '18/12/2023',
              isDotted: false,
              badgeNumber: 1,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
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
            selectedIndex: 2,
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
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductPage(
                                title: 'Home',
                              )));
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

class NotificationCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String subtitle;
  final String date;
  final bool isDotted;
  final int badgeNumber;

  NotificationCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.date = '',
    this.isDotted = false,
    this.badgeNumber = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).colorScheme.surfaceVariant,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 5, 128, 62),
                ),
                child: icon,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    if (isDotted)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Container(
                              height: 4.0,
                              width: 4.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (badgeNumber > 0)
                Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Text(
                    '$badgeNumber',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
