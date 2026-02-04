import 'package:evently_c17/core/models/event_model.dart';
import 'package:evently_c17/core/remote/firebase/firebase_manager.dart';
import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:evently_c17/core/resources/strings_manager.dart';
import 'package:evently_c17/core/reusable/custom_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/reusable/event_item.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  late TextEditingController searchController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomField(
                controller:searchController ,
                hint: StringsManager.searchHint,
                suffix: AssetsManager.search,
                validator: (value) => null ,
            ),
            SizedBox(height: 16,),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseManager.getFavoriteEvents(),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
