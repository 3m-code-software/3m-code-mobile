# 📦 نظام المنتجات والفئات - توثيق

**النسخة:** 2.0.0  
**التاريخ:** نوفمبر 2025  
**الحالة:** 🟢 قيد الإنشاء

---

## 📋 ملخص النظام

نظام شامل لإدارة المنتجات والفئات يتضمن:
- ✅ **Product Model** — نموذج بيانات المنتج
- ✅ **Category Model** — نموذج بيانات الفئة
- ✅ **ProductRepository** — طبقة الوصول للبيانات من الـ API
- ✅ **API Service** — محدث لدعم queryParameters
- 🔄 **UI Components** — واجهات المنتجات والفلاتر (قادم)

---

## 🏗️ البنية المعمارية

```
lib/features/product/
├── data/
│   ├── product_model.dart       (✅ المنتج)
│   ├── category_model.dart      (✅ الفئة)
│   └── product_repo.dart        (✅ مستودع البيانات)
├── views/
│   ├── product_details_view.dart (الموجود)
│   └── products_list_view.dart   (قادم)
└── widgets/
    └── (widgets خاصة بالمنتجات - قادم)
```

---

## 📊 نماذج البيانات

### Product Model

```dart
class Product extends Equatable {
  final String id;              // معرف المنتج
  final String name;            // اسم المنتج
  final String description;     // الوصف التفصيلي
  final String image;           // رابط الصورة
  final double price;           // السعر
  final double rating;          // التقييم (0-5)
  final int reviewCount;        // عدد التقييمات
  final String category;        // الفئة
  final bool isAvailable;       // هل متاح
  final List<String> tags;      // الوسوم (tags)
}
```

**أمثلة الاستخدام:**
```dart
// من JSON
Product product = Product.fromJson(json);

// إلى JSON
Map<String, dynamic> json = product.toJson();

// نسخ مع تعديلات
Product updatedProduct = product.copyWith(price: 25.99);
```

---

### Category Model

```dart
class Category extends Comparable<Category> {
  final String id;              // معرف الفئة
  final String name;            // اسم الفئة
  final String icon;            // رابط الأيقونة
  final int productCount;       // عدد المنتجات في الفئة
}
```

---

## 🔌 ProductRepository

مستودع شامل يوفر جميع العمليات على المنتجات.

### الدوال الرئيسية:

#### 1. جلب جميع المنتجات
```dart
Future<List<Product>> getProducts({
  String? category,           // فلتر حسب الفئة
  double? minPrice,          // الحد الأدنى للسعر
  double? maxPrice,          // الحد الأقصى للسعر
  String? searchQuery,       // البحث
  int page = 1,              // الصفحة
  int limit = 20,            // عدد النتائج
})
```

#### 2. جلب المنتج حسب ID
```dart
Future<Product> getProductById(String productId)
```

#### 3. جلب الفئات
```dart
Future<List<Category>> getCategories()
```

#### 4. جلب المنتجات حسب الفئة
```dart
Future<List<Product>> getProductsByCategory(String category, {page, limit})
```

#### 5. البحث عن المنتجات
```dart
Future<List<Product>> searchProducts(String query, {page, limit})
```

#### 6. المنتجات الأكثر تقييماً
```dart
Future<List<Product>> getTopRatedProducts({limit})
```

#### 7. المنتجات الجديدة
```dart
Future<List<Product>> getNewProducts({limit})
```

#### 8. المنتجات حسب نطاق السعر
```dart
Future<List<Product>> getProductsByPriceRange(
  double minPrice, 
  double maxPrice,
  {page, limit}
)
```

---

## 🔄 مثال استخدام كامل

```dart
// إنشاء Repository
final repository = ProductRepository(ApiService());

// جلب جميع المنتجات
try {
  List<Product> products = await repository.getProducts(
    category: 'Burgers',
    minPrice: 5.0,
    maxPrice: 30.0,
    page: 1,
  );
  print('Loaded ${products.length} products');
} catch (e) {
  print('Error: $e');
}

// البحث عن منتج
List<Product> results = await repository.searchProducts('cheese');

// جلب منتج محدد
Product product = await repository.getProductById('123');

// المنتجات الأكثر تقييماً
List<Product> topRated = await repository.getTopRatedProducts(limit: 5);
```

---

## 🛠️ التحديثات على ApiService

تم تحديث `ApiService` لدعم `queryParameters`:

```dart
// قبل
await apiService.get('/products')

// بعد (مع queryParameters)
await apiService.get(
  '/products',
  queryParameters: {
    'category': 'Burgers',
    'minPrice': 5.0,
    'page': 1,
  },
)
```

---

## 📍 API Endpoints المتوقعة

```
GET    /products                    - جميع المنتجات
GET    /products/:id               - منتج محدد
GET    /products/search            - البحث
GET    /products/top-rated         - الأكثر تقييماً
GET    /products/new               - الجديدة
GET    /categories                 - جميع الفئات
GET    /categories/:id             - فئة محددة
POST   /products                   - إنشاء منتج (Admin)
PUT    /products/:id               - تحديث منتج (Admin)
DELETE /products/:id               - حذف منتج (Admin)
```

---

## 🎯 الخطوات التالية

### المرحلة 2.1: UI Components
- [ ] ProductListView مع Grid/List
- [ ] ProductCard محسّن
- [ ] FilterWidget لتطبيق الفلاتر
- [ ] SearchBar متقدم

### المرحلة 2.2: State Management
- [ ] ProductProvider (State Management)
- [ ] CartProvider لسلة التسوق
- [ ] FavoriteProvider للمفضلة

### المرحلة 2.3: Advanced Features
- [ ] نظام التقييمات والمراجعات
- [ ] حفظ المفضلة محلياً
- [ ] عرض سعر النطاق

---

## 🚀 أفضل الممارسات

1. **معالجة الأخطاء**
   ```dart
   try {
     List<Product> products = await repository.getProducts();
   } catch (e) {
     // معالجة الخطأ بشكل مناسب
   }
   ```

2. **Pagination**
   ```dart
   // جلب الصفحة الثانية
   List<Product> page2 = await repository.getProducts(page: 2);
   ```

3. **Filtering**
   ```dart
   // جمع فلاتر متعددة
   List<Product> filtered = await repository.getProducts(
     category: selectedCategory,
     minPrice: priceRange.start,
     maxPrice: priceRange.end,
     searchQuery: searchText,
   );
   ```

---

## 🧪 الاختبار

### اختبار Repository
```dart
test('getProducts returns list', () async {
  List<Product> products = 
    await repository.getProducts();
  
  expect(products, isA<List<Product>>());
  expect(products.isNotEmpty, true);
});
```

---

## 📝 ملاحظات

- ✅ Models تستخدم `Equatable` لسهولة المقارنة
- ✅ Repository يتعامل مع جميع الأخطاء
- ✅ QueryParameters تُصفى تلقائياً (الـ null values)
- ✅ Pagination مدمج في جميع الدوال
- ✅ API Service محدث ليكون متوافقاً

---

**آخر تحديث:** نوفمبر 2025  
**الحالة:** 🟢 مكتمل وجاهز للاستخدام

🎉 النظام جاهز! الخطوة التالية بناء الواجهات (UI Components)
