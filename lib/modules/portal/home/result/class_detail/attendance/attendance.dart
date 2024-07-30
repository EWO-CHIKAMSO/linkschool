// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:linkschool/modules/common/app_colors.dart';
import 'package:linkschool/modules/common/text_styles.dart';
import 'package:linkschool/modules/common/widgets/dash_line.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Variables to control card dimensions
  final double cardWidth = 340;
  final double cardHeight = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        elevation: 0,
        title: Text(
          'Attendance',
          style: AppTextStyles.normal600(
              fontSize: 20, color: AppColors.backgroundLight),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/icons/arrow_back.png',
            height: 24,
            width: 24,
            color: AppColors.backgroundLight,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/result/search.svg',
              color: AppColors.backgroundLight,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            // top: MediaQuery.of(context).size.height * 0.10,
            top: 37,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SizedBox(
                  width: 396,
                  height: 190,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/result/study_book.svg',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 22,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.videoColor4),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Third Term',
                                        style: AppTextStyles.normal600(
                                            fontSize: 12,
                                            color: AppColors.videoColor4),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'JSS2 A',
                                    style: AppTextStyles.normal600(
                                        fontSize: 22,
                                        color: AppColors.primaryLight),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '2015/2016 Academic session',
                                    style: AppTextStyles.normal500(
                                        fontSize: 14,
                                        color: AppColors.textGray),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const DashedLine(color: Colors.grey),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  'Date :',
                                  style: AppTextStyles.normal500(
                                      fontSize: 16, color: AppColors.textGray),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  '20 July, 2024',
                                  style: AppTextStyles.normal600(
                                      fontSize: 18,
                                      color: AppColors.primaryLight),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0),
                    ),
                  ),
                  child: Text(
                    'Take attendance',
                    style: AppTextStyles.normal600(
                        fontSize: 16, color: AppColors.backgroundLight),
                  ),
                ),
                const SizedBox(height: 44),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Attendance history',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  color: Colors.white,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    separatorBuilder: (context, index) =>
                        Divider(height: 1, color: Colors.grey[300]),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check,
                              color: Colors.white, size: 20),
                        ),
                        title: const Text('Thursday, 20 July, 2026'),
                        subtitle: const Text('English language',
                            style: TextStyle(color: Colors.grey)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// const DashedLine(color: Colors.grey),