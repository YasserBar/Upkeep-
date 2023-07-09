import '../../domain/entities/job_ad.dart';

class JobAdModel extends JobAd {
  const JobAdModel(
      {required String title, required String description, String? photo})
      : super(
          title: title,
          description: description,
          photo: photo,
        );

  factory JobAdModel.fromJson(Map<String, dynamic> json) => JobAdModel(
        title: json['title'] as String,
        description: json['description'] as String,
        photo: json['photo'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'photo': photo,
      };
}
