import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_places.dart';
import '../screens/add_place_screen.dart';
import '../screens/place_detail_screen.dart';

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
      body: FutureBuilder(
        future:
            Provider.of<UserPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? CircularProgressIndicator()
            : Consumer<UserPlaces>(
                child: Center(
                  child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, userPlaces, ch) => userPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemCount: userPlaces.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: Hero(
                            tag: userPlaces.items[i].id,
                            child: CircleAvatar(
                              backgroundImage:
                                  FileImage(userPlaces.items[i].image),
                            ),
                          ),
                          title: Text(userPlaces.items[i].title),
                          subtitle: Text(userPlaces.items[i].location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                PlaceDetailScreen.routeName,
                                arguments: userPlaces.items[i].id);
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
