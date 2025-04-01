import 'package:bcs_preli_preparation/app/data/providers/api_service.dart';
import 'package:bcs_preli_preparation/app/routes/app_pages.dart';
import 'package:bcs_preli_preparation/app/widgets/question_fetching_error_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/model/question.dart';
import '../../../data/model/subject.dart';

class ExamCustomizationController extends GetxController {
  final numberOfQuestions = TextEditingController();
  final examName = TextEditingController();
  final time = TextEditingController();

  final box = GetStorage();
  final _apiService = ApiService();

  RxList<Subject> subjects = <Subject>[].obs;
  RxMap<String, List<int>> selectedSubjects = <String, List<int>>{}.obs;

  var isLoading = false.obs;
  var expandedSubjects = {}.obs;
  var selectedSubSubjects = {}.obs;

  RxString selectedSingleSubject = ''.obs;

  final Map<String, String> subjectKeys = {
    "Mathematics": "sub_subject_math",
    "Bangladesh Affairs": "sub_subject_baf",
    "International Affairs": "sub_subject_iaf",
    "Bangla": "sub_subject_bangla",
    "English": "sub_subject_english",
    "Geography": "sub_subject_geo",
    "Mental Ability": "sub_subject_metal_ability",
    "General Science": "sub_subject_gensc",
    "ICT": "sub_subject_ict",
  };

  @override
  void onInit() {
    loadInitialSubjects();
    super.onInit();
  }

  @override
  void onClose() {
    examName.dispose();
    numberOfQuestions.dispose();
    time.dispose();
    super.onClose();
  }

