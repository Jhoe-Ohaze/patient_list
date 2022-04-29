class Patient {
  final Map<String, dynamic> _patient;
  Patient(this._patient);

  String get firstName => _patient['name']['first'];
  String get lastName => _patient['name']['last'];
  String get fullName =>
      _patient['name']['first'] + ' ' + _patient['name']['last'];

  String get addressStreet =>
      _patient['location']['street']['name'] +
      ', ' +
      _patient['location']['street']['number'].toString();
  String get addressCity => _patient['location']['city'];
  String get addressState => _patient['location']['state'];

  String get id =>
      _patient['id']['name'].toString() +
      ' ' +
      _patient['id']['value'].toString();
  String get email => _patient['email'];
  String get gender => _patient['gender'];
  String get nationality => _patient['nat'];

  String get birthDate {
    String date = _patient['dob']['date'].toString().substring(0, 10);
    date = date.replaceAll(RegExp(r'-'), '/');
    return date;
  }

  String get birthTime => _patient['dob']['date'].toString().substring(11, 19);

  String get phone => _patient['phone'];
  String get cellphone => _patient['cell'];

  String get image => _patient['picture']['large'];
}
