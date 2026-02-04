import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c17/core/models/event_model.dart';
import 'package:evently_c17/core/providers/edit_provider.dart';
import 'package:evently_c17/core/remote/firebase/firebase_manager.dart';
import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:evently_c17/core/resources/strings_manager.dart';
import 'package:evently_c17/core/resources/widgets/dialog_utils.dart';
import 'package:evently_c17/core/reusable/custom_button_reusable.dart';
import 'package:evently_c17/core/reusable/custom_field.dart';
import 'package:evently_c17/ui/event_details/screen/event_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evently_c17/core/reusable/back_button.dart' as MyBackButton;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/my_flutter_app_icons.dart';
import '../widgets/tab_view_image.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = "add_event";
  final EventModel? event;
  AddEventScreen({super.key, this.event});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late TextEditingController titleController;
  late TextEditingController descController;
  int selectedIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
    if (widget.event != null) {
      titleController.text = widget.event!.title.toString();
      descController.text = widget.event!.description.toString();
      DateTime dt = widget.event!.date!.toDate();
      selectedDate = dt;
      selectedTime = TimeOfDay.fromDateTime(dt);
      if (widget.event!.type == "Sport") {
        selectedIndex = 0;
      } else if (widget.event!.type == "Birthday") {
        selectedIndex = 1;
      } else if (widget.event!.type == "Book Club") {
        selectedIndex = 2;
      } else if (widget.event!.type == "Exhibition") {
        selectedIndex = 3;
      } else if (widget.event!.type == "Meeting") {
        selectedIndex = 4;
      }
    }
    tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: selectedIndex,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descController.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    ColorScheme color = Theme.of(context).colorScheme;
    return ChangeNotifierProvider(
      create: (context) => EditProvider(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.event != null ? "Edit Event" : StringsManager.addEvent,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                leading: MyBackButton.BackButton(),
                actions: [
                  if (widget.event != null &&
                      FirebaseAuth.instance.currentUser!.uid ==
                          widget.event!.userId)
                    IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        Provider.of<EditProvider>(
                          context,
                          listen: false,
                        ).toggleEdit();
                        if (Provider.of<EditProvider>(
                          context,
                          listen: false,
                        ).editMode) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EventDetailsScreen(event: widget.event!),
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
                  if (widget.event != null &&
                      FirebaseAuth.instance.currentUser!.uid ==
                          widget.event!.userId)
                    IconButton(
                      splashColor: Colors.transparent,
                      onPressed: () {
                        FirebaseManager.deleteEvent(widget.event!.id!);
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
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: DefaultTabController(
                      length: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.25,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: tabController,
                              children: [
                                TabViewImage(AssetsManager.sport_light),
                                TabViewImage(AssetsManager.birthday_light),
                                TabViewImage(AssetsManager.book_light),
                                TabViewImage(AssetsManager.exhibition_light),
                                TabViewImage(AssetsManager.meeting_light),
                              ],
                            ),
                          ),
                          TabBar(
                            onTap: (value) {
                              selectedIndex = value;
                            },
                            controller: tabController,
                            dividerHeight: 0,
                            tabAlignment: TabAlignment.start,
                            labelColor: Colors.white,
                            unselectedLabelColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.tab,
                            unselectedLabelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            labelStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Theme.of(context).primaryColor,
                            ),
                            tabs: [
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(MyFlutterApp.bike),
                                      SizedBox(width: 4),
                                      Text(StringsManager.sport),
                                    ],
                                  ),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(MyFlutterApp.birthday_icon),
                                      SizedBox(width: 4),
                                      Text(StringsManager.birthday),
                                    ],
                                  ),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(MyFlutterApp.book),
                                      SizedBox(width: 4),
                                      Text(StringsManager.bookClub),
                                    ],
                                  ),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(MyFlutterApp.exhibition),
                                      SizedBox(width: 4),
                                      Text(StringsManager.exhibition),
                                    ],
                                  ),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(MyFlutterApp.meeting),
                                      SizedBox(width: 4),
                                      Text(StringsManager.meeting),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            StringsManager.title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          SizedBox(height: 8),
                          CustomField(
                            controller: titleController,
                            hint: StringsManager.eventTitle,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Event Title is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            StringsManager.desc,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          SizedBox(height: 8),
                          CustomField(
                            controller: descController,
                            hint: StringsManager.eventDesc,
                            maxLines: 6,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Event Description is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManager.date,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                StringsManager.eventDate,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  chooseDate();
                                },
                                child: Text(
                                  selectedDate == null
                                      ? StringsManager.chooseDate
                                      : DateFormat.yMMMd().format(
                                          selectedDate!,
                                        ),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AssetsManager.time,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.primary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                StringsManager.eventTime,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  chooseTime();
                                },
                                child: Text(
                                  selectedTime == null
                                      ? StringsManager.chooseTime
                                      : "${selectedTime!.hourOfPeriod}:${selectedTime!.minute} ${selectedTime!.period.name.toUpperCase()}",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              title: widget.event != null
                                  ? "Edit Event"
                                  : StringsManager.addEvent,
                              onClick: () {
                                addNewEvent();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  addNewEvent() async {
    if (formKey.currentState!.validate()) {
      if (selectedDate == null || selectedTime == null) {
        DialogUtils.showMessageDialog(context, "Please select date and time");
        return;
      }
      try {
        if (tabController.length > 0) {
          selectedIndex = tabController.index;
        }

        EventModel eventModel = EventModel(
          userId: FirebaseAuth.instance.currentUser!.uid,
          description: descController.text,
          title: titleController.text,
          type: selectedIndex == 0
              ? "Sport"
              : selectedIndex == 1
              ? "Birthday"
              : selectedIndex == 2
              ? "Book Club"
              : selectedIndex == 3
              ? "Exhibition"
              : "Meeting",
          date: Timestamp.fromDate(
            DateTime(
              selectedDate!.year,
              selectedDate!.month,
              selectedDate!.day,
              selectedTime!.hour,
              selectedTime!.minute,
            ),
          ),
          time: selectedTime!.format(context),
        );

        if (widget.event != null) {
          eventModel.id = widget.event!.id;
          await FirebaseManager.updateEvent(widget.event!.id!, eventModel);
          DialogUtils.showToast("Event Updated Successfully");
        } else {
          await FirebaseManager.addEvent(eventModel);
          DialogUtils.showToast("Event Added Successfully");
        }

        Navigator.pop(context);
      } catch (e) {
        DialogUtils.showMessageDialog(context, e.toString());
      }
    }
  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  chooseDate() async {
    DateTime? newDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedDate ?? DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (newDate != null) {
      setState(() {
        selectedDate = newDate;
      });
    }
  }

  chooseTime() {
    showTimePicker(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: child!,
          ),
        );
      },
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedTime = value;
        });
      }
    });
  }
}
