class FilterParameter {
  String? keyword, categoryId, brandId;
  int? priceStart, priceEnd;
  String orderBy;

  FilterParameter({
    this.keyword = '',
    this.categoryId = '',
    this.brandId = '',
    this.priceStart = 0,
    this.priceEnd = 0,
    this.orderBy = 'desc',
  });
}
