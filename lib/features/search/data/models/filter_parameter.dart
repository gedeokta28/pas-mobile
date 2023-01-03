class FilterParameter {
  String? keyword, categoryId, brandId;
  int? priceStart, priceEnd;
  String orderBy;

  FilterParameter({
    this.keyword,
    this.categoryId,
    this.brandId,
    this.priceStart,
    this.priceEnd,
    this.orderBy = 'desc',
  });
}
