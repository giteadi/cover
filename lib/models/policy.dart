class InsurancePolicy {
  final String id;
  final String name;
  final String provider;
  final String category;
  final double sumAssured;
  final double premium;
  final String premiumType;
  final List<String> benefits;
  final List<String> features;
  final double? claimSettlementRatio;
  final int? waitingPeriod;
  final int? policyTerm;
  final String? imageUrl;
  final double? rating;
  final int? reviews;

  InsurancePolicy({
    required this.id,
    required this.name,
    required this.provider,
    required this.category,
    required this.sumAssured,
    required this.premium,
    required this.premiumType,
    required this.benefits,
    required this.features,
    this.claimSettlementRatio,
    this.waitingPeriod,
    this.policyTerm,
    this.imageUrl,
    this.rating,
    this.reviews,
  });
}

class Provider {
  final String id;
  final String name;
  final String logoUrl;
  final double claimSettlementRatio;
  final int networkHospitals;
  final double rating;

  Provider({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.claimSettlementRatio,
    required this.networkHospitals,
    required this.rating,
  });
}

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? panNumber;
  final String? aadhaarNumber;
  final List<String> purchasedPolicies;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.panNumber,
    this.aadhaarNumber,
    this.purchasedPolicies = const [],
  });
}
