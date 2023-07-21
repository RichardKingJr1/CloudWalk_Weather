// ignore_for_file: public_member_api_docs, sort_constructors_first
class Failure implements Exception {
  String title;
  String message;
  
  Failure({
    required this.title,
    required this.message,
  });

}
