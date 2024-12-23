class CarouselSliderClass {
  final String image;
  final String title;
  final String supTitle;

  CarouselSliderClass({
    required this.image,
    required this.title,
    required this.supTitle,
  });

  static List<CarouselSliderClass> carouselSliderList = [
    CarouselSliderClass(
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRipW0pcxvQZ3S74WsryGYkchNz5CzFH7y6Kg&s',
      title: 'Iphone',
      supTitle: 'Apple iPhone 16 launch',
    ),
    CarouselSliderClass(
      image:
          'https://static.toiimg.com/thumb/msid-113193500,width-400,resizemode-4/113193500.jpg',
      title: 'Iphone',
      supTitle: 'Apple iPhone 16 launch',
    ),
    CarouselSliderClass(
      image:
          'https://static.toiimg.com/thumb/msid-113193500,width-400,resizemode-4/113193500.jpg',
      title: 'Iphone',
      supTitle: 'Apple iPhone 16 launch',
    ),
  ];
}
