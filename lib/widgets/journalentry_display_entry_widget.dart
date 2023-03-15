import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../models/journalentry.dart';

class DisplayJournalEntryWidget extends StatelessWidget {
  final JournalEntryModel entry;

  const DisplayJournalEntryWidget({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _buildTitleRow(context),
            const SizedBox(height: 15),
            _buildContentRow(context),
            const SizedBox(height: 15),
            _buildImageRow(context),
            if (entry.journalEntryImage.isNotEmpty) _buildImageDisplay(),
            const SizedBox(height: 15),
            _buildGeolocationRow(context),
            if (entry.journalEntryGeo.isNotEmpty) _buildGeolocationDisplay(),
            const SizedBox(height: 15),
            _buildCreatedDateRow(context),
            _buildLastUpdateRow(context),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Exit"),
            )
          ],
        )
      );
  }

  Widget _buildTitleRow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Title:\t',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 30,
          ),
        ),
        Text(
          entry.journalEntryTitle,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).primaryColor,
            fontSize: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildContentRow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Content:\t',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 25,
          ),
        ),
        Text(
          entry.journalEntryContent,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).primaryColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _buildCreatedDateRow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Created Date: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 17,
          ),
        ),
        Text(
          entry.journalEntryCreationDate.toString(),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).primaryColor,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  Widget _buildLastUpdateRow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Last Update: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 17,
          ),
        ),
        Text(
          entry.journalEntryLastUpdate.toString(),
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).primaryColor,
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  Widget _buildImageRow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Image:\t',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 25,
          ),
        ),
        if (entry.journalEntryImage.isEmpty)
          Text(
            'No Image Attached',
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          )
      ],
    );
  }

  Widget _buildImageDisplay() {
    Image img = Image.memory(base64Decode(entry.journalEntryImage));
    return SizedBox(
      height: 200,
      width: 200,
      child: img,
    );
  }

  Widget _buildGeolocationRow(BuildContext context) {
    return Row(
      children: [
        Text(
          'Location: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 25,
          ),
        ),
        if (entry.journalEntryGeo.isEmpty)
          Text(
            'No location attached',
            softWrap: true,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          )
      ],
    );
  }

  Widget _buildGeolocationDisplay() {
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

    return Container(
      constraints: const BoxConstraints(
        maxHeight: 261,
        maxWidth: 261,
      ),
      child: FlutterMap(
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
      ),
    );
  }
}
