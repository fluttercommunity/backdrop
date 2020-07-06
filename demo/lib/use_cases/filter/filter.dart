import 'package:backdrop/backdrop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Filter preview app.
class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  static const List<ItemCategory> _CATEGORIES = [
    ItemCategory.Electronics,
    ItemCategory.Transportation
  ];
  static const List<Item> _ITEMS = [
    Item(Icons.computer, "Laptop", ItemCategory.Electronics),
    Item(Icons.child_friendly, "Stroller", ItemCategory.Transportation),
    Item(Icons.tv, "TV", ItemCategory.Electronics),
    Item(Icons.smartphone, "Smartphone", ItemCategory.Electronics),
    Item(Icons.directions_car, "Car", ItemCategory.Transportation),
    Item(Icons.motorcycle, "Motorcycle", ItemCategory.Transportation),
  ];
  Set<ItemCategory> _filteredCategories =
      Set.from([ItemCategory.Electronics, ItemCategory.Transportation]);
  List<Item> _shownItems;

  @override
  void initState() {
    _filterItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filter',
      debugShowCheckedModeBanner: false,
      home: BackdropScaffold(
        appBar: BackdropAppBar(
          title: Text("Filter Example"),
        ),
        backLayer: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Check/uncheck categories to show/hide them on the front layer",
              ),
            ),
            ListView.builder(
              itemCount: _CATEGORIES.length,
              itemBuilder: (context, index) => CheckboxListTile(
                onChanged: (bool checked) =>
                    _addOrRemoveFilterCategory(checked, _CATEGORIES[index]),
                value: _filteredCategories.contains(_CATEGORIES[index]),
                title: Text(describeEnum(_CATEGORIES[index].toString())),
                activeColor: Colors.white,
                checkColor: Theme.of(context).primaryColor,
              ),
              shrinkWrap: true,
            ),
          ],
        ),
        subHeader: BackdropSubHeader(
          title: Text("${_shownItems.length} Items"),
        ),
        frontLayer: ListView.builder(
          itemCount: _shownItems.length,
          itemBuilder: (context, index) => ListTile(
            leading: Icon(_shownItems[index].icon),
            title: Text(_shownItems[index].name),
          ),
          shrinkWrap: true,
        ),
      ),
    );
  }

  void _filterItems() {
    setState(() {
      _shownItems = _ITEMS
          .where((element) => _filteredCategories.contains(element.category))
          .toList();
    });
  }

  void _addOrRemoveFilterCategory(bool checked, ItemCategory category) {
    if (checked) {
      setState(() {
        _filteredCategories.add(category);
      });
    } else {
      setState(() {
        _filteredCategories.remove(category);
      });
    }

    _filterItems();
  }
}

/// Enum defining the different item categories we have.
enum ItemCategory {
  /// Electronics item category.
  Electronics,

  /// Transportation item category.
  Transportation
}

/// Class representing an online shop item.
class Item {
  /// The icon (photo) of the item.
  final IconData icon;

  /// The name of the item.
  final String name;

  /// The category the item belongs to.
  final ItemCategory category;

  /// Creates an instance of Item with the given attributes.
  const Item(this.icon, this.name, this.category);
}
