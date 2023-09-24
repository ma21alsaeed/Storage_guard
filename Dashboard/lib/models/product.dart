class Product {
  final int? id;
  final String name;
  final String description;
  final String productionDate;
  final String expiryDate;
  final double maxTemperature;
  final double minTemperature;
  final double maxHumidity;
  final double minHumidity;
  final int? safetyStatus;

  Product({
     this.id,
    required this.name,
    required this.description,
    required this.productionDate,
    required this.expiryDate,
    required this.maxTemperature,
    required this.minTemperature,
    required this.maxHumidity,
    required this.minHumidity,
     this.safetyStatus,
  });

  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      productionDate: json['production_date'],
      expiryDate: json['expiry_date'],
      maxTemperature: json['max_temp'],
      minTemperature: json['min_temp'],
      maxHumidity: json['max_humidity'],
      minHumidity: json['min_humidity'],
      safetyStatus:json['safety_status'],
    );
  }

  Map<String, dynamic> toJson()  => {

      'name': name,
      'description': description,
      'production_date': productionDate,
      'expiry_date': expiryDate,
      'max_temp': maxTemperature,
      'min_temp': minTemperature,
      'max_humidity': maxHumidity,
      'min_humidity': minHumidity,

    };
  }
