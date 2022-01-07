// const BASE_URL = "http://172.105.24.23/api";
const BASE_URL = "https://mflip.com/api";

//////////// api End////////////////
/// AUTH ///
const api_loginApiEnd = "/login";
const api_getUserData = "/user";
const api_libraryDataEnd = "/get_resource_library";
const api_resetToken = '/reset_push_token';
// team
const api_teamdetail = '/get_teamlist';

/// News ///
const api_getNews = "/get_comm_notification";
const api_newsLike = '/set_notification_like';
const api_newsDislike = '/set_notification_unlike';
// Incentive
const api_mostPopularIncentive = "/most_popular_incentives_list";
const api_IncentiveHistory = '/new_incentive_details';
const api_IncentiveEarned = '/badges_earned_list';
const api_newIncentive = '/get_incentive_list_new';
const api_usedIncentive = '/new_used_incentive_details';
// timer card
const api_timerHistory = '/get_timecard_history_2021';
// carrer
const api_career = '/get_new_career_path';
//survey
const api_getSurvey = '/get_new_survey';
// leaderboard
const api_leader_board_all_new = '/get_leader_board_all_new';
const api_teamLeader = '/get_leader_board_new';
// schedule
const api_schedule = '/get_profile_schedule';
const api_set_time_off_request = '/set_time_off_request';
