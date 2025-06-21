class CategoryModel {
  final String nameCategory;
  final String urlImage;

  CategoryModel({required this.nameCategory, required this.urlImage});

  static List<CategoryModel> categrys = [
    CategoryModel(nameCategory: 'Applications', urlImage: 'assets/images/application.png'),
    CategoryModel(nameCategory: 'Systems', urlImage: 'assets/images/systems.jpg'),
    CategoryModel(nameCategory: 'Websites', urlImage: 'assets/images/web_site.png'),
    //  CategoryModel(nameCategory: 'Shoes', urlImage: 'assets/images/shoes1.jpg'),
  ];
}
