import 'package:flutter/material.dart';
import 'package:patient_list/backend/misc_functions.dart';
import 'package:patient_list/backend/patient.dart';
import 'package:patient_list/widgets/info_tile.dart';

class WidgetFunctions {
  void buildPatientModal(
      {required Patient patient, required BuildContext context}) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        double modalHeight = MediaQuery.of(context).size.height * 5 / 6;
        double radius = 64;
        double width = MediaQuery.of(context).size.width;
        return SizedBox(
          height: modalHeight,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  SizedBox(height: radius * 3 - 10),
                  Flexible(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: modalHeight - radius,
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      width: width,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoTile(
                              title: 'Patient ID',
                              subtitle: patient.id,
                            ),
                            InfoTile(
                              title: 'Gender',
                              subtitle: MiscFunctions.getGenderAndIcon(
                                  patient.gender),
                            ),
                            InfoTile(
                              title: 'Email',
                              subtitle: patient.email,
                            ),
                            InfoTile(
                              title: 'Birth Date',
                              subtitle: patient.birthDate,
                            ),
                            InfoTile(
                              title: 'Phone',
                              subtitle: patient.phone,
                            ),
                            InfoTile(
                              title: 'Cellphone',
                              subtitle: patient.cellphone,
                            ),
                            InfoTile(
                              title: 'Nationality',
                              subtitle:
                                  MiscFunctions.getFlag(patient.nationality) +
                                      ' ' +
                                      patient.nationality,
                            ),
                            InfoTile(
                              title: 'Address',
                              subtitle: patient.addressStreet +
                                  '.\n' +
                                  patient.addressCity +
                                  ' - ' +
                                  patient.addressState,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: radius),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: radius * 2,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.all(10),
                          height: radius,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            color: Colors.grey,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          alignment: Alignment.topCenter,
                          width: width,
                          child: Text(
                            patient.fullName,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              PhysicalModel(
                elevation: 5,
                shape: BoxShape.circle,
                color: Colors.black,
                child: CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(patient.image),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
