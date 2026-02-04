import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c17/core/models/event_model.dart';
import 'package:evently_c17/core/providers/user_provider.dart';

import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:evently_c17/ui/event_details/screen/event_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../resources/colors_manager.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.event});
  final EventModel event;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: Container(
        height: height * 0.25,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorsManager.fieldBorder),
        ),
        child: Stack(
          children: [
            Image.asset(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorsManager.fieldBorder,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      DateFormat.MMMMd()
                          .format(event.date?.toDate() ?? DateTime.now())
                          .toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColorsManager.fieldBorder,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            event.title ?? "",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (userProvider.user?.favorites?.contains(
                                  event.id,
                                ) ??
                                false) {
                              userProvider.removeFavorite(event);
                            } else {
                              userProvider.addFavorite(event);
                            }
                          },
                          child: SvgPicture.asset(
                            userProvider.user?.favorites?.contains(event.id) ??
                                    false
                                ? AssetsManager.heart_selected
                                : AssetsManager.heart,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