  void loadInitialSubjects() => subjects.assignAll([
    Subject(
      name: 'বাংলা',
      value: 'bangla',
      subSubjects: [
        SubSubject(name: 'আদিযুগ', value: 1),
        SubSubject(name: 'মধ্যযুগ', value: 2),
        SubSubject(name: 'আধুনিকযুগ', value: 29),
        SubSubject(name: 'বঙ্কিমচন্দ্রচট্টোপাধ্যায়', value: 113),
        SubSubject(name: 'ঈশ্বরচন্দ্রবিদ্যাসাগর', value: 115),
        SubSubject(name: 'কাজী নজরুল ইসলাম', value: 111),
        SubSubject(name: 'রবীন্দ্রনাথ ঠাকুর', value: 112),
        SubSubject(name: 'মাইকেল মধুসূদন দত্ত', value: 114),
        SubSubject(name: 'মীর মশাররফ হোসেন', value: 116),
        SubSubject(name: 'দীনবন্ধু মিত্র', value: 117),
        SubSubject(name: 'ফররুখ আহমদ', value: 119),
        SubSubject(name: 'জসীমউদ্দীন', value: 118),
        SubSubject(name: 'কায়কোবাদ', value: 120),
        SubSubject(name: 'রোকেয়া সাখাওয়াত হোসেন', value: 121),
        SubSubject(
          name: 'মুক্তিযুদ্ধভিত্তিক উপন্যাস, নাটক ও সাহিত্য',
          value: 4,
        ),
        SubSubject(name: 'পত্রিকা', value: 5),
        SubSubject(name: 'সাহিত্যের উদ্ধৃতি', value: 6),
        SubSubject(name: 'ভাষা ও ব্যাকরণ', value: 7),
        SubSubject(name: 'বর্ণ ও ধ্বনি', value: 8),
        SubSubject(name: 'ণত্ব বিধান ও ষত্ব বিধান', value: 9),
        SubSubject(name: 'সন্ধি', value: 10),
        SubSubject(name: 'উপসর্গ', value: 11),
        SubSubject(name: 'দ্বিরুক্ত শব্দ', value: 12),
        SubSubject(name: 'বচন', value: 13),
        SubSubject(name: 'লিঙ্গ পরিবর্তন', value: 14),
        SubSubject(name: 'সমাস', value: 15),
        SubSubject(name: 'প্রকৃতি ও প্রত্যয়', value: 16),
        SubSubject(name: 'কারক ও বিভক্তি', value: 17),
        SubSubject(name: 'শব্দ', value: 18),
        SubSubject(name: 'পদ ও পদ পরিবর্তন', value: 20),
        SubSubject(name: 'বাক্য ও বাক্য পরিবর্তন', value: 19),
        SubSubject(name: 'বাচ্য পরিবর্তন', value: 21),
        SubSubject(name: 'পরিভাষা', value: 22),
        SubSubject(name: 'সমার্থক শব্দ', value: 23),
        SubSubject(name: 'বানান শুদ্ধি', value: 27),
        SubSubject(name: 'বিপরীতার্থক শব্দ', value: 24),
        SubSubject(name: 'বাগধারা', value: 25),
        SubSubject(name: 'এক কথায় প্রকাশ', value: 26),
        SubSubject(name: 'প্রয়োগ ও অপপ্রয়োগ', value: 28),
        SubSubject(name: 'অন্যান্য (ব্যাকরণ)', value: 30),
      ],
    ),
    Subject(
      name: 'ইংরেজি',
      value: 'english',
      subSubjects: [
        SubSubject(name: 'Articles & determiners', value: 2),
        SubSubject(name: 'Appropriate Preposition', value: 3),
        SubSubject(name: 'Antonyms', value: 20),
        SubSubject(name: 'Analogy', value: 21),
        SubSubject(name: 'Clause', value: 11),
        SubSubject(name: 'Correction', value: 13),
        SubSubject(name: 'Extra', value: 23),
        SubSubject(name: 'Formation of words', value: 16),
        SubSubject(name: 'Gender', value: 10),
        SubSubject(name: 'Idioms & phrases', value: 17),
        SubSubject(name: 'Literature', value: 1),
        SubSubject(name: 'Narration', value: 4),
        SubSubject(name: 'Number', value: 9),
        SubSubject(name: 'parts of speech', value: 6),
        SubSubject(name: 'Spelling', value: 18),
        SubSubject(name: 'Synonyms', value: 19),
        SubSubject(name: 'Substitutions,Expressions & Definitions', value: 22),
        SubSubject(name: 'Tense', value: 7),
        SubSubject(name: 'Transformation', value: 8),
        SubSubject(name: 'Tag Question', value: 12),
        SubSubject(name: 'Translation', value: 14),
        SubSubject(name: 'Proverbs', value: 15),
        SubSubject(name: 'Voice', value: 5),
      ],
    ),
    Subject(
      name: 'গণিত',
      value: 'mathematics',
      subSubjects: [
        SubSubject(name: 'Arithmetic', value: 1),
        SubSubject(name: 'Algebra', value: 2),
        SubSubject(name: 'geometry', value: 3),
        SubSubject(name: 'Math-extra', value: 4),
      ],
    ),
    Subject(
      name: 'বাংলাদেশ বিষয়াবলি',
      value: 'bangladesh_affairs',
      subSubjects: [
        SubSubject(name: 'বাংলাদেশের জাতীয় বিষয়াবলি', value: 1),
        SubSubject(name: 'প্রাচীন বাংলার ইতিহাস', value: 11),
        SubSubject(name: 'কৃষি', value: 2),
        SubSubject(name: 'জনসংখ্যা ও আদমশুমারি', value: 3),
        SubSubject(name: 'অর্থনীতি', value: 4),
        SubSubject(name: 'শিল্প ও বাণিজ্য', value: 5),
        SubSubject(name: 'সংবিধান', value: 6),
        SubSubject(name: 'সরকার ব্যবস্থা', value: 7),
        SubSubject(name: 'রাজনৈতিক ব্যবস্থা', value: 8),
        SubSubject(name: 'মুক্তিযুদ্ধের ইতিহাস', value: 9),
        SubSubject(name: 'অর্জন ও অন্যান্য', value: 10),
      ],
    ),
    Subject(
      name: 'আন্তর্জাতিক বিষয়াবলি',
      value: 'internatinal_affairs',
      subSubjects: [
        SubSubject(
          name: 'Global history, regional and international system geopolitics',
          value: 1,
        ),
        SubSubject(
          name: 'International security and international power relations',
          value: 2,
        ),
        SubSubject(
          name: 'International environmental issues and politics',
          value: 3,
        ),
        SubSubject(name: 'Organization and the global economy', value: 4),
        SubSubject(
          name: 'Cities, rivers, oceans, islands and others',
          value: 5,
        ),
        SubSubject(
          name: 'Important wars, international treaties and organizations',
          value: 6,
        ),
        SubSubject(name: 'Notable awards in the world', value: 7),
        SubSubject(name: 'Capitals', value: 8),
        SubSubject(name: 'Coin', value: 9),
        SubSubject(name: 'Parliament', value: 10),
        SubSubject(name: 'Sports', value: 11),
        SubSubject(name: 'Others', value: 12),
      ],
    ),
    Subject(
      name: 'ভূগোল',
      value: 'geography',
      subSubjects: [
        SubSubject(
          name:
              'বাংলাদেশ এবং আঞ্চলিক ভৌগোলিক অবস্থান, সীমানা, পরিবেশগত, আর্থ-সামাজিক, ভূ-রাজনীতি',
          value: 1,
        ),
        SubSubject(name: 'প্রাকৃতিক দুর্যোগ এবং ব্যবস্থাপনা', value: 2),
        SubSubject(
          name: 'অঞ্চলভিত্তিক ভৌত পরিবেশ, সম্পদ বিতরণ এবং গুরুত্ব',
          value: 3,
        ),
        SubSubject(
          name: 'বাংলাদেশের পরিবেশ: প্রকৃতি এবং সম্পদ, প্রধান চ্যালেঞ্জ',
          value: 4,
        ),
        SubSubject(
          name:
              'বাংলাদেশ এবং বৈশ্বিক জলবায়ু পরিবর্তন, স্থানীয়, আঞ্চলিক এবং বৈশ্বিক প্রভাব',
          value: 5,
        ),
        SubSubject(name: 'অন্যান্য', value: 6),
      ],
    ),
    Subject(
      name: 'আইসিটি',
      value: 'ict',
      subSubjects: [
        SubSubject(name: 'Computer Fundamental', value: 1),
        SubSubject(name: 'c/c++', value: 2),
        SubSubject(name: 'Java', value: 3),
        SubSubject(name: 'Data Structure & Algorithm', value: 4),
        SubSubject(name: 'Discrete Mathematics', value: 5),
        SubSubject(name: 'Computer Architectuer', value: 6),
        SubSubject(name: 'Networking & Data Communication', value: 7),
        SubSubject(name: 'Operating System', value: 8),
        SubSubject(name: 'DBMS', value: 9),
        SubSubject(name: 'Compiler Design', value: 10),
        SubSubject(name: 'Digital Logic Design', value: 11),
        SubSubject(name: 'Software Engineering', value: 12),
        SubSubject(name: 'Web Technology', value: 13),
        SubSubject(name: 'Microprocessor & Microcontroller', value: 14),
        SubSubject(name: 'Cyber Security', value: 15),
        SubSubject(name: 'Cloud Computing', value: 16),
        SubSubject(name: 'Data Mining & AI', value: 17),
        SubSubject(name: 'Others', value: 18),
      ],
    ),
    Subject(
      name: 'মানসিক দক্ষতা',
      value: 'mental_ability',
      subSubjects: [
        SubSubject(name: 'Verbal Reasoning', value: 1),
        SubSubject(name: 'Problem Solving', value: 2),
        SubSubject(name: 'Mechanical Reasoning', value: 3),
        SubSubject(name: 'Space Relation', value: 4),
        SubSubject(name: 'Numerical Ability', value: 5),
        SubSubject(name: 'Others', value: 6),
      ],
    ),
    Subject(
      name: 'নৈতিকতা, মূল্যবোধ ও সুশাসন',
      value: 'moral_values_and_good_governance',
      subSubjects: [],
    ),
    Subject(
      name: 'সাধারণ বিজ্ঞান',
      value: 'general_science',
      subSubjects: [
        SubSubject(name: 'General Science', value: 1),
        SubSubject(name: 'Physics', value: 2),
        SubSubject(name: 'Chemistry', value: 3),
        SubSubject(name: 'Biology', value: 4),
      ],
    ),
  ]);

