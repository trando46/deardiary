import 'package:deardiary/models/journalentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:deardiary/providers/journalentry_provider.dart';
import 'package:provider/provider.dart';

/***
 * This class is for getting the status of number of entries per month and total
 * entries count and display the counts for the current year.
 */
class DisplayStatsOfEntiresWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Call the provider
    final List<JournalEntryModel> entries = Provider.of<JournalEntryProvider>(context).allJournalEntries;

    // Individual count per month
    int jan =_getCount(1, entries);
    int feb = _getCount(2, entries);
    int march = _getCount(3, entries);
    int april = _getCount(4, entries);
    int may = _getCount(5, entries);
    int june = _getCount(6, entries);
    int july = _getCount(7, entries);
    int august = _getCount(8, entries);
    int sept = _getCount(9, entries);
    int oct = _getCount(10, entries);
    int nov = _getCount(11, entries);
    int dec = _getCount(12, entries);

    // Getting the total count of the year
    int totalEntriesPerYear = jan + feb + march + april + may + june + july + august + sept + oct + nov + dec;

    return ListView(
      children: [

        Container(height: 5),

        Text(_getYear(entries).toString() + " Entry Status", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
          color: Colors.white,

        ),),

        Container(height: 15),

        Text("January: " +jan.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("February: " + feb.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("March: " + march.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("April: " + april.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("May: " + may.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("June: " + june.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("July: " + july.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("August: " + august.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("September: " + sept.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("October: " + oct.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("November: " + nov.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 7),

        Text("December: " + dec.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),

        Container(height: 20),

        Text("Total Count = " + totalEntriesPerYear.toString(), style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 28,
        ),),

        ],
    );


  }

  /**
   * Get the count of entries per month
   */
  int _getCount(int month, List<JournalEntryModel> entries){

    int counter = 0;
    for(int i= 0; i < entries.length; i++){
      if(month == entries[i].journalEntryCreationDate.month)
        counter++;
    }
    return counter;
  }

  /**
   * Get the current year of the entries
   */
  int _getYear(List<JournalEntryModel> entries){
    int year = 0;
    for(int i= 0; i < entries.length; i++){
      year = entries[i].journalEntryCreationDate.year;
    }
    return year;
  }

}