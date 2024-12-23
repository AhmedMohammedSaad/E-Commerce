class CategoryModel {
  final String nameCategory;
  final String urlImage;

  CategoryModel({required this.nameCategory, required this.urlImage});

  static List<CategoryModel> categrys = [
    CategoryModel(
        nameCategory: 'Accessories',
        urlImage: 'assets/images/accessories.avif'),
    CategoryModel(nameCategory: 'Mobile', urlImage: 'assets/images/mobile.jpg'),
    CategoryModel(nameCategory: 'Shoes', urlImage: 'assets/images/shoes1.jpg'),
    CategoryModel(nameCategory: 'Mens', urlImage: 'assets/images/men1.jpg'),
  ];
}
