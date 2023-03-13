import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:io';

import '../models/journalentry.dart';
import '../providers/journalentry_provider.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

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
  late String image;

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
    image = entry.journalEntryImage;
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
            if (entry.journalEntryGeo.isEmpty)
              _buildAddGeolocationButton(context),
            if (entry.journalEntryGeo.isNotEmpty) _buildGeolocationDisplay(),
            if (entry.journalEntryGeo.isNotEmpty)
              _buildRemoveAndUpdateGeolocationRow(context),
            const SizedBox(height: 20),
            _buildImageRow(context),
            if (entry.journalEntryImage.isNotEmpty) _buildImageDisplay(context),

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
        maxLines: 4,
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

  Row _buildImageRow(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Images:    ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildCaptureImageButton(context, entry, image),
        _buildAttachImageButton(context, entry, image),
        if (entry.journalEntryImage.isNotEmpty)
          _buildRemoveImageButton(context),
      ],
    );
  }

  Widget _buildRemoveImageButton(context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        setState(() {
          image = '';
          updateImage(context);
        });
      },
    );
  }

  Widget _buildCaptureImageButton(
          BuildContext context, JournalEntryModel entry, String img) =>
      IconButton(
        icon: const Icon(Icons.camera_alt),
        onPressed: () async {
          _getFromCamera();
          // if (img != File('')) {
          //   addTaskImage(context, task, img);
          // }
        },
      );

  Widget _buildAttachImageButton(
          BuildContext context, JournalEntryModel entry, String img) =>
      IconButton(
        icon: const Icon(Icons.attach_file),
        onPressed: () async {
          _getFromGallery();
          // if (img != File('')) {
          //   addTaskImage(context, task, img);
          // }
        },
      );

  Widget _buildImageDisplay(BuildContext context) {
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

  Widget _buildAddGeolocationButton(BuildContext context) => ElevatedButton(
        key: const Key("EditAddGeolocationButton"),
        onPressed: () async {
          final location = await _determinePosition();
          setState(() {
            geolocation = "${location.latitude}, ${location.longitude}";
            updateGeolocation(context);
          });
        },
        child: const Text('Add Location'),
      );

  Widget _buildRemoveGeolocationButton(BuildContext context) => ElevatedButton(
        key: const Key("EditRemoveGeolocationButton"),
        onPressed: () async {
          setState(() {
            geolocation = "";
            updateGeolocation(context);
          });
        },
        child: const Text('Remove Location'),
      );

  Widget _buildRemoveAndUpdateGeolocationRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildRemoveGeolocationButton(context),
        _buildUpdateGeolocationButton(context),
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

  void _getFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(
        () async {
          File filename = File(pickedFile.path);
          File compressedFile = await FlutterNativeImage.compressImage(
            filename.path,
            quality: 50,
            percentage: 50,
          );
          List<int> name = compressedFile.readAsBytesSync();
          image = base64Encode(name);
          updateImage(context);
        },
      );
    }
  }

  void _getFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(
        () async {
          File filename = File(pickedFile.path);
          File compressedFile = await FlutterNativeImage.compressImage(
            filename.path,
            quality: 50,
            percentage: 50,
          );
          List<int> name = compressedFile.readAsBytesSync();
          image = base64Encode(name);
          updateImage(context);
        },
      );
    }
  }

  void updateGeolocation(BuildContext context) {
    final provider = Provider.of<JournalEntryProvider>(context, listen: false);
    provider.updateJournalEntryGeo(entry, geolocation);
  }

  void updateImage(BuildContext context) {
    final provider = Provider.of<JournalEntryProvider>(context, listen: false);
    provider.updateJournalEntryImage(entry, image);
  }
}
