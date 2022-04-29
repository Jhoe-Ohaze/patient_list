import 'package:flutter/material.dart';
import 'package:patient_list/backend/misc_functions.dart';
import 'package:patient_list/backend/patient.dart';
import 'package:patient_list/widgets/widget_functions.dart';

class PatientTile extends StatelessWidget {
  final Patient patient;
  final BuildContext scaffoldContext;
  PatientTile({
    required this.patient,
    required this.scaffoldContext,
    Key? key,
  }) : super(key: key);

  final double titleSize = 16;
  final double subtitleSize = 11;
  final widgetFunc = WidgetFunctions();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Card(
        elevation: 2,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(patient.image),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            patient.fullName,
                            style: TextStyle(
                              fontSize: titleSize,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          patient.birthDate,
                          style: TextStyle(
                            fontSize: subtitleSize,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.75),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Text(
                            MiscFunctions.getGenderAndIcon(patient.gender),
                            style: TextStyle(
                              fontSize: subtitleSize,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.75),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      MiscFunctions.getFlag(patient.nationality),
                      style: const TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => widgetFunc.buildPatientModal(
                    patient: patient,
                    context: scaffoldContext,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
