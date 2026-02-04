import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c17/core/models/event_model.dart';
import 'package:evently_c17/core/remote/firebase/firebase_manager.dart';
import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../core/reusable/event_item.dart';

class ExhibitionTab extends StatelessWidget {
  const ExhibitionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseManager.getEventsByType("Exhibition"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text("No Events Found"));
        }
        return ListView.separated(
            itemBuilder: (context, index) => EventItem(
              event: snapshot.data?[index] ?? EventModel(),
            ),
            separatorBuilder: (context, index) => SizedBox(height: 16,),
            itemCount: snapshot.data!.length
        );
      },
    );
  }
}
