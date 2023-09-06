import 'package:backdrop/backdrop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Filter preview app.
class Filter extends StatefulWidget {
  /// Default constructor for [Filter].
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  static const List<ItemCategory> _categories = [
    ItemCategory.electronics,
    ItemCategory.transportation
  ];
  static const List<Item> _items = [
    Item(Icons.computer, "Laptop", ItemCategory.electronics),
    Item(Icons.child_friendly, "Stroller", ItemCategory.transportation),
    Item(Icons.tv, "TV", ItemCategory.electronics),
    Item(Icons.smartphone, "Smartphone", ItemCategory.electronics),
    Item(Icons.directions_car, "Car", ItemCategory.transportation),
    Item(Icons.motorcycle, "Motorcycle", ItemCategory.transportation),
  ];
  final _filteredCategories = <ItemCategory>{
    ItemCategory.electronics,
    ItemCategory.transportation
  };
  late List<Item> _shownItems;

  @override
  void initState() {
    _filterItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: BackdropScaffold(
        appBar: BackdropAppBar(
          title: const Text("Filter Example"),
        ),
        backLayer: _createBackLayer(),
        subHeader: BackdropSubHeader(
          title: Text("${_shownItems.length} Items"),
        ),
        frontLayer: _createFrontLayer(context),
        stickyFrontLayer: true,
      ),
    );
  }

  Widget _createFrontLayer(BuildContext context) => ListView.builder(
        itemCount: _shownItems.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(_shownItems[index].icon),
          title: Text(_shownItems[index].name),
        ),
        shrinkWrap: true,
      );

  Widget _createBackLayer() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "Check/uncheck categories to show/hide them on the front layer",
            ),
          ),
          ListView.builder(
            itemCount: _categories.length,
            itemBuilder: (context, index) => CheckboxListTile(
              onChanged: (bool? checked) =>
                  _addOrRemoveFilterCategory(checked!, _categories[index]),
              value: _filteredCategories.contains(_categories[index]),
              title: Text(describeEnum(_categories[index].toString())),
              activeColor: Colors.white,
              checkColor: Theme.of(context).primaryColor,
            ),
            shrinkWrap: true,
          ),
        ],
      );

  void _filterItems() {
    setState(() {
      _shownItems = _items
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
  electronics,

  /// Transportation item category.
  transportation
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