  void selectSingleSubject(String subjectValue) {
    selectedSingleSubject.value = subjectValue;
    update();
  }

  void toggleSubject(Subject subject) {
    if (selectedSubjects.containsKey(subject.value)) {
      selectedSubjects.remove(subject.value);
      for (var subSubject in subject.subSubjects) {
        subSubject.isSelected.value = false;
      }
    } else {
      selectedSubjects[subject.value] =
          subject.subSubjects.map((sub) => sub.value).toList();
      for (var subSubject in subject.subSubjects) {
        subSubject.isSelected.value = true;
      }
    }
    update();
  }

  void toggleSubSubject(Subject subject, SubSubject subSubject) {
    if (subSubject.isSelected.value) {
      subSubject.isSelected.value = false;
      selectedSubjects[subject.value]?.remove(subSubject.value);
      if (selectedSubjects[subject.value]?.isEmpty ?? true) {
        selectedSubjects.remove(subject.value);
      }
    } else {
      subSubject.isSelected.value = true;
      if (selectedSubjects.containsKey(subject.value)) {
        selectedSubjects[subject.value]?.add(subSubject.value);
      } else {
        selectedSubjects[subject.value] = [subSubject.value];
      }
    }
    update();
  }

  Map<String, dynamic> getSelectedData() {
    Map<String, dynamic> data = {
      "category_id": null,
      "subject": selectedSubjects.keys.toList(),
      "sub_subject_bangla": selectedSubjects['bangla'] ?? null,
      "sub_subject_english": selectedSubjects['english'] ?? null,
      "sub_subject_math": selectedSubjects['mathematics'] ?? null,
      "sub_subject_baf": selectedSubjects['bangladesh_affairs'] ?? null,
      "sub_subject_iaf": selectedSubjects['internatinal_affairs'] ?? null,
      "sub_subject_geo": selectedSubjects['geography'] ?? null,
      "sub_subject_ict": selectedSubjects['ict'] ?? null,
      "sub_subject_metal_ability": selectedSubjects['mental_ability'] ?? null,
      "sub_subject_gensc": selectedSubjects['general_science'] ?? null,
      "question_no": numberOfQuestions.text.trim(),
      "exam_time": time.text.trim(),
    };

    if (selectedSingleSubject.value.isNotEmpty) {
      data['subject'] = [selectedSingleSubject.value];
    }
    return data;
  }

  void loadQuestion() async {
    try {
      debugPrint('0');
      isLoading(true);
      debugPrint('1');

      final response = await _apiService.fetchQuestionsForYearlyExam(
        getSelectedData(),
        box.read('token'),
      );

      debugPrint('2');
      if (response.data['success'] == false) {
        debugPrint('3');
        showDialog(
          context: Get.context!,
          builder:
              (_) => QuestionFetchingErrorDialogue(
                message: response.data['message'].toString(),
              ),
        );
        return;
      }

      List<dynamic> data = response.data['data'];
      debugPrint('API Raw Data Length: ${data.length}');

      List<Question> q = data.map((json) => Question.fromJson(json)).toList();
      Get.offNamed(
        Routes.EXAM_ROOM,
        arguments: {
          'questions': q,
          'time': response.data['exam_time_minutes'].toString(),
          'title': examName.text,
        },
      );

      // startTimer(response.data['exam_time_minutes'].toString());
    } catch (e) {
      debugPrint('Something went wrong: $e');
    } finally {
      // isSuccess(true);
      isLoading(false);
    }
  }
}
