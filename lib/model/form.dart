/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String name;
  String nim;
  String email;
  String mobileNo;
  String feedback;

  FeedbackForm(this.name, this.nim, this.email, this.mobileNo, this.feedback);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
        "${json['name']}",
        "${json['nim']}",
        "${json['email']}",
        "${json['mobileNo']}",
        "${json['feedback']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'nim': nim,
        'email': email,
        'mobileNo': mobileNo,
        'feedback': feedback
      };
}
