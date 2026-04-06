import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductDetailController extends GetxController {

  // ── Images ───────────────────────────────────────────────────────────────────
  final images = <String>[
    'https://images.unsplash.com/photo-1603252109303-2751441dd157?w=800',
    'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=800',
    'https://images.unsplash.com/photo-1503602642458-232111445657?w=800',
    'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?w=800',
  ].obs;

  // ── Sizes ────────────────────────────────────────────────────────────────────
  final sizes = <String>['XS', 'S', 'M', 'L', 'XL', '2XL', '3XL'];

  // ── Reactive state ───────────────────────────────────────────────────────────
  final selectedImageIndex = 0.obs;
  final selectedSizeIndex   = 0.obs;
  final count               = 1.obs;
  final isWishlisted        = false.obs;

  // ── Specifications tab index (0=Specifications,1=Showcase,2=Description,3=Details) ──
  final specTabIndex = 0.obs;

  // ── Specifications data ───────────────────────────────────────────────────────
  final specifications = <Map<String, String>>[
    {'label': 'Brand',         'value': 'Rare Rabbit'},
    {'label': 'Style Code',    'value': 'D121421'},
    {'label': 'Color',         'value': 'Dark Blue'},
    {'label': 'Sleeve',        'value': 'Full/Long Sleeve'},
    {'label': 'Fabric',        'value': 'Pure Cotton'},
    {'label': 'Spread',        'value': 'Soft Wear'},
    {'label': 'Suitable for',  'value': 'Men'},
    {'label': 'Spread',        'value': 'Soft Think'},
    {'label': 'Net Quantity',  'value': '1 (Per lower type)'},
    {'label': 'Fabric Care',   'value': 'Machine wash as per tag'},
  ];

  // ── Key Features ─────────────────────────────────────────────────────────────
  final keyFeatures = <String>[
    'Premium Fabric C of all form high quality Ope cotton for a lightweight and Breathable feel',
    'Slim Fit: Tailored cut that enhances your figure for a polished, modern look.',
    'Stylish Mandarin Collar: Adds a contemporary touch, making it a fashion-appeal option.',
    'Perfect for Parties: Dapper\'s self-design makes it ideal for evening events, parties and semi-formal occasions.',
  ];

  // ── Description ───────────────────────────────────────────────────────────────
  final description =
      'Make a lasting impression with the sophisticated Lionies Gija Cotton Slim Fit Party Shirt. '
      'Designed for style and comfort, this off-pink shirt with a subtle self-design adds a touch of elegance to your wardrobe.';

  // ── Actions ──────────────────────────────────────────────────────────────────

  final List<Map<String, dynamic>> reviews = [
    {'name': 'Wade Warren',  'rating': 4.5, 'time': '6 days ago',   'comment': 'The item is very good, my son likes it very much and plays every day.'},
    {'name': 'Guy Hawkins',  'rating': 4.5, 'time': '1 week ago',   'comment': 'The seller is very fast in sending packet. I just bought it and already arrived in just 1 day.'},
    {'name': 'Robert Fox',   'rating': 4.5, 'time': '2 weeks ago',  'comment': 'I just bought it and the stuff is really good! I highly recommend it.'},
  ];

  final List<Map<String, dynamic>> ratingBreakdown = [
    {'stars': 5, 'count': 703, 'label': 'Very Good(703)'},
    {'stars': 4, 'count': 634, 'label': 'Good(634)'},
    {'stars': 3, 'count': 40,  'label': 'Ok (40)'},
    {'stars': 2, 'count': 10,  'label': 'Bad(10)'},
    {'stars': 1, 'count': 5,   'label': 'Very Bad(5)'},
  ];

  final List<String> similarProducts = [
    'https://images.unsplash.com/photo-1620012253295-c15cc3e65df4?w=200',
    'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=200',
    'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=200',
  ];

  final List<Map<String, dynamic>> youMayAlsoLike = [
    {'img': 'https://images.unsplash.com/photo-1620012253295-c15cc3e65df4?w=200', 'brand': 'Polo', 'type': 'BROWN T-SHIRT', 'price': 'Rs.1,100', 'mrp': '1500', 'off': '10% OFF', 'wishlisted': false},
    {'img': 'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=200', 'brand': 'Polo', 'type': 'BROWN T-SHIRT', 'price': 'Rs.1,100', 'mrp': '1500', 'off': '30% OFF', 'wishlisted': false},
    {'img': 'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=200', 'brand': 'Polo', 'type': 'BROWN T-SHIRT', 'price': 'Rs.1,100', 'mrp': '1500', 'off': '10% OFF', 'wishlisted': true},
    {'img': 'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=200', 'brand': 'Polo', 'type': 'BROWN T-SHIRT', 'price': 'Rs.1,300', 'mrp': '1500', 'off': '10% OFF', 'wishlisted': false},
    {'img': 'https://images.unsplash.com/photo-1523381294911-8d3cead13475?w=200', 'brand': 'Polo', 'type': 'BROWN S-SHIRT', 'price': 'Rs.1,100', 'mrp': '1500', 'off': '20% OFF', 'wishlisted': false},
    {'img': 'https://images.unsplash.com/photo-1503341504253-dff4815485f1?w=200', 'brand': 'Polo', 'type': 'BROWN S-SHIRT', 'price': 'Rs.1,300', 'mrp': '1500', 'off': '10% OFF', 'wishlisted': false},
    {'img': 'https://images.unsplash.com/photo-1571945153237-4929e783af4a?w=200', 'brand': 'Polo', 'type': 'BROWN T-SHIRT', 'price': 'Rs.1,100', 'mrp': '1500', 'off': '90% OFF', 'wishlisted': false},
    {'img': 'https://images.unsplash.com/photo-1598033129183-c4f50c736f10?w=200', 'brand': 'Polo', 'type': 'BROWN S-SHIRT', 'price': 'Rs.1,300', 'mrp': '1500', 'off': '10% OFF', 'wishlisted': false},
  ];

  // ── Spec tab labels ───────────────────────────────────────────────────────────
  final List<String> specTabs = ['Specifications', 'Showcase', 'Description', 'De'];

  void changeImage(int index) => selectedImageIndex.value = index;
  void changeSize(int index)  => selectedSizeIndex.value  = index;

  void increaseQty() => count.value++;
  void decreaseQty() { if (count.value > 1) count.value--; }

  void toggleWishlist() => isWishlisted.toggle();
  void setSpecTab(int index) => specTabIndex.value = index;
}