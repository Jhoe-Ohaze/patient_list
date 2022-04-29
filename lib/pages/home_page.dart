import 'package:flutter/material.dart';
import 'package:patient_list/backend/database.dart';
import 'package:patient_list/backend/patient.dart';
import 'package:patient_list/widgets/patient list/filter_bar.dart';
import 'package:patient_list/widgets/patient list/patient_tile.dart';
import 'package:patient_list/widgets/patient list/search_bar.dart';
import 'package:patient_list/widgets/patient%20list/slide_down_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  final scrollCrontroller = ScrollController();
  final showFilters = ValueNotifier<bool>(false);
  final isTextFocused = ValueNotifier<bool>(false);
  final selectedGender = ValueNotifier<String>('');
  final selectedNationality = ValueNotifier<String>('');

  List<Patient> patientList = Database.patientList;

  @override
  void initState() {
    super.initState();
    scrollCrontroller.addListener(_loadMore);
  }

  void _search() {
    setState(() {
      patientList = [];
      bool natOK = false;
      bool genderOK = false;
      bool nameOK = false;
      for (int i = 0; i < Database.patientList.length; i++) {
        Patient patient = Database.patientList.elementAt(i);
        if (selectedNationality.value.isEmpty) {
          natOK = true;
        } else {
          natOK = patient.nationality == selectedNationality.value;
        }

        if (selectedGender.value.isEmpty) {
          genderOK = true;
        } else {
          genderOK = patient.gender == selectedGender.value;
        }

        if (textController.text.isEmpty) {
          nameOK = true;
        } else {
          nameOK = patient.fullName
              .toLowerCase()
              .contains(textController.text.toLowerCase());
        }

        if (nameOK & genderOK & natOK) patientList.add(patient);
      }
    });
  }

  void _loadMore() async {
    if (scrollCrontroller.position.extentAfter == 0) {
      await Future.delayed(const Duration(seconds: 1));
      await Database.loadData(context: context);
      _search();
      scrollCrontroller.jumpTo(scrollCrontroller.position.pixels - 100);
    }
  }

  Widget _patientListView() {
    return ValueListenableBuilder<RequestStatus?>(
      valueListenable: Database.requestBehavior,
      builder: (context, value, child) {
        switch (value) {
          case RequestStatus.FAILED:
            return const Center(child: Icon(Icons.error));
          default:
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: patientList.length,
              itemBuilder: (context, index) {
                final patient = patientList.elementAt(index);
                return PatientTile(
                  patient: patient,
                  scaffoldContext: context,
                );
              },
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Patient List'),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scrollbar(
          thickness: 10,
          controller: scrollCrontroller,
          child: SingleChildScrollView(
            controller: scrollCrontroller,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: SearchBar(
                    textController: textController,
                    showFilters: showFilters,
                    onPressed: _search,
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: showFilters,
                  child: _patientListView(),
                  builder: (context, value, child) {
                    double constraintTrue =
                        MediaQuery.of(context).size.height - 230;
                    double constraintFalse =
                        MediaQuery.of(context).size.height - 165;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          SlideDownWidget(
                            child: value
                                ? FilterBar(
                                    selectedGender: selectedGender,
                                    selectedNationality: selectedNationality,
                                  )
                                : Container(),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight:
                                    value ? constraintTrue : constraintFalse),
                            child: child,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.refresh),
                      SizedBox(width: 10),
                      Text('Loading More'),
                    ],
                  ),
                ),
                const LinearProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    showFilters.dispose();
    selectedGender.dispose();
    selectedNationality.dispose();

    scrollCrontroller.dispose();
    scrollCrontroller.removeListener(_loadMore);
  }
}
