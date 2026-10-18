import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../models/book.dart';
import 'add_book_screen.dart';
import 'detail_screen.dart';
import '../widgets/book_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.bookList,
    required this.onBookAdded,
  });

  final ValueListenable<List<Book>> bookList;
  final ValueChanged<Book> onBookAdded;

  static const List<Book> books = [
    Book(
      title: 'Atomic Habits',
      author: 'James Clear',
      price: 1200,
      rating: 4.8,
      imagePath: 'assets/images/atomic_habits.jpg',
      description: 'A book about building better habits.',
    ),
    Book(
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      price: 950,
      rating: 4.6,
      imagePath: 'assets/images/alchemist.jpg',
      description: 'A story about following your dreams.',
    ),
    Book(
      title: 'Ikigai',
      author: 'Hector Garcia',
      price: 1100,
      rating: 4.5,
      imagePath: 'assets/images/ikigai.jpg',
      description: 'A book about finding purpose in life.',
    ),
    Book(
      title: 'Rich Dad Poor Dad',
      author: 'Robert Kiyosaki',
      price: 1300,
      rating: 4.7,
      imagePath: 'assets/images/rich_dad.jpg',
      description: 'A book about financial education.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Store'),
        actions: [
          IconButton(
            tooltip: 'Add a book',
            onPressed: () => _openAddBook(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ValueListenableBuilder<List<Book>>(
        valueListenable: bookList,
        builder: (context, currentBooks, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Discover Your Next Book',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Explore our recommended collection'),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search books',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ...currentBooks.map(
                  (book) => BookCard(
                    book: book,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => DetailScreen(book: book),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddBook(context),
        icon: const Icon(Icons.add),
        label: const Text('Add book'),
      ),
    );
  }

  void _openAddBook(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => AddBookScreen(onBookAdded: onBookAdded),
      ),
    );
  }
}
