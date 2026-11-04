import 'package:my_portfolio/models/hobby_category.dart';

/// Un hobby de la lista del CRUD. Es inmutable (todo final).
class Hobby {
  const Hobby({
    required this.name,
    required this.description,
    required this.category,
  });

  final String name;
  final String description;
  final HobbyCategory category;
}
