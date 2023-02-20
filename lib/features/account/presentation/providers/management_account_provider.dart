import 'package:pas_mobile/core/data/models/regencies_model.dart';
import 'package:pas_mobile/core/domain/usecases/get_provinces_list.dart';
import 'package:pas_mobile/core/domain/usecases/get_regencies_list.dart';
import 'package:pas_mobile/core/presentation/region_state.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../../../../core/data/models/provinces_model.dart';
import '../../../../core/presentation/form_provider.dart';

class ManagementAccountProvider extends FormProvider {
  // initial
  final GetProvincesList getProvincesList;
  final GetRegenciesList getRegenciesList;
  late List<Province> _provinceList = [];
  late List<RegenciesModel> _regenciesList = [];
  Province? _selectedProvince;
  RegenciesModel? _selectedRegencies;

  //get
  List<Province> get provinceList => _provinceList;
  List<RegenciesModel> get regenciesList => _regenciesList;
  Province? get selectedProvince => _selectedProvince;
  RegenciesModel? get selectedRegencies => _selectedRegencies;

  //setter
  set setSelectedProvince(val) {
    _selectedProvince = val;
    notifyListeners();
  }

  set setSelectedRegencies(val) {
    _selectedRegencies = val;
    notifyListeners();
  }

  // constructor
  ManagementAccountProvider({
    required this.getProvincesList,
    required this.getRegenciesList,
  });

  Stream<RegionState> fetchProvinceList() async* {
    yield RegionLoading();

    final result = await getProvincesList();
    yield* result.fold(
      (failure) async* {
        logMe("Error");
        yield RegionFailure(failure: failure);
      },
      (data) async* {
        logMe("Provinceee");
        _provinceList = data;
        notifyListeners();
        yield RegionProvinceLoaded(data: data);
      },
    );
  }

  Stream<RegionState> fetchRegenciesList() async* {
    _regenciesList = [];
    _selectedRegencies = null;
    notifyListeners();
    yield RegionLoading();

    final result = await getRegenciesList(_selectedProvince!.id);
    yield* result.fold(
      (failure) async* {
        logMe("Error");
        yield RegionFailure(failure: failure);
      },
      (data) async* {
        logMe("Regencies");
        _regenciesList = data;
        notifyListeners();
        yield RegionRegenciesLoaded(data: data);
      },
    );
  }
}
