import 'package:flutter/material.dart';

import '../model/recipe.dart';
import 'recipe_details_view.dart';

class RecipeGridView extends StatelessWidget {
  const RecipeGridView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Text('Mau masak apa hari ini?',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 40)),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth <= 600) {
                return const RecipeGrid(gridNumber: 2);
              } else if (constraints.maxWidth <= 1200) {
                return const RecipeGrid(gridNumber: 3);
              } else {
                return const RecipeGrid(gridNumber: 6);
              }
            }),
          ))
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}

class RecipeGrid extends StatelessWidget {
  final int gridNumber;

  const RecipeGrid({
    super.key,
    required this.gridNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      restorationId: 'recipeGridView',
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridNumber, crossAxisSpacing: 8, mainAxisSpacing: 8),
      itemCount: recipeList.length,
      itemBuilder: (BuildContext context, int index) {
        final item = recipeList[index];

        return GridTile(
          child: Card(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RecipeDetailsView(
                    recipe: item,
                  );
                }));
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(item.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.bar_chart, color: Colors.white),
                              Text(
                                item.level,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timer, color: Colors.white),
                              Text(
                                item.time,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
