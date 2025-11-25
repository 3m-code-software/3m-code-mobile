class Product {
  final String id;
  final String name;
  final String category;
  final String subcategory;
  final double price;
  final double? oldPrice;
  final double rating;
  final String description;
  final String image;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.price,
    this.oldPrice,
    required this.rating,
    required this.description,
    required this.image,
  });
}

class ProductsData {
  static final List<Product> allProducts = [
    // ELECTRONICS (8 products) - Using images 1-8
    Product(id: 'el001', name: 'iPhone 15 Pro Max', category: 'electronics', subcategory: 'Smartphones & Tablets', price: 1199.99, oldPrice: 1299.99, rating: 4.8, description: 'Latest iPhone with A17 Pro chip', image: 'assets/products/product_smartphone_pro_1764031825153.png'),
    Product(id: 'el002', name: 'MacBook Air M3', category: 'electronics', subcategory: 'Laptops & Computers', price: 1099.99, rating: 4.9, description: 'Ultra-thin laptop with M3 chip', image: 'assets/products/product_laptop_silver_1764031839984.png'),
    Product(id: 'el003', name: 'Sony WH-1000XM5', category: 'electronics', subcategory: 'Audio & Headphones', price: 349.99, oldPrice: 399.99, rating: 4.7, description: 'Premium noise-canceling headphones', image: 'assets/products/product_01.png'),
    Product(id: 'el004', name: 'Canon EOS R6 Mark II', category: 'electronics', subcategory: 'Cameras & Photography', price: 2499.99, rating: 4.9, description: 'Professional mirrorless camera', image: 'assets/products/product_02.png'),
    Product(id: 'el005', name: 'Amazon Echo Dot', category: 'electronics', subcategory: 'Smart Home Devices', price: 49.99, oldPrice: 59.99, rating: 4.5, description: 'Compact smart speaker', image: 'assets/products/product_03.png'),
    Product(id: 'el006', name: 'PlayStation 5', category: 'electronics', subcategory: 'Gaming Consoles', price: 499.99, rating: 4.8, description: 'Next-gen gaming console', image: 'assets/products/product_04.png'),
    Product(id: 'el007', name: 'Apple Watch Series 9', category: 'electronics', subcategory: 'Wearables & Smartwatches', price: 399.99, rating: 4.7, description: 'Advanced health tracker', image: 'assets/products/product_05.png'),
    Product(id: 'el008', name: 'Anker PowerBank 20000mAh', category: 'electronics', subcategory: 'Accessories', price: 45.99, oldPrice: 59.99, rating: 4.6, description: 'High-capacity portable charger', image: 'assets/products/product_06.png'),
    
    // FASHION (8 products) - Using images 7-14
    Product(id: 'fa001', name: 'Levi''s 501 Original Jeans', category: 'fashion', subcategory: 'Men''s Clothing', price: 89.99, oldPrice: 109.99, rating: 4.6, description: 'Classic straight-fit jeans', image: 'assets/products/product_07.png'),
    Product(id: 'fa002', name: 'Zara Floral Summer Dress', category: 'fashion', subcategory: 'Women''s Clothing', price: 49.99, rating: 4.4, description: 'Elegant floral dress', image: 'assets/products/product_08.png'),
    Product(id: 'fa003', name: 'Gap Kids Cotton T-Shirt Pack', category: 'fashion', subcategory: 'Kids'' Clothing', price: 24.99, oldPrice: 34.99, rating: 4.5, description: 'Soft cotton t-shirts - pack of 3', image: 'assets/products/product_09.png'),
    Product(id: 'fa004', name: 'Nike Air Max 270', category: 'fashion', subcategory: 'Shoes & Sneakers', price: 149.99, rating: 4.7, description: 'Iconic sneakers', image: 'assets/products/product_10.png'),
    Product(id: 'fa005', name: 'Herschel Classic Backpack', category: 'fashion', subcategory: 'Bags & Backpacks', price: 69.99, oldPrice: 89.99, rating: 4.6, description: 'Durable backpack', image: 'assets/products/product_11.png'),
    Product(id: 'fa006', name: 'Casio G-Shock Watch', category: 'fashion', subcategory: 'Watches & Jewelry', price: 129.99, rating: 4.8, description: 'Shock-resistant watch', image: 'assets/products/product_12.png'),
    Product(id: 'fa007', name: 'Ray-Ban Aviator Sunglasses', category: 'fashion', subcategory: 'Sunglasses', price: 159.99, rating: 4.7, description: 'Classic aviator sunglasses', image: 'assets/products/product_13.png'),
    Product(id: 'fa008', name: 'North Face Puffer Jacket', category: 'fashion', subcategory: 'Winter Wear', price: 249.99, oldPrice: 299.99, rating: 4.8, description: 'Warm winter jacket', image: 'assets/products/product_14.png'),
    
    // HOME & KITCHEN (8 products) - Using images 15-22
    Product(id: 'ho001', name: 'IKEA Kallax Shelf Unit', category: 'home', subcategory: 'Furniture', price: 79.99, rating: 4.5, description: '4x4 versatile shelving unit', image: 'assets/products/product_15.png'),
    Product(id: 'ho002', name: 'Boho Wall Tapestry', category: 'home', subcategory: 'Home Decor', price: 29.99, oldPrice: 39.99, rating: 4.4, description: 'Beautiful wall hanging', image: 'assets/products/product_16.png'),
    Product(id: 'ho003', name: 'Ninja Air Fryer', category: 'home', subcategory: 'Kitchen Appliances', price: 119.99, rating: 4.7, description: '6-quart air fryer', image: 'assets/products/product_17.png'),
    Product(id: 'ho004', name: 'Cuisinart Chef''s Knife Set', category: 'home', subcategory: 'Cookware & Utensils', price: 89.99, oldPrice: 129.99, rating: 4.6, description: 'Professional knife set', image: 'assets/products/product_18.png'),
    Product(id: 'ho005', name: 'Egyptian Cotton Bed Sheets', category: 'home', subcategory: 'Bedding & Bath', price: 79.99, rating: 4.8, description: 'Luxurious sheet set', image: 'assets/products/product_19.png'),
    Product(id: 'ho006', name: 'Stackable Storage Bins Set', category: 'home', subcategory: 'Storage & Organization', price: 34.99, oldPrice: 49.99, rating: 4.5, description: 'Set of 6 storage containers', image: 'assets/products/product_20.png'),
    Product(id: 'ho007', name: 'Philips Smart LED Bulb', category: 'home', subcategory: 'Lighting', price: 19.99, rating: 4.6, description: 'WiFi-enabled LED bulb', image: 'assets/products/product_21.png'),
    Product(id: 'ho008', name: 'Garden Tool Set', category: 'home', subcategory: 'Garden & Outdoor', price: 49.99, rating: 4.5, description: '10-piece gardening kit', image: 'assets/products/product_22.png'),
    
    // SPORTS (8 products) - Using images 23-30
    Product(id: 'sp001', name: 'Adjustable Dumbbell Set', category: 'sports', subcategory: 'Fitness Equipment', price: 299.99, oldPrice: 349.99, rating: 4.7, description: '5-52 lbs adjustable dumbbells', image: 'assets/products/product_23.png'),
    Product(id: 'sp002', name: 'Under Armour Running Shorts', category: 'sports', subcategory: 'Sports Clothing', price: 34.99, rating: 4.5, description: 'Moisture-wicking shorts', image: 'assets/products/product_24.png'),
    Product(id: 'sp003', name: 'Trek Mountain Bike', category: 'sports', subcategory: 'Cycling', price: 899.99, rating: 4.8, description: '29-inch mountain bike', image: 'assets/products/product_25.png'),
    Product(id: 'sp004', name: 'Coleman Camp Tent', category: 'sports', subcategory: 'Camping & Hiking', price: 149.99, oldPrice: 199.99, rating: 4.6, description: '4-person camping tent', image: 'assets/products/product_26.png'),
    Product(id: 'sp005', name: 'Inflatable Kayak', category: 'sports', subcategory: 'Water Sports', price: 279.99, rating: 4.5, description: '2-person kayak', image: 'assets/products/product_27.png'),
    Product(id: 'sp006', name: 'Adidas Soccer Ball', category: 'sports', subcategory: 'Team Sports', price: 29.99, rating: 4.7, description: 'Official size 5 ball', image: 'assets/products/product_28.png'),
    Product(id: 'sp007', name: 'Premium Yoga Mat', category: 'sports', subcategory: 'Yoga & Pilates', price: 39.99, oldPrice: 54.99, rating: 4.6, description: 'Non-slip yoga mat', image: 'assets/products/product_29.png'),
    Product(id: 'sp008', name: 'Optimum Nutrition Whey Protein', category: 'sports', subcategory: 'Sports Nutrition', price: 59.99, rating: 4.8, description: '5 lbs protein powder', image: 'assets/products/product_30.png'),
    
    // BEAUTY (8 products) - Using images 31-38
    Product(id: 'be001', name: 'CeraVe Moisturizing Cream', category: 'beauty', subcategory: 'Skincare', price: 19.99, oldPrice: 24.99, rating: 4.7, description: 'Hydrating face cream', image: 'assets/products/product_31.png'),
    Product(id: 'be002', name: 'Maybelline Mascara', category: 'beauty', subcategory: 'Makeup & Cosmetics', price: 12.99, rating: 4.5, description: 'Volumizing mascara', image: 'assets/products/product_32.png'),
    Product(id: 'be003', name: 'Olaplex Hair Treatment', category: 'beauty', subcategory: 'Hair Care', price: 28.99, rating: 4.8, description: 'Hair repair treatment', image: 'assets/products/product_33.png'),
    Product(id: 'be004', name: 'Dior Sauvage Cologne', category: 'beauty', subcategory: 'Fragrances', price: 119.99, oldPrice: 139.99, rating: 4.9, description: 'Premium cologne', image: 'assets/products/product_34.png'),
    Product(id: 'be005', name: 'Electric Toothbrush', category: 'beauty', subcategory: 'Personal Care', price: 79.99, rating: 4.6, description: 'Sonic toothbrush', image: 'assets/products/product_35.png'),
    Product(id: 'be006', name: 'Multivitamin Supplements', category: 'beauty', subcategory: 'Health Supplements', price: 24.99, rating: 4.5, description: 'Daily multivitamin', image: 'assets/products/product_36.png'),
    Product(id: 'be007', name: 'Blood Pressure Monitor', category: 'beauty', subcategory: 'Medical Devices', price: 39.99, oldPrice: 49.99, rating: 4.6, description: 'Automatic BP monitor', image: 'assets/products/product_37.png'),
    Product(id: 'be008', name: 'Philips Hair Trimmer', category: 'beauty', subcategory: 'Grooming Tools', price: 49.99, rating: 4.7, description: 'Professional trimmer', image: 'assets/products/product_38.png'),
    
    // BOOKS (8 products) - Using images 39-41 then reuse
    Product(id: 'bo001', name: 'The Great Gatsby', category: 'books', subcategory: 'Fiction Books', price: 14.99, rating: 4.8, description: 'Classic American novel', image: 'assets/products/product_39.png'),
    Product(id: 'bo002', name: 'Atomic Habits', category: 'books', subcategory: 'Non-Fiction Books', price: 16.99, oldPrice: 19.99, rating: 4.9, description: 'Self-improvement guide', image: 'assets/products/product_40.png'),
    Product(id: 'bo003', name: 'Python Programming Textbook', category: 'books', subcategory: 'Educational Books', price: 54.99, rating: 4.6, description: 'Programming guide', image: 'assets/products/product_41.png'),
    Product(id: 'bo004', name: 'One Piece Manga Vol. 1', category: 'books', subcategory: 'Comics & Manga', price: 9.99, rating: 4.9, description: 'Popular manga series', image: 'assets/products/product_01.png'),
    Product(id: 'bo005', name: 'Taylor Swift Midnights Vinyl', category: 'books', subcategory: 'Music & Vinyl', price: 34.99, rating: 4.8, description: 'Limited edition vinyl', image: 'assets/products/product_02.png'),
    Product(id: 'bo006', name: 'Inception 4K Blu-ray', category: 'books', subcategory: 'Movies & TV Shows', price: 24.99, oldPrice: 29.99, rating: 4.9, description: 'Christopher Nolan film', image: 'assets/products/product_03.png'),
    Product(id: 'bo007', name: 'Zelda Tears of the Kingdom', category: 'books', subcategory: 'Video Games', price: 59.99, rating: 4.9, description: 'Nintendo Switch game', image: 'assets/products/product_04.png'),
    Product(id: 'bo008', name: 'Moleskine Notebook Set', category: 'books', subcategory: 'Stationery', price: 29.99, rating: 4.7, description: 'Premium notebooks', image: 'assets/products/product_05.png'),
    
    // TOYS (8 products) - Reuse images
    Product(id: 'to001', name: 'LEGO Education Set', category: 'toys', subcategory: 'Educational Toys', price: 79.99, oldPrice: 99.99, rating: 4.8, description: 'STEM learning set', image: 'assets/products/product_06.png'),
    Product(id: 'to002', name: 'Marvel Avengers Action Figure', category: 'toys', subcategory: 'Action Figures', price: 24.99, rating: 4.6, description: 'Superhero action figure', image: 'assets/products/product_07.png'),
    Product(id: 'to003', name: 'Barbie Dreamhouse', category: 'toys', subcategory: 'Dolls & Playsets', price: 199.99, rating: 4.7, description: '3-story dollhouse', image: 'assets/products/product_08.png'),
    Product(id: 'to004', name: 'LEGO Classic Creative Bricks', category: 'toys', subcategory: 'Building Blocks', price: 49.99, oldPrice: 59.99, rating: 4.8, description: '1000-piece set', image: 'assets/products/product_09.png'),
    Product(id: 'to005', name: 'Monopoly Board Game', category: 'toys', subcategory: 'Board Games', price: 29.99, rating: 4.7, description: 'Classic board game', image: 'assets/products/product_10.png'),
    Product(id: 'to006', name: 'Pampers Diapers Economy Pack', category: 'toys', subcategory: 'Baby Products', price: 44.99, rating: 4.6, description: 'Size 3 diapers', image: 'assets/products/product_11.png'),
    Product(id: 'to007', name: 'Kids Tablet Fire HD 8', category: 'toys', subcategory: 'Kids Electronics', price: 99.99, oldPrice: 139.99, rating: 4.5, description: '8-inch kids tablet', image: 'assets/products/product_12.png'),
    Product(id: 'to008', name: 'Trampoline with Safety Net', category: 'toys', subcategory: 'Outdoor Play', price: 299.99, rating: 4.7, description: '12-foot trampoline', image: 'assets/products/product_13.png'),
    
    // AUTOMOTIVE (8 products) - Reuse images
    Product(id: 'au001', name: 'Phone Mount for Car', category: 'automotive', subcategory: 'Car Accessories', price: 19.99, oldPrice: 29.99, rating: 4.5, description: 'Magnetic phone holder', image: 'assets/products/product_14.png'),
    Product(id: 'au002', name: 'Garmin Dash Cam', category: 'automotive', subcategory: 'Car Electronics', price: 199.99, rating: 4.7, description: '1080p dash camera', image: 'assets/products/product_15.png'),
    Product(id: 'au003', name: 'Meguiar''s Car Wash Kit', category: 'automotive', subcategory: 'Car Care & Cleaning', price: 39.99, rating: 4.6, description: 'Car cleaning set', image: 'assets/products/product_16.png'),
    Product(id: 'au004', name: 'Michelin All-Season Tires', category: 'automotive', subcategory: 'Tires & Wheels', price: 149.99, oldPrice: 179.99, rating: 4.8, description: 'High-performance tire', image: 'assets/products/product_17.png'),
    Product(id: 'au005', name: 'Engine Oil Filter', category: 'automotive', subcategory: 'Engine Parts', price: 12.99, rating: 4.6, description: 'OEM-quality filter', image: 'assets/products/product_18.png'),
    Product(id: 'au006', name: 'Car Seat Covers Set', category: 'automotive', subcategory: 'Interior Accessories', price: 54.99, rating: 4.5, description: 'Leather seat covers', image: 'assets/products/product_19.png'),
    Product(id: 'au007', name: 'Chrome Side Mirror Covers', category: 'automotive', subcategory: 'Exterior Accessories', price: 29.99, oldPrice: 39.99, rating: 4.4, description: 'Mirror cover pair', image: 'assets/products/product_20.png'),
    Product(id: 'au008', name: 'Craftsman Tool Set', category: 'automotive', subcategory: 'Tools & Equipment', price: 129.99, rating: 4.7, description: '230-piece tool set', image: 'assets/products/product_21.png'),
  ];

  static List<Product> getProductsByCategory(String categoryId) {
    return allProducts.where((p) => p.category == categoryId).toList();
  }

  static List<Product> getProductsBySubcategory(String subcategory) {
    return allProducts.where((p) => p.subcategory == subcategory).toList();
  }

  static List<Product> getFeaturedProducts({int limit = 10}) {
    return allProducts.where((p) => p.oldPrice != null).take(limit).toList();
  }
}
