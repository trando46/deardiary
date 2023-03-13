import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';

import '../models/journalentry.dart';
import '../providers/journalentry_provider.dart';

class EditJournalEntryWidget extends StatefulWidget {
  const EditJournalEntryWidget({
    super.key,
    required this.entry,
    required this.onChangedTitle,
    required this.onChangedContent,
    required this.onChangedImage,
    required this.onSave,
    required this.onChangedGeo,
  });

  final JournalEntryModel entry;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedContent;
  final ValueChanged<String> onChangedImage;
  final ValueChanged<String> onChangedGeo;
  final VoidCallback onSave;

  @override
  State<EditJournalEntryWidget> createState() => _EditJournalEntryWidgetState();
}

class _EditJournalEntryWidgetState extends State<EditJournalEntryWidget> {
  late JournalEntryModel entry;
  late ValueChanged<String> onChangedTitle;
  late ValueChanged<String> onChangedContent;
  late ValueChanged<String> onChangedImage;
  late ValueChanged<String> onChangedGeo;
  late VoidCallback onSave;

  late String geolocation;
  int _radioValue = 0;

  @override
  void initState() {
    super.initState();
    entry = widget.entry;
    onChangedTitle = widget.onChangedTitle;
    onChangedContent = widget.onChangedContent;
    onChangedImage = widget.onChangedImage;
    onSave = widget.onSave;
    onChangedGeo = widget.onChangedGeo;
    geolocation = entry.journalEntryGeo;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(),
            const SizedBox(height: 20),
            _buildContent(),
            // const SizedBox(height: 20),
            // _buildImageRow(context),
            // const SizedBox(height: 10),
            // if (entry.journalEntryImage != '') _buildImageDisplay(context),
            const SizedBox(height: 20),
            _buildGeolocationRow(context),
            if (entry.journalEntryGeo.isNotEmpty) _buildGeolocationDisplay(),
            if (entry.journalEntryGeo.isNotEmpty)
              _buildUpdateGeolocationButton(context),

            const SizedBox(height: 20),
            _buildCreatedDateText(),
            const SizedBox(height: 20),
            _buildLastUpdatedText(),
            const SizedBox(height: 20),
            _buildButtonRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() => TextFormField(
        initialValue: entry.journalEntryTitle,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Title',
        ),
        onChanged: onChangedTitle,
      );

  Widget _buildContent() => TextFormField(
        initialValue: entry.journalEntryContent,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Content',
        ),
        onChanged: onChangedContent,
      );

  Widget _buildCreatedDateText() {
    return Text.rich(
      TextSpan(
        text: "Created: ",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: entry.journalEntryCreationDate.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastUpdatedText() {
    return Text.rich(
      TextSpan(
        text: "Last Update: ",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: entry.journalEntryLastUpdate.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() => ElevatedButton(
        key: const Key("EditSaveButton"),
        onPressed: onSave,
        child: const Text('Save'),
      );

  Widget _buildCancelButton(BuildContext context) => ElevatedButton(
        key: const Key("EditCancelButton"),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'),
      );

  Widget _buildButtonRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCancelButton(context),
          _buildSaveButton(),
        ],
      );

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

  Widget _buildUpdateGeolocationButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final Position position = await _determinePosition();
        geolocation = '${position.latitude},${position.longitude}';
        setState(() {
          updateGeolocation(context);
        });
      },
      child: const Text('Update Location'),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void updateGeolocation(BuildContext context) {
    final provider = Provider.of<JournalEntryProvider>(context, listen: false);
    provider.updateJournalEntryGeo(entry, geolocation);
  }
}
