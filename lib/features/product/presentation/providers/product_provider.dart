import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/data/models/detail_product_model.dart';
import 'package:pas_mobile/features/home/data/models/variant_product_response_model.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_detail.dart';
import 'package:pas_mobile/features/home/domain/usecases/get_product_variant.dart';
import 'package:pas_mobile/features/search/data/models/filter_parameter.dart';
import 'package:pas_mobile/features/search/data/models/filter_product_model.dart';
import 'package:pas_mobile/features/search/domain/usecases/do_filter_product.dart';

import '../../../../core/utility/enum.dart';
import '../../../search/presentation/providers/search_state.dart';
import 'product_detail_state.dart';

class ProductProvider extends ChangeNotifier {
  // initial

  late ProductDetail _productDetail;
  late VariantList _productVariantList;
  late ProductVariant _prodouctVariant;
  late List<ProductFilter> _productRelated = [];
  bool _isLoadingProduct = true;
  bool _isLoadingVariant = true;
  bool _isLoadingRelated = true;
  bool _expandVariant = false;
  final int _variantTotal = 1;
  late String _productPrice = '';
  late String _productName = '';
  late String _productDescription = '';
  late String _productWeight = '';
  late String _productId = '';
  bool _isProductVariantSelected = false;
  int? _variantSelected;

  bool get isLoadingProduct => _isLoadingProduct;
  bool get isLoadingRelated => _isLoadingRelated;
  bool get isLoadingVariant => _isLoadingVariant;
  bool get isProductVariantSelected => _isProductVariantSelected;
  bool get expandVariant => _expandVariant;
  int get variantTotal => _variantTotal;
  String get productPrice => _productPrice;
  String get productName => _productName;
  String get productDescription => _productDescription;
  String get productWeight => _productWeight;
  String get productId => _productId;
  int? get variantSelected => _variantSelected;
  ProductDetail get productDetail => _productDetail;
  ProductVariant get prodouctVariant => _prodouctVariant;
  VariantList get productVariantList => _productVariantList;
  List<ProductFilter> get productRelated => _productRelated;

  set setExpandVariant(val) {
    _expandVariant = val;
    notifyListeners();
  }

  set setVariantSelected(val) {
    _variantSelected = val;
    notifyListeners();
  }

  setProductSelected(
      {ProductDetail? productDetail, ProductVariant? productVariantSelected}) {
    if (productDetail != null) {
      _productPrice = productDetail.hrg1;
      _productName = productDetail.stockname;
      _productDescription = productDetail.stockdescription;
      _productWeight = productDetail.berat;
      _isProductVariantSelected = false;
      _productId = productDetail.stockid;
      _productDetail = productDetail;
    } else if (productVariantSelected != null) {
      _productPrice = productVariantSelected.hrg1;
      _productDescription = productVariantSelected.stockdescription;
      _productName = productVariantSelected.stockname;
      _productWeight = productVariantSelected.berat;
      _isProductVariantSelected = true;
      _productId = productVariantSelected.stockid;
      _prodouctVariant = productVariantSelected;
    }
    notifyListeners();
  }

  Stream<ProductDetailState> fetchProductDetail(String productId) async* {
    _isLoadingProduct = true;
    notifyListeners();
    yield ProductDetailLoading();
    final result = await getProductDetail(productId);
    yield* result.fold(
      (failure) async* {
        _isLoadingProduct = false;
        notifyListeners();
        yield ProductDetailFailure(failure: failure);
      },
      (data) async* {
        // _productDetail = data;
        _isLoadingProduct = false;
        setProductSelected(productDetail: data);
        notifyListeners();
        yield ProductDetailLoaded(data: data);
      },
    );
  }

  Stream<ProductDetailState> fetchProductVariant(String productId) async* {
    _isLoadingVariant = true;
    notifyListeners();
    yield ProductDetailLoading();
    final result = await getProductVariant(productId);
    yield* result.fold(
      (failure) async* {
        _isLoadingVariant = false;
        notifyListeners();
        yield ProductDetailFailure(failure: failure);
      },
      (data) async* {
        _productVariantList = data;
        _isLoadingVariant = false;
        notifyListeners();
        yield ProductVariantLoaded(data: data);
      },
    );
  }

  Stream<SearchState> fetchRelatedProduct(
      String categoryId, String productId) async* {
    _isLoadingRelated = true;
    notifyListeners();
    FilterParameter filterParameter = FilterParameter(categoryId: categoryId);
    yield SearchLoading();
    final result =
        await doFilterProduct(TypeFilter.customFilter, filterParameter);
    yield* result.fold(
      (failure) async* {
        _isLoadingRelated = false;
        notifyListeners();
        yield SearchFailure(failure: failure);
      },
      (data) async* {
        _productRelated = data;
        await checkList(productId);
        _isLoadingRelated = false;
        notifyListeners();
        yield FilterLoaded(data: data);
      },
    );
  }

  checkList(String productId) {
    _productRelated.removeWhere((item) => item.stockid == productId);
  }

  // constructor
  final GetProductDetail getProductDetail;
  final DoFilterProduct doFilterProduct;
  final GetProductVariant getProductVariant;

  ProductProvider(
      {required this.getProductDetail,
      required this.doFilterProduct,
      required this.getProductVariant});
}
