import 'package:contacts_app/hive/contacts.dart';
import 'package:contacts_app/provider/db_provider.dart';
import 'package:contacts_app/screens/contact_details_screen.dart';
import 'package:contacts_app/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'addContact_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box contactsBox;

   @override
  void initState() {
    super.initState();
    // get the previously opened user box
    contactsBox = Hive.box<Contacts>('contacts');
  }
  @override
    void dispose() {
      Hive.close();
      super.dispose();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchWidget(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: buildList(context, contactsBox),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddContacts(),
            ),
          );
        },
        child: Icon(Icons.add),
        elevation: 1.0,
      ),
    );
  }
}

Widget buildList(BuildContext context, Box contactsBox ) {
  DatabaseProvider databaseProvider =
      Provider.of<DatabaseProvider>(context, listen: false);

  return ValueListenableBuilder(
      valueListenable: contactsBox.listenable(),
      builder: (context, contactsBox, _) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: contactsBox.length,
          itemBuilder: (context, index) {
            final contact = contactsBox.getAt(index) as Contacts;
            // with get we can get data from HiveDb, and pass index as 'key'
            return ListTile(
              onTap: () {
                databaseProvider.updateSelectedIndex(index);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ContactDetailsScreen(),
                  ),
                );
              },
              onLongPress: (){
                ///* this will delete that contact from hive
                 databaseProvider.updateSelectedIndex(index);
                databaseProvider.deleteFromHive();
              },
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 20,
                backgroundImage: NetworkImage(contact.imageURL),
              ),
              title: Text(contact.name,
                  style: Theme.of(context).textTheme.bodyText1),
              subtitle: Text(contact.number,
                  style: Theme.of(context).textTheme.subtitle1),
            );
          },
        );
      });
}
