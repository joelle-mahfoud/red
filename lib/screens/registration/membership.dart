class Membership {
  final String fname;
  final String lname;
  final String email;
  final String password;
  final String dob;
  final String country;
  final String companyName;
  final String position;

  set companyName(String val) {
    companyName = val;
  }

  set position(String val) {
    position = val;
  }

  Membership(
      {this.fname,
      this.lname,
      this.email,
      this.password,
      this.dob,
      this.country,
      this.companyName,
      this.position});
}
