import 'package:flutter/material.dart';
import 'state/activity_log_store.dart';
import 'state/challenge_store.dart';
import 'state/points_rule.dart';
import 'widgets/bottomNavigationBar.dart';
import 'widgets/header.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'state/points_store.dart';

class ActivityLogPage extends StatefulWidget {
  const ActivityLogPage({super.key});

  @override
  State<ActivityLogPage> createState() => _ActivityLogPageState();
}

class _ActivityLogPageState extends State<ActivityLogPage> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  Future<void> _takePhoto() async {
    final img = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );
    if (img != null) setState(() => _pickedImage = img);
  }

  Future<void> _chooseFromGallery() async {
    final img = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (img != null) setState(() => _pickedImage = img);
  }

  String? _completedValue;

  Widget _photoBox(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: cs.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: _pickedImage == null
          ? const SizedBox()
          : Image.file(
              File(_pickedImage!.path),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final labelStyle = TextStyle(
      color: cs.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 18,
    );
    return Scaffold(
      appBar: HeaderBar(
        title: "Activity Log",
        helpText:
            "This is your activity log, where you can log in the eco-friendy actions you've performed",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Picture of Activity (Optional):",
                  style: labelStyle,
                ),
              ),
              const SizedBox(height: 10),
              _photoBox(context),
              const SizedBox(height: 16),

              // Buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 42,
                    child: ElevatedButton(
                      onPressed: _takePhoto,
                      child: const Text("Take Picture"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: cs.primary,
                        foregroundColor: cs.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 42,
                    child: ElevatedButton(
                      onPressed: _chooseFromGallery,
                      child: const Text(
                        "Choose\nfrom Gallery",
                        textAlign: TextAlign.center,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: cs.primary,
                        foregroundColor: cs.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              Row(
                children: [
                  Expanded(
                    child: Text("Activity Completed:", style: labelStyle),
                  ),
                  SizedBox(
                    width: 140,
                    height: 44,
                    child: DropdownButtonFormField<String>(
                      initialValue: _completedValue,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          value: "Recycling",
                          child: Text("Recycling"),
                        ),
                        DropdownMenuItem(
                          value: "Transit",
                          child: Text("Transit"),
                        ), //If value/text of a dropdown is too long the app crashes
                        DropdownMenuItem(
                          value: "Energy",
                          child: Text("Energy"),
                        ),
                      ],
                      onChanged: (v) => setState(() => _completedValue = v),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: cs.surfaceVariant,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      hint: const Text("Select"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              Center(child: Text("Description (Optional):", style: labelStyle)),
              const SizedBox(height: 10),

              TextField(
                controller: _descriptionController,
                minLines: 4,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: "Description",
                  filled: true,
                  fillColor: cs.surfaceVariant,
                  contentPadding: const EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const SizedBox(width: 16),
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_completedValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select an activity.'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      return;
                    }

                    final desc = _descriptionController.text;

                    await context.read<ActivityLogStore>().addEntry(
                      activityType: _completedValue!,
                      description: desc,
                    );

                    final earned = PointsRules.pointsForActivity(_completedValue!);

                    await context.read<PointsStore>().applyTransaction(
                      source: "activity",
                      amount: earned,
                    );
                    context.read<ChallengeStore>().onActivityLogged(
                      _completedValue!,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '+$earned points! Total: ${context.read<PointsStore>().points}',
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                    
                    setState(() {
                      _completedValue = null;
                      _pickedImage = null;
                    });
                    _descriptionController.clear();
                  },
                  child: const Text(
                    "Log Activity",
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(currentRoute: "/activity-log"),
    );
  }
}
