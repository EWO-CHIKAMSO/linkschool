// ignore_for_file: prefer_const_literals_to_create_immutables, unused_element

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/svg.dart';
import 'package:linkschool/modules/common/app_colors.dart';
import 'package:linkschool/modules/common/constants.dart';
import 'package:linkschool/modules/common/text_styles.dart';
import 'package:linkschool/modules/portal/profile/receipt/payment_received_screen.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen>
    with TickerProviderStateMixin {
  late double opacity;
  bool _isOverlayVisible = false;
  late TabController _tabController;
  int _currentTabIndex = 0;
  String _selectedDateRange = 'Custom';
  String _selectedGrouping = 'Month';
  String _selectedLevel = 'JSS1';
  String _selectedClass = 'JSS1A';
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    opacity = brightness == Brightness.light ? 0.1 : 0.15;
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
          'Receipts',
          style: AppTextStyles.normal600(
            fontSize: 24.0,
            color: AppColors.primaryLight,
          ),
        ),
        backgroundColor: AppColors.backgroundLight,
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: opacity,
                  child: Image.asset(
                    'assets/images/background.png',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: Constants.customBoxDecoration(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text('February 2023'),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                          Row(
                            children: [
                              Text('2023/2024 3rd Term'),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(47, 85, 221, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Amount Received',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          198, 210, 255, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text('7 payments'),
                                  ),
                                ],
                              ),
                              const Text(
                                '234,790.00',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            gridData: const FlGridData(show: false),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return const Text('Basic');
                                      case 1:
                                        return const Text('JSS');
                                      case 2:
                                        return const Text('SSS');
                                      default:
                                        return const Text('');
                                    }
                                  },
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            minX: 0,
                            maxX: 2,
                            minY: 0,
                            maxY: 6,
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  const FlSpot(0, 3),
                                  const FlSpot(1, 1),
                                  const FlSpot(2, 4),
                                ],
                                isCurved: true,
                                color: const Color.fromRGBO(47, 85, 221, 1),
                                barWidth: 3,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color:
                                      const Color.fromRGBO(47, 85, 221, 0.102),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Payment History',
                              style: AppTextStyles.normal600(
                                  fontSize: 18,
                                  color: AppColors.backgroundDark)),
                          const Text(
                            'See all',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromRGBO(47, 85, 221, 1),
                                fontSize: 16.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      _buildPaymentHistoryItem(
                          'JSS', '234,700.00', 'Joseph Raphael'),
                      _buildPaymentHistoryItem(
                          'SS', '189,500.00', 'Maria Johnson'),
                      _buildPaymentHistoryItem(
                          'JSS', '276,300.00', 'John Smith'),
                      _buildPaymentHistoryItem(
                          'SS', '205,800.00', 'Emma Davis'),
                      _buildPaymentHistoryItem(
                          'JSS', '298,100.00', 'Michael Brown'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isExpanded) _buildSmallFloatingButtons(),
        ],
      ),
      floatingActionButton: _buildAnimatedFAB(),
    );
  }

  void _showAddReceiptBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Receipt',
                    style: AppTextStyles.normal600(
                        fontSize: 20, color: const Color.fromRGBO(47, 85, 221, 1)),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                        'assets/icons/profile/cancel_receipt.svg'),
                    color: AppColors.bgGray,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildInputField('Student name', 'Student name'),
              const SizedBox(height: 16),
              _buildInputField('Amount', 'Amount'),
              const SizedBox(height: 16),
              _buildInputField('Reference', 'Reference'),
              const SizedBox(height: 16),
              _buildDateInputField('Date'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(47, 85, 221, 1),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text(
                    'Record payment',
                    style: AppTextStyles.normal500(
                        fontSize: 18, color: AppColors.backgroundLight),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInputField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyles.normal500(
                fontSize: 16.0, color: AppColors.backgroundDark)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateInputField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyles.normal500(
                fontSize: 16, color: AppColors.backgroundDark)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2025),
            );
            if (picked != null) {
              // Handle date selection
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select date'),
                SvgPicture.asset('assets/icons/profile/calendar_icon.svg'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedFAB() {
    return FloatingActionButton(
      backgroundColor: AppColors.videoColor4,
      onPressed: _toggleExpanded,
      child: AnimatedCrossFade(
        firstChild: SvgPicture.asset('assets/icons/profile/add_icon.svg'),
        secondChild: SvgPicture.asset('assets/icons/profile/inverted_add_icon.svg'),
        crossFadeState:
            _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  Widget _buildSmallFloatingButtons() {
    return Positioned(
      bottom: 80,
      right: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: 'Setup report',
            preferBelow: false,
            verticalOffset: 20,
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return _buildCustomOverlay();
                  },
                );
              },
              backgroundColor: const Color.fromRGBO(47, 85, 221, 1),
              child: SvgPicture.asset('assets/icons/profile/setup_report.svg'),
            ),
          ),
          const SizedBox(height: 16),
          Tooltip(
            message: 'Add receipt',
            preferBelow: false,
            verticalOffset: 20,
            child: FloatingActionButton(
              mini: true,
              onPressed: _showAddReceiptBottomSheet,
              backgroundColor: const Color.fromRGBO(47, 85, 221, 1),
              child: SvgPicture.asset('assets/icons/profile/add_receipt.svg'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallFloatingButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: const Color.fromRGBO(47, 85, 221, 1),
      onPressed: onPressed,
      child: Icon(icon, color: AppColors.backgroundLight),
    );
  }

  Widget _buildCustomOverlay() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.black54,
        child: GestureDetector(
          onTap:
              () {}, // Prevents taps from propagating to the outer GestureDetector
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.5,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      onTap: (index) {
                        setState(() {
                          _currentTabIndex = index;
                        });
                      },
                      tabs: const [
                        Tab(text: 'Date Range'),
                        Tab(text: 'Grouping'),
                        Tab(text: 'Filter'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildDateRangeTab(),
                        _buildGroupingTab(),
                        _buildFilterTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: 'Date Range'),
        Tab(text: 'Grouping'),
        Tab(text: 'Filter'),
      ],
    );
  }

  Widget _buildTabContent() {
    switch (_currentTabIndex) {
      case 0:
        return _buildDateRangeTab();
      case 1:
        return _buildGroupingTab();
      case 2:
        return _buildFilterTab();
      default:
        return Container();
    }
  }

  Widget _buildDateRangeTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDateRangeOptions(),
          const SizedBox(height: 20),
          if (_selectedDateRange == 'Custom') _buildCustomDateRange(),
        ],
      ),
    );
  }

  Widget _buildDateRangeOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ['Custom', 'Today', 'Yesterday', 'This Week'].map((option) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDateRange = option;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _selectedDateRange == option
                  ? const Color.fromRGBO(47, 85, 221, 1)
                  : const Color.fromRGBO(212, 222, 255, 1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              option,
              style: TextStyle(
                color:
                    _selectedDateRange == option ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCustomDateRange() {
    return Column(
      children: [
        _buildDateInput('From:', _fromDate, (date) {
          setState(() {
            _fromDate = date;
          });
        }),
        const SizedBox(height: 10),
        _buildDateInput('To:', _toDate, (date) {
          setState(() {
            _toDate = date;
          });
        }),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Generate report logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(47, 85, 221, 1),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          child: Text(
            'Generate Report',
            style: AppTextStyles.normal500(
                fontSize: 18, color: AppColors.backgroundLight),
          ),
        ),
      ],
    );
  }

  Widget _buildDateInput(
      String label, DateTime selectedDate, Function(DateTime) onDateSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2025),
            );
            if (picked != null) {
              setState(() {
                onDateSelected(picked);
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                  style: const TextStyle(fontSize: 16),
                ),
                SvgPicture.asset('assets/icons/profile/calendar_icon.svg'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupingTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Group by:',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          _buildGroupingOption('Month'),
          _buildGroupingOption('Vendor'),
          _buildGroupingOption('Account'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Generate report logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(47, 85, 221, 1),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            child: Text(
              'Generate Report',
              style: AppTextStyles.normal500(
                  fontSize: 18, color: AppColors.backgroundLight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupingOption(String option) {
    return Container(
      width: double.infinity,
      height: 42,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(229, 229, 229, 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(option),
      ),
    );
  }

  Widget _buildFilterTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter by:',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          _buildFilterOption('Level', ['JSS1', 'JSS2', 'JSS3'], _selectedLevel,
              (value) {
            setState(() {
              _selectedLevel = value;
            });
          }),
          const SizedBox(height: 10),
          _buildFilterOption(
              'Class', ['JSS1A', 'JSS1B', 'JSS1C'], _selectedClass, (value) {
            setState(() {
              _selectedClass = value;
            });
          }),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Generate report logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(47, 85, 221, 1),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
            ),
            child: Text(
              'Generate Report',
              style: AppTextStyles.normal500(
                  fontSize: 18, color: AppColors.backgroundLight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String label, List<String> options,
      String selectedValue, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(229, 229, 229, 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentHistoryItem(String grade, String amount, String name) {
    return GestureDetector(
      onTap: () {},
      
      // () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => PaymentReceiptDetailScreen(
      //         grade: grade,
      //         amount: amount,
      //         name: name,
      //       ),
      //     ),
      //   );
      // },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/icons/profile/payment_icon.svg'),
                  const SizedBox(width: 8),
                  Text(
                    name,
                    style: AppTextStyles.normal600(
                        fontSize: 18, color: AppColors.backgroundDark),
                  ),
                ],
              ),
              Text(amount,
                  style: AppTextStyles.normal700(
                      fontSize: 18,
                      color: const Color.fromRGBO(47, 85, 221, 1))),
            ],
          ),
        ),
      ),
    );
  }
}
