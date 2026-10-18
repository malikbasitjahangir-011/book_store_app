import 'package:flutter/material.dart';

import 'models/book.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const BookStoreApp());
}

class BookStoreApp extends StatefulWidget {
  const BookStoreApp({super.key});

  @override
  State<BookStoreApp> createState() => _BookStoreAppState();
}

class _BookStoreAppState extends State<BookStoreApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final ValueNotifier<List<Book>> _books = ValueNotifier<List<Book>>(
    List<Book>.of(HomeScreen.books),
  );

  void _addBook(Book book) {
    _books.value = [..._books.value, book];
  }

  @override
  void dispose() {
    _books.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Book Store App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
      ),
      home: SplashScreen(
        onContinue: () {
          _navigatorKey.currentState!.pushReplacement(
            MaterialPageRoute<void>(
              builder: (_) =>
                  HomeScreen(bookList: _books, onBookAdded: _addBook),
            ),
          );
        },
      ),
    );
  }
}
