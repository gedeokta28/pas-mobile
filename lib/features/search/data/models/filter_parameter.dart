class FilterParameter {
  String? keyword, categoryId, brandId;
  int? priceStart, priceEnd, limit;
  String orderBy, priceBy;

  FilterParameter({
    this.keyword = '',
    this.categoryId = '',
    this.brandId = '',
    this.priceStart = 0,
    this.limit = 10,
    this.priceEnd = 0,
    this.orderBy = 'asc',
    this.priceBy = '',
  });
}
