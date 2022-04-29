extension StringCapitalize on String {
  String toCapitalized() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

class MiscFunctions {
  static String getFlag(String countryCode) {
    if (countryCode.isEmpty) return '';

    int flagOffset = 0x1F1E6;
    int asciiOffset = 0x41;

    int char1 = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    int char2 = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

    String flag = String.fromCharCodes([char1, char2]);
    return flag;
  }

  static String getGenderAndIcon(String gender) {
    String icon;
    if (gender == 'male') {
      icon = '♂';
    } else {
      icon = '♀';
    }
    return icon + ' ' + gender.toCapitalized();
  }
}
