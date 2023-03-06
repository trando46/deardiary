import 'package:deardiary/models/journalentry.dart';
import 'package:deardiary/widgets/journalentry_display_entry_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      body: DisplayJournalEntryWidget(entry: entry),
      // body: Row(
      //   children: [
      //     const SizedBox(width: 20),
      //     Expanded(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             'Title: ${entry.journalEntryTitle}',
      //             style: TextStyle(
      //               fontWeight: FontWeight.bold,
      //               color: Theme.of(context).primaryColor,
      //               fontSize: 30,
      //             ),
      //           ),

      //           Container(
      //             margin: const EdgeInsets.only(top: 15),
      //             child: Text(
      //               'Created Date: ${entry.journalEntryCreationDate}',
      //               style: const TextStyle(
      //                 fontSize: 17,
      //               ),
      //             ),
      //           ),

      //           if (entry.journalEntryLastUpdate.toString().isNotEmpty)
      //             Container(
      //               margin: const EdgeInsets.only(top: 15),
      //               child: Text(
      //                 'Last Updated: ${entry.journalEntryLastUpdate}',
      //                 style: const TextStyle(
      //                   fontSize: 17,
      //                 ),
      //               ),
      //             ),

      //           Container(
      //             height: 120,
      //             width: 120,
      //             color: Colors.black38,
      //             child: entry.journalEntryImage == ''
      //                 ? const Icon(
      //                     Icons.image,
      //                   )
      //                 : Image.memory(base64Decode(entry.journalEntryImage)),
      //           ),

      //           //If we have the description we want to display the description
      //           if (entry.journalEntryContent.isNotEmpty)
      //             Container(
      //               margin: const EdgeInsets.only(top: 15),
      //               child: Text(
      //                 'Description: ${entry.journalEntryContent}',
      //                 style: const TextStyle(
      //                   fontSize: 22,
      //                 ),
      //               ),
      //             ),

      //           if (entry.journalEntryGeo.isNotEmpty)
      //             Container(
      //               margin: const EdgeInsets.only(top: 15),
      //               constraints: const BoxConstraints(
      //                 maxHeight: 261,
      //                 maxWidth: 261,
      //               ),
      //               child: Center(
      //                 child: _buildMap(),
      //               ),

      //               // child: Text(
      //               //   'Location: \n- Latitude = ${entry.journalEntryGeo.split(',')[0]}\n- Longitude = ${entry.journalEntryGeo.split(',')[1]}',
      //               //   style: const TextStyle(
      //               //     fontSize: 22,
      //               //   ),
      //               // ),
      //             ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
