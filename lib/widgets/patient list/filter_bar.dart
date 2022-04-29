import 'package:flutter/material.dart';
import 'package:patient_list/backend/database.dart';
import 'package:patient_list/backend/misc_functions.dart';

class FilterBar extends StatelessWidget {
  final ValueNotifier<String> selectedGender;
  final ValueNotifier<String> selectedNationality;
  const FilterBar({
    required this.selectedGender,
    required this.selectedNationality,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              child: InputDecorator(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Gender'),
                    isDense: true),
                child: ValueListenableBuilder<String>(
                  valueListenable: selectedGender,
                  builder: (context, value, child) {
                    return DropdownButton<String>(
                      isDense: true,
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: value,
                      items: Database.genderList.map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (option) => selectedGender.value = option!,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: InputDecorator(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Nationality'),
                    isDense: true),
                child: ValueListenableBuilder<String>(
                  valueListenable: selectedNationality,
                  builder: (context, value, child) {
                    return DropdownButton<String>(
                      isDense: true,
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: value,
                      items: Database.nationalityList
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          String flag = MiscFunctions.getFlag(value);
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(flag + ' ' + value),
                          );
                        },
                      ).toList(),
                      onChanged: (option) =>
                          selectedNationality.value = option!,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
