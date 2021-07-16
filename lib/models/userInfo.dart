class UserInfo {
  final String id,
      fname,
      lname,
      dob,
      email,
      country,
      companyName,
      position,
      createdDate;

  UserInfo(
      {this.id,
      this.fname,
      this.lname,
      this.dob,
      this.email,
      this.country,
      this.companyName,
      this.position,
      this.createdDate});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      dob: json['dob'],
      email: json['email'],
      country: json['country'],
      companyName: json['company_name'],
      position: json['position'],
      createdDate: json['created_date'],
    );
  }
}
