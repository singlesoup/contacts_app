import 'package:contacts_app/hive/contacts.dart';
import 'package:contacts_app/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactDetailsScreen extends StatefulWidget {
  @override
  _ContactDetailsScreenState createState() => _ContactDetailsScreenState();
}

class _ContactDetailsScreenState extends State<ContactDetailsScreen> {
  Contacts selectedContact;
  DatabaseProvider databaseProvider;

  @override
  Widget build(BuildContext context) {
    databaseProvider = Provider.of<DatabaseProvider>(context);
    selectedContact = databaseProvider.selectedContact;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedContact.name),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.chevron_left),
        ),
      ),
      body: Center(
        child: Container(
          child: ListTile(
            onTap: () {
              print('tapped');
            },
            leading: CircleAvatar(
              backgroundColor: Colors.teal,
              radius: 20,
              backgroundImage: NetworkImage(selectedContact.imageURL),
            ),
            title: Text(selectedContact.name,
                style: Theme.of(context).textTheme.bodyText1),
            subtitle: Text(selectedContact.number,
                style: Theme.of(context).textTheme.subtitle1),
          ),
        ),
      ),
    );
  }
}
