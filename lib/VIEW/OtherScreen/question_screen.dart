import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../MODEL/question_model.dart';
import '../components/app_style.dart';
import '../components/component.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Future<List<QuestionModel>> getData() async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site20.atempurl.com/api/QuestionsApi/GetAll'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      List jsonData = (data);
      return jsonData.map((Data) => QuestionModel.fromJson(Data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        backgroundColor: Styles.defualtColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30,
            )),
        centerTitle: true,
        title: Text(
          'Common questions',
          style: TextStyle(
            fontFamily: 'Tajawal7',
            fontSize: 15.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: FutureBuilder<List<QuestionModel>>(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<QuestionModel?>? item = snapshot.data;
                        return SizedBox(
                          height: 500.h,
                          child: ListView.separated(
                            itemBuilder: (context, index) => Column(
                              children: [
                                BuildQuestionScreen(
                                  text1: item[index]!.question,
                                  text2: item[index]!.answer,
                                ),
                              ],
                            ),
                            separatorBuilder: (context, index) => Gap(5.h),
                            itemCount: item!.length,
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Styles.defualtColor),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
