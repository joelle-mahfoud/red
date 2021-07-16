class Contactform {
  final String id, contactFormEmail;
  final List<Email> contactEmails;
  final List<Phone> contactPhones;
  final List<Addresse> contactAddresses;
  Contactform(
      {this.id,
      this.contactFormEmail,
      this.contactEmails,
      this.contactPhones,
      this.contactAddresses});

  factory Contactform.fromJson(Map<String, dynamic> json) {
    return Contactform(
      id: json['id'],
      contactFormEmail: json['contact_form_email'],
      contactEmails: json.containsKey("contact_emails")
          ? List<Email>.from(
              json["contact_emails"].map((x) => Email.fromJson(x)))
          : null,
      contactPhones: json.containsKey("contact_phones")
          ? List<Phone>.from(
              json["contact_phones"].map((x) => Phone.fromJson(x)))
          : null,
      contactAddresses: json.containsKey("contact_addresses")
          ? List<Addresse>.from(
              json["contact_addresses"].map((x) => Addresse.fromJson(x)))
          : null,
    );
  }
}

class Email {
  final String titleEn, email;
  Email({this.titleEn, this.email});

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(email: json['email'], titleEn: json['title_en']);
  }
}

class Phone {
  final String titleEn, phone;
  Phone({this.titleEn, this.phone});

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(phone: json['phone'], titleEn: json['title_en']);
  }
}

class Addresse {
  final String titleEn, addressEn;
  Addresse({this.titleEn, this.addressEn});

  factory Addresse.fromJson(Map<String, dynamic> json) {
    return Addresse(titleEn: json['title_en'], addressEn: json['address_en']);
  }
}
