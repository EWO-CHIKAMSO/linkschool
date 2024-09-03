import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart'; // Add this package for date formatting
import 'package:linkschool/modules/common/app_colors.dart';
import 'package:linkschool/modules/common/buttons/custom_medium_elevated_button.dart';
import 'package:linkschool/modules/common/buttons/custom_save_elevated_button.dart';
// import 'package:linkschool/modules/common/buttons/custom_save_outline_button.dart';
import 'package:linkschool/modules/common/text_styles.dart';
import 'package:linkschool/modules/common/widgets/portal/e_learning/select_classes_dialog.dart';
import 'package:linkschool/modules/portal/e-learning/topic_selection_screen.dart';

class AssignmentScreen extends StatefulWidget {
  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  String _selectedClass = 'Select classes';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Map<String, dynamic>> _attachments = [];
  DateTime _selectedDateTime = DateTime.now();
  String _selectedTopic = 'Rule of BODMAS';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset(
            'assets/icons/arrow_back.png',
            color: AppColors.primaryLight,
            width: 34.0,
            height: 34.0,
          ),
        ),
        title: Text(
          'Assignment',
          style: AppTextStyles.normal600(
            fontSize: 24.0,
            color: AppColors.primaryLight,
          ),
        ),
        backgroundColor: AppColors.backgroundLight,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomSaveElevatedButton(
              onPressed: () {
                // Save functionality can be added here
              },
              text: 'Save',
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title:',
                style: AppTextStyles.normal600(fontSize: 16.0, color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'e.g. Dying and bleaching',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Description:',
                style: AppTextStyles.normal600(fontSize: 16.0, color: Colors.black),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Type here...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 32.0),
              Text(
                'Select the learning group for this syllabus: *',
                style: AppTextStyles.normal600(fontSize: 16.0, color: Colors.black),
              ),
              const SizedBox(height: 16.0),
              _buildGroupRow(
                context,
                iconPath: 'assets/icons/e_learning/people.svg',
                text: _selectedClass,
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SelectClassesDialog(
                        onSave: (selectedClass) {
                          setState(() {
                            _selectedClass = selectedClass;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              ..._buildAttachments(),
              // CustomOutlineButton(
              //   text: '+ Add',
              //   textColor: Colors.orange,
              //   borderColor: Colors.orange,
              //   onPressed: _showAttachmentOptions,
              // ),
              _buildGroupRow(
                context,
                iconPath: 'assets/icons/e_learning/mark.svg',
                text: '200 marks',
                showEditButton: true,
                onTap: () {},
              ),
              _buildGroupRow(
                context,
                iconPath: 'assets/icons/e_learning/calender.svg',
                text: DateFormat('E, dd MMM (hh:mm a)').format(_selectedDateTime),
                showEditButton: true,
                onTap: _showDateTimePicker,
              ),
              _buildGroupRow(
                context,
                iconPath: 'assets/icons/e_learning/clipboard.svg',
                text: _selectedTopic,
                showEditButton: true,
                isSelected: true,
                onTap: _showTopicSelectionScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupRow(
    BuildContext context, {
    required String iconPath,
    required String text,
    required VoidCallback onTap,
    bool showEditButton = false,
    bool isSelected = false,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  iconPath,
                  width: 32.0,
                  height: 32.0,
                ),
              ),
              const SizedBox(width: 8.0),
              IntrinsicWidth(
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.transparent : AppColors.eLearningBtnColor2,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        text,
                        style: AppTextStyles.normal600(
                          fontSize: 16.0,
                          color: AppColors.eLearningBtnColor1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              if (showEditButton)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: OutlinedButton(
                    onPressed: onTap,
                    child: const Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      textStyle: AppTextStyles.normal600(fontSize: 14.0, color: AppColors.backgroundLight),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Divider(color: Colors.grey.withOpacity(0.5)),
        const SizedBox(height: 8.0),
      ],
    );
  }

  List<Widget> _buildAttachments() {
    return _attachments.map((attachment) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            SvgPicture.asset(
              attachment['iconPath'],
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                attachment['name'],
                style: AppTextStyles.normal400(fontSize: 16, color: AppColors.backgroundDark),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: SvgPicture.asset(
                'assets/icons/e_learning/cancel.svg',
                color: Colors.red,
                width: 20,
                height: 20,
              ),
              onPressed: () => setState(() => _attachments.remove(attachment)),
            ),
          ],
        ),
      );
    }).toList();
  }

  void _showAttachmentOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add attachment',
            style: AppTextStyles.normal600(fontSize: 20, color: AppColors.backgroundDark),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildAttachmentOption('Insert link', 'assets/icons/e_learning/link3.svg', _showInsertLinkDialog),
              _buildAttachmentOption('Upload file', 'assets/icons/e_learning/upload.svg', _uploadFile),
              _buildAttachmentOption('Take photo', 'assets/icons/e_learning/camera.svg', _takePhoto),
              _buildAttachmentOption('Record Video', 'assets/icons/e_learning/video.svg', _recordVideo),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOption(String text, String iconPath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        color: AppColors.backgroundLight,
        child: Row(
          children: [
            SvgPicture.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 16),
            Text(text, style: AppTextStyles.normal400(fontSize: 16, color: AppColors.backgroundDark)),
          ],
        ),
      ),
    );
  }

  void _showInsertLinkDialog() {
    TextEditingController linkController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Insert Link',
            style: AppTextStyles.normal600(fontSize: 20, color: AppColors.backgroundDark),
            textAlign: TextAlign.center,
          ),
          content: TextField(
            controller: linkController,
            decoration: InputDecoration(
              hintText: 'Enter link here',
              prefixIcon: SvgPicture.asset(
                'assets/icons/e_learning/link3.svg',
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          actions: [
            // CustomOutlineButton(
            //   onPressed: () => Navigator.of(context).pop(),
            //   text: 'Cancel',
            //   borderColor: AppColors.eLearningBtnColor3,
            //   textColor: AppColors.eLearningBtnColor3,
            // ),
            CustomSaveElevatedButton(
              onPressed: () {
                if (linkController.text.isNotEmpty) {
                  setState(() {
                    _attachments.add({
                      'iconPath': 'assets/icons/e_learning/link3.svg',
                      'name': linkController.text,
                    });
                  });
                }
                Navigator.of(context).pop();
              },
              text: 'Save',
            ),
          ],
        );
      },
    );
  }

  void _uploadFile() {
    // Logic for file upload; placeholder for future implementation
    setState(() {
      _attachments.add({
        'iconPath': 'assets/icons/e_learning/upload.svg',
        'name': 'Uploaded File',
      });
    });
  }

  void _takePhoto() {
    // Logic for taking photo; placeholder for future implementation
    setState(() {
      _attachments.add({
        'iconPath': 'assets/icons/e_learning/camera.svg',
        'name': 'Photo Taken',
      });
    });
  }

  void _recordVideo() {
    // Logic for recording video; placeholder for future implementation
    setState(() {
      _attachments.add({
        'iconPath': 'assets/icons/e_learning/video.svg',
        'name': 'Recorded Video',
      });
    });
  }

  void _showDateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((date) {
      if (date != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
        ).then((time) {
          if (time != null) {
            setState(() {
              _selectedDateTime = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );
            });
          }
        });
      }
    });
  }

  void _showTopicSelectionScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TopicSelectionScreen(
          initialTopic: _selectedTopic,
          onSave: (topic) {
            setState(() {
              _selectedTopic = topic;
            });
          },
        ),
      ),
    );
  }
}
