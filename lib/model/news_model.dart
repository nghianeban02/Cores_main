import '../utils/utils.dart';

class NewsModel {
  int? id;
  String? code;
  String? image;
  String? link;
  int? status;

  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;

  NewsModel({
    this.id,
    this.code,
    this.image,
    this.link,
    this.status,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'].toString();
    image = json['image'];
    link = json['link'];
    status = json['status'];

    title = json['title'];
    description = json['description'];
    createdAt = Utils().convertDate(json['created_at'] + '.000Z' ?? "2022-10-12T03:58:59.000Z");
    updatedAt = Utils().convertDate(json['updated_at'] ?? "2022-10-12T03:58:59.000Z");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['image'] = image;
    data['link'] = link;
    data['status'] = status;

    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }

  @override
  NewsModel fromJson(json) {
    return NewsModel.fromJson(json);
  }
}
