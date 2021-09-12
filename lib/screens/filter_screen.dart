import 'package:flutter/material.dart';
import 'package:meal_application/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static final String routeName = 'filter_screen';
  final Function _setFilters;
  final _currentFilters;
  FilterScreen(this._currentFilters, this._setFilters);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget._currentFilters['gluten'];
    _vegan = widget._currentFilters['vegan'];
    _lactoseFree = widget._currentFilters['lactose'];
    _vegetarian = widget._currentFilters['vegetarian'];
    super.initState();
  }

  Widget buildSwtichListTile(
      String title, String desc, bool currentVal, Function func) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(desc),
      value: currentVal,
      onChanged: func,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Text("Customize your meal options",style: TextStyle(fontSize: 25),),
          Expanded(
            child: ListView(
              children: [
                buildSwtichListTile(
                  "Gluten-Free",
                  "Only show gluten free meals",
                  _glutenFree,
                  (newVal) {
                    setState(() {
                      _glutenFree = newVal;
                    });
                  },
                ),
                buildSwtichListTile(
                  "Lactose-Free",
                  "Only show lactose free meals",
                  _lactoseFree,
                  (newVal) {
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  },
                ),
                buildSwtichListTile(
                  "Vegan",
                  "Only show vegan meals",
                  _vegan,
                  (newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  },
                ),
                buildSwtichListTile(
                  "Vegetarian",
                  "Only show vegetarian meals",
                  _vegetarian,
                  (newVal) {
                    setState(() {
                      _vegetarian = newVal;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedfilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget._setFilters(selectedfilters);
              // Navigator.of(context).pop();
            },
          )
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
