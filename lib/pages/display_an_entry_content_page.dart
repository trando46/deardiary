import 'package:deardiary/models/journalentry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:latlong2/latlong.dart'; // Suitable for most situations
//import 'package:latlng/latlng.dart';

class DisplayAnEntryContentPage extends StatelessWidget {
  final JournalEntryModel entry;

  DisplayAnEntryContentPage({
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("DisplayAnEntryContentPage: ${entry.journalEntryGeo}");
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Entry'),
      ),
      extendBody: true,
      body: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title: ${entry.journalEntryTitle}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 30,
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Created Date: ${entry.journalEntryCreationDate}',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),

                if (entry.journalEntryLastUpdate.toString().isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Last Updated: ${entry.journalEntryLastUpdate}',
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),

                Container(
                  height: 120,
                  width: 120,
                  color: Colors.black38,
                  child: entry.journalEntryImage == ''
                      ? const Icon(
                          Icons.image,
                        )
                      : Image.memory(base64Decode(entry.journalEntryImage)),
                ),

                //If we have the description we want to display the description
                if (entry.journalEntryContent.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Description: ${entry.journalEntryContent}',
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),

                if (entry.journalEntryGeo.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    constraints: const BoxConstraints(
                      maxHeight: 261,
                      maxWidth: 261,
                    ),
                    child: Center(
                      child: _buildMap(),
                    ),

                    // child: Text(
                    //   'Location: \n- Latitude = ${entry.journalEntryGeo.split(',')[0]}\n- Longitude = ${entry.journalEntryGeo.split(',')[1]}',
                    //   style: const TextStyle(
                    //     fontSize: 22,
                    //   ),
                    // ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    final double latitude;
    final double longitude;
    try {
      latitude = double.tryParse(entry.journalEntryGeo.split(',')[0])!;
      longitude = double.tryParse(entry.journalEntryGeo.split(',')[1])!;
    } catch (e) {
      return Text(
          'Location: \n- Latitude = ${entry.journalEntryGeo.split(',')[0]}\n- Longitude = ${entry.journalEntryGeo.split(',')[1]}');
    }

    final LatLng cord = LatLng(latitude, longitude);
    return FlutterMap(
      options: MapOptions(
        center: cord,
        zoom: 13,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: cord,
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
