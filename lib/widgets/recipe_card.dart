import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/recipe.dart';
import '../screens/recipe_detail_screen.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  RecipeCard({required this.recipe});

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  late Box favoritesBox;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box('favoritesBox');
    isFavorite = _checkIfFavorite();
  }

  bool _checkIfFavorite() {
    return favoritesBox.values.any((r) =>
    r['name'] == widget.recipe.name &&
        r['description'] == widget.recipe.description);
  }

  void _toggleFavorite() {
    setState(() {
      if (isFavorite) {
        final keyToRemove = favoritesBox.keys.firstWhere(
              (key) {
            final item = favoritesBox.get(key);
            return item['name'] == widget.recipe.name &&
                item['description'] == widget.recipe.description;
          },
          orElse: () => null,
        );
        if (keyToRemove != null) {
          favoritesBox.delete(keyToRemove);
        }
        isFavorite = false;
      } else {
        favoritesBox.add(widget.recipe.toJson());
        isFavorite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecipeDetailScreen(recipe: widget.recipe),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      image: DecorationImage(
                        image: NetworkImage(widget.recipe.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.recipe.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
