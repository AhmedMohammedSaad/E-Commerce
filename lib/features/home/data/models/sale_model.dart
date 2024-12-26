class SaleModel {
  final String image;
  final String title;
  final String sale;
  final double price;
  final double oldePrice;

  SaleModel({
    required this.image,
    required this.title,
    required this.sale,
    required this.price,
    required this.oldePrice,
  });

  static List<SaleModel> salleSliderList = [
    SaleModel(
      image:
          'https://static.toiimg.com/thumb/msid-113193500,width-400,resizemode-4/113193500.jpg',
      title: 'Iphone 16 pro Max',
      sale: '50% OFF',
      price: 30,
      oldePrice: 40,
    ),
    SaleModel(
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRipW0pcxvQZ3S74WsryGYkchNz5CzFH7y6Kg&s',
      title: 'Iphone 14 pro Max',
      sale: '50% OFF',
      price: 30,
      oldePrice: 40,
    ),
    SaleModel(
      image:
          'https://static.toiimg.com/thumb/msid-113193500,width-400,resizemode-4/113193500.jpg',
      title: 'Iphone',
      sale: '50% OFF',
      price: 30,
      oldePrice: 40,
    ),
    SaleModel(
      image:
          'https://static.toiimg.com/thumb/msid-113193500,width-400,resizemode-4/113193500.jpg',
      title: 'Iphone',
      sale: '50% OFF',
      price: 30,
      oldePrice: 40,
    ),
    SaleModel(
      image:
          'https://static.toiimg.com/thumb/msid-113193500,width-400,resizemode-4/113193500.jpg',
      title: 'Iphone',
      sale: '50% OFF',
      price: 30,
      oldePrice: 40,
    ),
    SaleModel(
      image:
          'https://static.toiimg.com/thumb/msid-113193500,width-400,resizemode-4/113193500.jpg',
      title: 'Iphone',
      sale: '50% OFF',
      price: 30,
      oldePrice: 40,
    ),
  ];
}
