import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:book_store_app/main.dart';

void main() {
  testWidgets('Book Store App launches', (WidgetTester tester) async {
    await tester.pumpWidget(const BookStoreApp());

    expect(find.text('Book Store'), findsOneWidget);
    expect(find.text('Browse Books'), findsOneWidget);

    await tester.tap(find.text('Browse Books'));
    await tester.pumpAndSettle();

    expect(find.text('Discover Your Next Book'), findsOneWidget);
    expect(find.text('Atomic Habits'), findsOneWidget);

    await tester.tap(find.text('Atomic Habits'));
    await tester.pumpAndSettle();

    expect(find.text('Author: James Clear'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add book'));
    await tester.pumpAndSettle();

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'Test Book');
    await tester.enterText(fields.at(1), 'Test Author');
    await tester.enterText(fields.at(2), '12.50');
    await tester.enterText(fields.at(3), '4.5');
    await tester.enterText(fields.at(4), 'A test description.');
    await tester.ensureVisible(find.text('Add Book'));
    await tester.tap(find.text('Add Book'));
    await tester.pumpAndSettle();

    expect(find.text('Test Book'), findsOneWidget);
  });
}
