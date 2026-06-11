import 'product.dart';

class ProductDAO {
  final List<Product> _products = [
    Product(
      id: 1,
      description: 'Gặp và kịt kin cùng Jang Won-young',
      detail:
          'Thành Viên nhóm nhạc nữ Hàn Quốc IZ*ONE, ra mắt năm 2018. Cô được biết đến với vẻ đẹp trong sáng và tài năng đa dạng, từ ca hát đến nhảy múa. Jang Won-young nhanh chóng trở thành một trong những idol được yêu thích nhất thế hệ mới. Nói chung là xinh',
      price: 150000,
      discontPercen: 10,
      image: 'assets/images/WY.jpg',
      rating: 4.5,
      reviewCount: 128,
    ),
    Product(
      id: 2,
      description: 'Hít thở chung với G-Dragon',
      detail:
          'Nhóm trưởng nhóm nhạc nam Hàn Quốc BIGBANG, ra mắt năm 2006. G-Dragon nổi tiếng với phong cách thời trang độc đáo và khả năng sáng tác nhạc xuất sắc. Anh đã có ảnh hưởng lớn đến làng nhạc K-pop và được mệnh danh là "Vua K-pop". Nói chung là chất mấy con gà biết gì ?',
      price: 350000,
      discontPercen: 20,
      image: 'assets/images/GD.jpg',
      rating: 4.0,
      reviewCount: 85,
    ),
    Product(
      id: 3,
      description: 'Đi uống nước cùng IU',
      detail:
          'Là một ca sĩ và diễn viên người Hàn Quốc, nổi tiếng với giọng hát trong trẻo và khả năng diễn xuất tốt. Xinh',
      price: 500000,
      discontPercen: 15,
      image: 'assets/images/IU.jpg',
      rating: 4.8,
      reviewCount: 212,
    ),
  ];

  List<Product> getAllProduct() {
    return _products;
  }

  List<Product> findProductByName(String name) {
    return _products
        .where((p) => p.description.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }
}
