class UserModal {
  String userId;
  String name;
  String mobile;
  String email;
  String designation;
  bool isActive;
  bool isAdmin;
  UserModal({required this.userId, required this.name, required this.designation, required this.email, required this.mobile, required this.isActive, required this.isAdmin});

  factory UserModal.fromJson(Map<String, dynamic> _json) {
    return UserModal(
        userId: _json['userId'],
        name: _json['name'],
        mobile: _json['mobile'],
        email: _json['email'],
        designation: _json['designation'],
        isActive: _json['isActive'],
        isAdmin: _json['isAdmin']);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = Map();
    map['userId'] = userId;
    map['name'] = name;
    map['mobile'] = mobile;
    map['email'] = email;
    map['designation'] = designation;
    map['isAdmin'] = isAdmin;
    map['isActive'] = isActive;
    return map;
  }
}
