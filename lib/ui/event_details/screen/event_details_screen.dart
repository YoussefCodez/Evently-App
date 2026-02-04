import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c17/core/models/event_model.dart';
import 'package:evently_c17/core/providers/edit_provider.dart';
import 'package:evently_c17/core/remote/firebase/firebase_manager.dart';
import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:evently_c17/ui/add_event/screen/add_event_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key, required this.event});
  final EventModel event;
  @override
  Widget build(BuildContext context) {
    ColorScheme color = Theme.of(context).colorScheme;
    return ChangeNotifierProvider(
      create: (context) => EditProvider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                splashColor: Colors.transparent,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.onSurface,
                    border: Border.all(color: color.surface),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: color.primary,
                    size: 20,
                  ),
                ),
              ),
              title: Text(
                "Event Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: color.onSurfaceVariant,
                ),
              ),
              centerTitle: true,
              actions: [
                if (FirebaseAuth.instance.currentUser!.uid == event.userId)
                  IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Provider.of<EditProvider>(
                        context,
                        listen: false,
                      ).toggleEdit();
                      if (Provider.of<EditProvider>(context, listen: false).editMode) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddEventScreen(event: event),
                          ),
                        );
                      }
                    },
                    padding: EdgeInsets.zero,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.onSurface,
                        border: Border.all(color: color.surface),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        "assets/images/edit.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          color.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                if (FirebaseAuth.instance.currentUser!.uid == event.userId)
                  IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      FirebaseManager.deleteEvent(event.id!);
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.onSurface,
                        border: Border.all(color: color.surface),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        "assets/images/trash.svg",
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            event.type == "Sport"
                                ? AssetsManager.sport_light
                                : event.type == "Meeting"
                                ? AssetsManager.meeting_light
                                : event.type == "Exhibition"
                                ? AssetsManager.exhibition_light
                                : event.type == "Book Club"
                                ? AssetsManager.book_light
                                : AssetsManager.birthday_light,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: color.surface),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        event.title ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: color.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.onSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: color.surface),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: color.onSurface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: color.surface),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/calendar-add.svg",
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                color.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat(
                                  "dd MMMM",
                                ).format(event.date!.toDate()).toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: color.onTertiary,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                DateFormat(
                                  "hh:mm a",
                                ).format(event.date!.toDate()).toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: color.onTertiary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: color.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.onSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: color.surface),
                      ),
                      child: Text(
                        event.description ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: color.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
