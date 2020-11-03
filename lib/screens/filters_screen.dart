import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String,bool> currentFilters;
  FiltersScreen(this.currentFilters,this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool gluttenFree=false;
  bool lactoseFree=false;
  bool vegan=false;
  bool vegetarian=false;
  @override
  initState(){
    gluttenFree=widget.currentFilters['glutten'];
    lactoseFree=widget.currentFilters['lactose'];
    vegan=widget.currentFilters['vegan'];
    vegetarian=widget.currentFilters['vegetarian'];
    super.initState();
  }

Widget buildSwitchTile(String title,String description,bool substance,Function toggle){
return SwitchListTile(
  title: Text(title),
  subtitle: Text(description),
  value: substance,
  onChanged: toggle,
);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(icon: Icon(Icons.save),
onPressed: (){
            final selectedFilters={
              'glutten':gluttenFree,
              'lactose':lactoseFree,
              'vegan':vegan,
              'vegetarian':vegetarian,
            };
            widget.saveFilters(selectedFilters);
},
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
Container(
  padding: EdgeInsets.all(20),
  child: Text('Adjust your meal selections',style: Theme.of(context).textTheme.title,),
),
          Expanded(child: ListView(
            children: [
              buildSwitchTile('Glutten Free', 'Only includes glutten-free meals',gluttenFree, (newValue){
                setState(() {
                  gluttenFree=newValue;
                });
              }),
              buildSwitchTile('Lactose Free', 'Only includes lactose-free meals',lactoseFree, (newValue){
                setState(() {
                  lactoseFree=newValue;
                });
              }),
              buildSwitchTile('Vegan', 'Only includes vegan meals',vegan, (newValue){
                setState(() {
                  vegan=newValue;
                });
              }),
              buildSwitchTile('Vegetarian', 'Only includes Vegeterian meals',vegetarian, (newValue){
                setState(() {
                  vegetarian=newValue;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
