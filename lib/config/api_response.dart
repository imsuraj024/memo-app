class ApiResponse<T> {
  final String message;
  final int statusCode;
  final T data;

  ApiResponse({
    required this.message,
    required this.statusCode,
    required this.data,
  });
}

class CategoryList {
  String? id;
  String? catName;
  String? catImage;
  String? thumbImage;

  CategoryList({this.id, this.catName, this.catImage, this.thumbImage});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['cat_name'];
    catImage = json['cat_image'];
    thumbImage = json['thumb_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cat_name'] = catName;
    data['cat_image'] = catImage;
    data['thumb_image'] = thumbImage;
    return data;
  }
}

class SubCategory {
  String? id;
  String? catName;
  String? catImg;
  String? thumbImage;

  SubCategory({this.id, this.catName, this.catImg, this.thumbImage});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['cat_name'];
    catImg = json['cat_img'];
    thumbImage = json['thumb_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cat_name'] = catName;
    data['cat_img'] = catImg;
    data['thumb_image'] = thumbImage;
    return data;
  }
}

class ProjectItem {
  String? id;
  String? title;
  String? description;
  String? images;
  String? thumbImage;

  ProjectItem({
    this.id,
    this.title,
    this.description,
    this.images,
    this.thumbImage,
  });

  ProjectItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    images = json['images'];
    thumbImage = json['thumb_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['images'] = images;
    data['thumb_image'] = thumbImage;
    return data;
  }
}
