class RequestPathHolder {
  RequestPathHolder(
      {this.loginUserId,
      this.ownerUserId,
      this.parentImgId,
      this.imageType,
      this.itemId,
      this.cityId,
      this.coreKeyId,
      this.vendorId,
      this.shopId,
      this.categoryId,
      this.transactionHeaderId,
      this.productId,
      this.commentHeaderId,
      this.shippingId,
      this.scheduleHeaderId,
      this.collectionId,
      this.languageCode,
      this.orderId,
      this.headerToken,
      this.isCheckoutPage});

  final String? loginUserId;
  final String? ownerUserId;
  final String? itemId;
  final String? parentImgId;
  final String? imageType;
  final String? cityId;
  final String? coreKeyId;
  final String? vendorId;
  final String? shopId;
  final String? categoryId;
  final String? transactionHeaderId;
  final String? productId;
  final String? commentHeaderId;
  final String? shippingId;
  final String? scheduleHeaderId;
  final String? collectionId;
  final String? languageCode;
  //Header Token
  final String? headerToken;
  final String? orderId;
  final String? isCheckoutPage;
}
