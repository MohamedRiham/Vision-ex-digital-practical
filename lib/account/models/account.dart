class Account {
  final String username;
  final String email;

  Account({required this.username, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      username: map['username'],
      email: map['email'],
    );
  }
}
