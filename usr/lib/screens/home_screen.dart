import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    SwipeCards(),
    MatchesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DateMate'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
    );
  }
}

class SwipeCards extends StatefulWidget {
  const SwipeCards({super.key});

  @override
  State<SwipeCards> createState() => _SwipeCardsState();
}

class _SwipeCardsState extends State<SwipeCards> {
  final List<User> users = [
    User(
      id: '1',
      name: 'Alice',
      age: 25,
      bio: 'Love hiking and photography',
      imageUrl: 'https://picsum.photos/300/400?random=1',
      interests: ['Hiking', 'Photography', 'Travel'],
    ),
    User(
      id: '2',
      name: 'Bob',
      age: 28,
      bio: 'Coffee enthusiast and book lover',
      imageUrl: 'https://picsum.photos/300/400?random=2',
      interests: ['Reading', 'Coffee', 'Art'],
    ),
    User(
      id: '3',
      name: 'Charlie',
      age: 26,
      bio: 'Fitness trainer and foodie',
      imageUrl: 'https://picsum.photos/300/400?random=3',
      interests: ['Fitness', 'Cooking', 'Music'],
    ),
  ];

  int currentIndex = 0;

  void _swipeRight() {
    if (currentIndex < users.length - 1) {
      setState(() {
        currentIndex++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Liked!')),
      );
    }
  }

  void _swipeLeft() {
    if (currentIndex < users.length - 1) {
      setState(() {
        currentIndex++;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= users.length) {
      return const Center(
        child: Text('No more profiles to show'),
      );
    }

    final user = users[currentIndex];

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(user.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.name}, ${user.age}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.bio,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            children: user.interests
                                .map((interest) => Chip(label: Text(interest)))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: _swipeLeft,
                backgroundColor: Colors.red,
                child: const Icon(Icons.close, color: Colors.white),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.message, color: Colors.white),
              ),
              FloatingActionButton(
                onPressed: _swipeRight,
                backgroundColor: Colors.green,
                child: const Icon(Icons.favorite, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Matches Screen - Coming Soon!'),
    );
  }
}