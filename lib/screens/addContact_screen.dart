import 'package:contacts_app/hive/contacts.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddContacts extends StatefulWidget {
  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  String _imgURL = '';
  String _name;
  String _number;
  String _tempurl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: _imgURL.isEmpty
                          ? NetworkImage(_tempurl)
                          : NetworkImage(_imgURL),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Contact\'s name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onChanged: (val) => _name = val,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Number',
                        hintText: 'phone number?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onChanged: (val) => _number = val,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                        hintText: 'paste it here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _imgURL = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      color: Colors.teal,
                      onPressed: () {
                        final newContact = Contacts(
                            name: _name, number: _number, imageURL: _imgURL);
                        _submit(newContact);
                      },
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(Contacts contact) {
    print(' url :$_imgURL ,  name: $_name , number: $_number ');
    final contactBox = Hive.box<Contacts>('contacts');
    contactBox.add(contact);
    Navigator.of(context).pop();
  }
}
