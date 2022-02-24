import 'package:southwind/data/http_client/dio_client.dart';
import 'package:southwind/data/providers/base_notifer.dart';

class JobsService extends BaseNotifier {
  List<String> typeJob = ["Residencial", "Commercial"];
  List<String> typePayment = ["Select payment type", "Check", "Credit Card"];
  List<String> typeMember = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10+"
  ];
  List<String> additionalMembers = ["Aarion Jenkins", "Aaron Hosack"];
  Future addService({
    required String job_id,
    required String team_member,
    required String job_type,
    required String job_date,
    required String my_credit_card_tip,
    required String total_job_revenue,
    required String number_of_team_member,
    required String additional_team_member,
    required String additional_my_job_revenue,
    required String payment_type,
  }) async {
    Map<String, dynamic> data = {
      "job_id": job_id,
      "team_member": team_member,
      "job_type": job_type == typeJob.first ? 1 : 2,
      "job_date": job_date,
      "my_credit_card_tip": my_credit_card_tip,
      "total_job_revenue": total_job_revenue,
      "my_job_revenue": 1500,
      "number_of_team_member": number_of_team_member,
      if (additional_team_member == "2")
        "additional_team_member": additional_team_member,
      if (additional_team_member == "2")
        "additional_my_job_revenue": additional_my_job_revenue,
      if (payment_type == typePayment.first)
        "payment_type": payment_type == typePayment,
    };
    // await dioClient.postWithFormData(apiEnd: api_addPost, data: data);
    // notifyListeners();
  }
}
