import 'package:contacts_app/hive/contacts.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DatabaseProvider extends ChangeNotifier {
  
  int _selectedIndex = 0;

  Box<Contacts> _contactsBox = Hive.box<Contacts>('contacts');

  Contacts _selectedContact = Contacts();

  Box<Contacts> get contactsBox => _contactsBox;

  Contacts get selectedContact => _selectedContact;

  ///* Updating the current selected index for that contact to pass to read from hive
  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    updateSelectedContact();
    notifyListeners();
  }

  ///* Updating the current selected contact from hive
  void updateSelectedContact() {
    _selectedContact = readFromHive();
    notifyListeners();
  }

  ///* reading the current selected contact from hive
  Contacts readFromHive() {
    Contacts getContact = _contactsBox.getAt(_selectedIndex);

    return getContact;
  }

  void deleteFromHive(){
    _contactsBox.deleteAt(_selectedIndex);
  }
}
