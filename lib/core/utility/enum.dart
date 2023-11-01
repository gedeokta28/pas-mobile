enum TypeField {
  none,
  count,
  email,
  phone,
  password,
  confirmationPassword,
  username,
  receiverName,
  deliveryName,
  shippingAddress,
  shippingAddressDetail,
}

enum AccountType { personal, company }

enum TypeFilter { onlyKeyword, onlyCategory, onlyBrand, customFilter }

enum ProductPageParams { fromCategory, fromBrand, fromHome }

enum PaymentMethod {
  cash,
  trasnfer,
}

enum StatusOrder {
  paymentPending,
  processing,
  onDelivery,
  cancelled,
  completed
}
