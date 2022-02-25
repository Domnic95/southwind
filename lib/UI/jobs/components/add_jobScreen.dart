import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:southwind/UI/components/common_appbar.dart';
import 'package:southwind/UI/login/log_in.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/data/providers/providers.dart';
import 'package:southwind/utils/helpers.dart';

class AddJob extends StatefulHookWidget {
  AddJob({Key? key}) : super(key: key);

  @override
  State<AddJob> createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  late String selectedJob;

  late String selectedPayment;
  late String selectedMember;
  late String selectedAdditionalMember;
  DateTime selectedDate = DateTime.now();
  // List<String> typeJob = ["Residencial", "Commercial"];
  // List<String> typePayment = ["Select payment type", "Check", "Credit Card"];
  // List<String> typeMember = [
  //   "1",
  //   "2",
  //   "3",
  //   "4",
  //   "5",
  //   "6",
  //   "7",
  //   "8",
  //   "9",
  //   "10+"
  // ];
  // List<String> additionalMembers = ["Aarion Jenkins", "Aaron Hosack"];

  TextEditingController jobIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController myCreditTipController = TextEditingController();
  TextEditingController totalJobRevenue = TextEditingController();
  TextEditingController myJobRevenue = TextEditingController();
  TextEditingController additionalMyJobRevenue =
      TextEditingController(text: "50");

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final jobsService = context.read(jobsNotifierProvider);
    selectedJob = jobsService.typeJob.first;
    selectedPayment = jobsService.typePayment.first;
    selectedMember = jobsService.typeMember.first;
    selectedAdditionalMember = jobsService.additionalMembers.first;
    dateController.text =
        "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final jobsService = useProvider(jobsNotifierProvider);
    double ver = 10;
    return Scaffold(
      appBar: CommonAppbar(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                EditTextfild(
                  controller: jobIdController,
                  hint: "Enter Job Id",
                ),
                SizedBox(
                  height: ver,
                ),   
                DropDownWidget(
                  labelTitle: "Job type",
                  onChanged: (c) {
                    setState(() {
                      selectedJob = c!;
                    });
                  },
                  title: jobsService.typeJob,
                  selectedvalue: selectedJob,
                ),
                SizedBox(
                  height: ver,
                ),
                EditTextfild(
                  controller: jobIdController,
                  hint: "Enter my credit card tip",
                ),

                SizedBox(
                  height: ver,
                ),
                EditTextfild(
                  readibility: true,
                  suffixicon: InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Icon(Icons.calendar_today)),
                  controller: dateController,
                  hint: "Select job date",
                ),
                SizedBox(
                  height: ver,
                ),
                DropDownWidget(
                  labelTitle: "Payment type",
                  onChanged: (c) {
                    setState(() {
                      selectedPayment = c!;
                    });
                  },
                  title: jobsService.typePayment,
                  selectedvalue: selectedPayment,
                ),
                SizedBox(
                  height: ver,
                ),
                EditTextfild(
                  controller: jobIdController,
                  hint: "Enter total job revenue",
                ),
                SizedBox(
                  height: ver,
                ),
                DropDownWidget(
                  labelTitle: "Number of team member",
                  onChanged: (c) {
                    setState(() {
                      selectedMember = c!;
                    });
                  },
                  title: jobsService.typeMember,
                  selectedvalue: selectedMember,
                ),
                SizedBox(
                  height: ver,
                ),
                EditTextfild(
                  controller: jobIdController,
                  hint: "Enter my job revenue",
                ),
                if (selectedMember == "2")
                  Column(
                    children: [
                      SizedBox(
                        height: ver,
                      ),
                      DropDownWidget(
                        labelTitle: "Additional team member",
                        onChanged: (c) {
                          setState(() {
                            selectedAdditionalMember = c!;
                          });
                        },
                        title: jobsService.additionalMembers,
                        selectedvalue: selectedAdditionalMember,
                      ),
                      SizedBox(
                        height: ver,
                      ),
                      EditTextfild(
                        controller: additionalMyJobRevenue,
                        hint: "Additional my job revenue",
                      ),
                    ],
                  ),
                SizedBox(
                  height: ver,
                ),
                InkWell(
                  onTap: () async {
                    await jobsService.addService(
                        job_id: jobIdController.text,
                        team_member: selectedMember,
                        job_type: selectedJob,
                        job_date: dateController.text,
                        my_credit_card_tip: myCreditTipController.text,
                        total_job_revenue: totalJobRevenue.text,
                        number_of_team_member: selectedMember,
                        additional_team_member: selectedAdditionalMember,
                        additional_my_job_revenue: additionalMyJobRevenue.text,
                        payment_type: selectedPayment);
                    showToast("Add sucessfully");
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Add Job',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //     style: ElevatedButton.styleFrom(),
                //     onPressed: () {},
                //     child: Text('Add Job'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
        dateController.text =
            "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      });
  }
}
