import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:lepton_school/view/colors/colors.dart';
import 'package:lepton_school/view/constant/sizes/sizes.dart';
import 'package:lepton_school/view/widgets/fonts/google_poppins.dart';

import '../../view/widgets/container_image.dart';
import 'Subject 2/subject_chapterwise_display.dart';
import 'widget/Heading_Container_Widget.dart';

class StudentLogin extends StatelessWidget {
  const StudentLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const Heading_Container_Widget(
            text: 'Subject',
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(15),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: List.generate(
                4,
                (index) => Container(
                  decoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 50,

                  // ignore: sort_child_properties_last
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20.h, top: 20.h, right: 20.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                // onTap: () {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               SubjectWiseDisplay()));
                                // },
                                child: Container(
                                  width: 75.w,
                                  height: 75.h,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(blurRadius: 3.0, color: cWhite),
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white.withOpacity(0.5),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: ContainerImage(
                                    height: 60.h,
                                    imagePath: 'assets/images/teachernew.png',
                                    width: 60.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.h),
                              Expanded(
                                  child: FittedBox(
                                      child: GooglePoppinsWidgets(
                                text: "Anupamah",
                                fontsize: 12.h,
                                color: Colors.grey,
                              )))
                            ],
                          ),
                          kHeight20,
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SubjectWiseDisplay()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GooglePoppinsWidgets(
                                    text: "Chemistry",
                                    fontsize: 28.h,
                                    color: cblack,
                                  ),
                                ],
                              )),
                        ]),
                  ),

                  // GooglePoppinsWidgets(text: "Subject", fontsize: 16),
                  // kHeight10,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

const text = [""];
