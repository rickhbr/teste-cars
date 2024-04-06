class Lead {
  final String name;
  final String email;
  final String phone;
  final int carId;

  Lead(
      {required this.name,
      required this.email,
      required this.phone,
      required this.carId});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'carId': carId,
    };
  }

  factory Lead.fromMap(Map<String, dynamic> map) {
    return Lead(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      carId: map['carId'],
    );
  }
}
