import 'package:equatable/equatable.dart';

class JobAd extends Equatable {
  final String title;
  final String description;
  final String? photo; //////////////!

  const JobAd({required this.title, required this.description, this.photo});

  @override
  List<Object?> get props => [title, description, photo];
}
