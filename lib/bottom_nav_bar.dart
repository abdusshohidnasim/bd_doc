import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'common_widgets/custom_button.dart';
import 'common_widgets/show_dilogbox.dart';
import 'features/demo.dart';
import 'helpers/ui_helpers.dart';
import 'gen/colors.gen.dart';
import 'constants/text_font_style.dart';
import 'gen/assets.gen.dart';

class BottomNavBar extends StatefulWidget {
  static final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);
  static final ValueNotifier<int> styleTabTapNotifier = ValueNotifier<int>(0);

  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  final List<Widget> _screens = const [
    DemoPage(),
    DemoPage(),
    DemoPage(),
    DemoPage(),
    DemoPage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = BottomNavBar.selectedIndexNotifier.value;
    BottomNavBar.selectedIndexNotifier.addListener(_onNotifierChanged);
  }

  @override
  void dispose() {
    BottomNavBar.selectedIndexNotifier.removeListener(_onNotifierChanged);
    super.dispose();
  }

  void _onNotifierChanged() {
    if (mounted) {
      setState(() {
        _selectedIndex = BottomNavBar.selectedIndexNotifier.value;
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      BottomNavBar.styleTabTapNotifier.value++;
    }
    BottomNavBar.selectedIndexNotifier.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        showLogoutDialog(
          context,
          titel: "are you sure you want to exit?",
          subtitel: "do you really want to close the app?",
          icon: Assets.icons.logOut.path,
          fristbutton: CustomButton(
            backgroundColor: AppColors.cE6E4DE,
            onPressed: () {
              Navigator.pop(context);
            },
            title: "no",
          ),
          secendbutton: CustomButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            title: "yes",
          ),
        );
      },
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: SizedBox(
          height: 100.h,
          //  padding: EdgeInsets.only(bottom: 20.h),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 70.h,
                // margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: AppColors.c0F3D3D,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(Assets.icons.home.path, "Home", 0),
                    _navItem(Assets.icons.closet.path, "closet", 1),
                    UIHelper.horizontalSpace(20.w), // Space for the FAB
                    _navItem(Assets.icons.styleIcon.path, "style", 3),
                    _navItem(Assets.icons.profileIcon.path, "profile", 4),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                child: InnerShadow(
                  shadows: [
                    Shadow(
                      color: AppColors.cF9FBE6.withValues(alpha: 0.5),
                      blurRadius: 24,
                      offset: const Offset(0, 4),
                    ),
                    Shadow(
                      color: AppColors.cEDF2B0.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                  child: Container(
                    height: 60.h,
                    width: 60.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cF7F6F2,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: FloatingActionButton(
                        onPressed: () {
                          _onItemTapped(2);
                        },
                        backgroundColor: AppColors.c0F3D3D,
                        elevation: 0,
                        shape: const CircleBorder(),
                        child: InnerShadow(
                          child: Center(
                            child: Image.asset(
                              Assets.icons.aiIcon.path,
                              height: 24.h,
                              width: 24.w,
                              color: AppColors.cFFFFFF,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(
    String activeIcon,
    String label,
    int index,
  ) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(activeIcon,
              height: 24.h,
              width: 24.w,
              color: isSelected ? AppColors.cC7D700 : AppColors.cF7F6F2),
          UIHelper.verticalSpace(4.h),
          Text(
            label,
            style: TextFontStyle.textStyle12c0D0D0DRM500.copyWith(
              color: isSelected ? AppColors.cC7D700 : AppColors.cF7F6F2,
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
