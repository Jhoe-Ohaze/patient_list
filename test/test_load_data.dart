import 'package:patient_list/backend/database.dart';
import 'package:test/test.dart';

void main(List<String> args) {
  test('Should return a list of Patients', (() async {
    await Database.loadData();
    expect(Database.patientList.isNotEmpty, true);
  }));
}
