import 'package:flutter/material.dart';
import 'package:flutter_places_app/providers/user_places.dart';
import 'package:flutter_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              })
        ],
      ),
      body: Consumer<UserPlaces>(
        child: Center(
          child: const Text('Got no places yet, start adding some!'),
        ),
        builder: (ctx, userPlaces, ch) => userPlaces.items.length <= 0
            ? ch
            : ListView.builder(
                itemCount: userPlaces.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(userPlaces.items[i].image),
                  ),
                  title: Text(userPlaces.items[i].title),
                  onTap: () {
                    //go to detail page
                  },
                ),
              ),
      ),
    );
  }
}
