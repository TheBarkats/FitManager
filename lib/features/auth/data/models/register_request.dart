class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String? phone;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    this.phone,
  });

  Map<String, dynamic> toJson() {
    final map = {
      'name': name,
      'email': email,
      'password': password,
    };
    
    if (phone != null && phone!.isNotEmpty) {
      map['phone'] = phone!;
    }
    
    return map;
  }
}
