import 'package:flutter/material.dart';
import 'package:linkschool/modules/E_library/books_button_item.dart';
import 'package:linkschool/modules/explore/ebooks/all_tab.dart';
import '../../common/app_colors.dart';
import '../../common/constants.dart';
import '../../common/text_styles.dart';



class LibraryEbook extends StatefulWidget {
  const LibraryEbook({super.key});

  @override
  State<LibraryEbook> createState() => _LibraryEbookState();
}

class _LibraryEbookState extends State<LibraryEbook> {
  int _selectedBookCategoriesIndex = 0;
  final bookCategories = [
    'Academic',
    'Science Fiction',
    'For WAEC',
    'Self-help',
    'Religious',
    'Literature'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // Wrap the entire screen with a SingleChildScrollView
        child: Container(
          decoration: Constants.customBoxDecoration(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What do you want to\nread today?',
                  style: AppTextStyles.normal600(
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16.0), // Add spacing between title and categories
                _buildCategoryButtons(), // Styled category buttons
                SizedBox(height: 16.0), // Add spacing before the TabBar
                _buildTabController(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// **Builds the Styled Book Category Buttons**
  Widget _buildCategoryButtons() {
    return Wrap(
      spacing: 12.0, // Space between buttons horizontally
      runSpacing: 12.0, // Space between rows of buttons
      alignment: WrapAlignment.start,
      children: List.generate(bookCategories.length, (index) {
        bool isSelected = _selectedBookCategoriesIndex == index;

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedBookCategoriesIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.symmetric(vertical: 12, horizontal:8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.admissionopen : AppColors.ebookCard, // Selected color
              borderRadius: BorderRadius.circular(6), // Rounded corners
              border: Border.all(
                color: AppColors.admissionopen, 
                width: 2,
              ),
             
            ),
            child: Text(
              bookCategories[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black, // Dynamic text color
              ),
            ),
          ),
        );
      }),
    );
  }

  /// **Builds the Tab Controller with Tabs**
  Widget _buildTabController() {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: false,
            unselectedLabelColor: const Color.fromRGBO(90, 90, 90, 1),
            labelColor: AppColors.text2Light,
            labelStyle: AppTextStyles.normal600(
              fontSize: 16.0,
              color: AppColors.text2Light,
            ),
            indicatorColor: AppColors.text2Light,
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Library'),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7, // Adjust height dynamically
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(), // Disable horizontal scrolling
              children: [
                const AllTab(),
                Container(
                  color: Colors.orange,
                  child: const Center(
                    child: Text('Tab 2'),
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
