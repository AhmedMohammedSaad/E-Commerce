class CategoryModel {
  final String nameCategory;
  final String urlImage;

  CategoryModel({required this.nameCategory, required this.urlImage});

  static List<CategoryModel> categrys = [
    CategoryModel(nameCategory: 'Mens', urlImage: 'assets/images/men1.jpg'),
    CategoryModel(nameCategory: 'Womens', urlImage: 'assets/images/women.jpg'),
    CategoryModel(nameCategory: 'Children', urlImage: 'assets/images/Kids.jpg'),
    CategoryModel(nameCategory: 'Shoes', urlImage: 'assets/images/shoes1.jpg'),
    CategoryModel(
        nameCategory: 'Accessories',
        urlImage: 'assets/images/accessories.avif'),
  ];
}
