import 'package:flutter/material.dart';

import '../models/book.dart';

class AddBookScreen extends StatelessWidget {
  AddBookScreen({super.key, required this.onBookAdded});

  final ValueChanged<Book> onBookAdded;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var title = '';
    var author = '';
    var price = 0.0;
    var rating = 0.0;
    var description = '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Book'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Book Information',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter a book title'
                    : null,
                onSaved: (value) => title = value!.trim(),
                decoration: InputDecoration(
                  labelText: 'Book Title',
                  prefixIcon: Icon(Icons.book),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter an author name'
                    : null,
                onSaved: (value) => author = value!.trim(),
                decoration: InputDecoration(
                  labelText: 'Author Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) =>
                    double.tryParse(value ?? '') == null ||
                        double.parse(value!) <= 0
                    ? 'Enter a price greater than zero'
                    : null,
                onSaved: (value) => price = double.parse(value!),
                decoration: InputDecoration(
                  labelText: 'Price',
                  prefixIcon: Icon(Icons.currency_exchange),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  final parsed = double.tryParse(value ?? '');
                  return parsed == null || parsed < 0 || parsed > 5
                      ? 'Enter a rating from 0 to 5'
                      : null;
                },
                onSaved: (value) => rating = double.parse(value!),
                decoration: InputDecoration(
                  labelText: 'Rating',
                  prefixIcon: Icon(Icons.star),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 3,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter a description'
                    : null,
                onSaved: (value) => description = value!.trim(),
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    _formKey.currentState!.save();
                    onBookAdded(
                      Book(
                        title: title,
                        author: author,
                        price: price,
                        rating: rating,
                        imagePath: '',
                        description: description,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Book'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
