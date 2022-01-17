import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/data/providers/auth_provider.dart';
import 'package:southwind/data/providers/carrer_notifer.dart';
import 'package:southwind/data/providers/incentive_provider.dart';
import 'package:southwind/data/providers/leadrboard_provider.dart';
import 'package:southwind/data/providers/learning_provider.dart';
import 'package:southwind/data/providers/library_provider.dart';
import 'package:southwind/data/providers/news_comment_norifier.dart';
import 'package:southwind/data/providers/news_notifier.dart';
import 'package:southwind/data/providers/schedule_provider.dart';
import 'package:southwind/data/providers/survey_provider.dart';
import 'package:southwind/data/providers/timerCard_notifier.dart';

final authProvider = ChangeNotifierProvider((ref) => AuthNotifier());
final libraryNotifier = ChangeNotifierProvider((_ref) => LibraryNotifier(_ref));
final newsNotifierProvider = ChangeNotifierProvider((_ref) => NewsNotifier());
final incentiveNotifierProvider =
    ChangeNotifierProvider((_ref) => IncentiveNotifier());
final timerNotifierProvider =
    ChangeNotifierProvider((_ref) => TimerCardNotifier());
final carerNotifierProvider =
    ChangeNotifierProvider((_ref) => CareerProvider());
final surveyNotifierProvider =
    ChangeNotifierProvider((_ref) => SurveyProvider());
final leaderBoardNotifierProvider =
    ChangeNotifierProvider((_ref) => LeaderBoardProvider());
final scheduleNotifierProvider =
    ChangeNotifierProvider((_ref) => ScheduleProvider());
final learningProvider =  ChangeNotifierProvider((_ref) => LearningNotifier());
final commentNotifierProvider =
    ChangeNotifierProvider.family<NewsCommentNotifier, String>(
        (_ref, id) => NewsCommentNotifier(id));
