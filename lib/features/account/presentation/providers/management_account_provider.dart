import 'package:dio/dio.dart';
import 'package:pas_mobile/core/data/models/regencies_model.dart';
import 'package:pas_mobile/core/domain/usecases/get_provinces_list.dart';
import 'package:pas_mobile/core/domain/usecases/get_regencies_list.dart';
import 'package:pas_mobile/core/presentation/region_state.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/account/domain/usecases/do_update_profile.dart';
import 'package:pas_mobile/features/account/domain/usecases/get_profile.dart';
import 'package:pas_mobile/features/account/presentation/providers/update_profile_state.dart';

import '../../../../core/data/models/provinces_model.dart';
import '../../../../core/presentation/form_provider.dart';
import '../../data/models/profile_model.dart';
import 'profile_state.dart';

class ManagementAccountProvider extends FormProvider {
  // initial
  final GetProfile getProfile;
  final DoUpdateProfile doUpdateProfile;
  final GetProvincesList getProvincesList;
  final GetRegenciesList getRegenciesList;
  late List<Province> _provinceList = [];
  late List<RegenciesModel> _regenciesList = [];
  Province? _selectedProvince;
  RegenciesModel? _selectedRegencies;
  Profile? _profile;

  //get
  Profile? get profile => _profile;
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

  set profile(Profile? data) {
    _profile = data;
    notifyListeners();
  }

  // constructor
  ManagementAccountProvider({
    required this.getProfile,
    required this.getProvincesList,
    required this.getRegenciesList,
    required this.doUpdateProfile,
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
        _selectedProvince = _provinceList[0];

        logMe("000000 ");
        logMe(_profile!.province);
        notifyListeners();
        yield RegionProvinceLoaded(data: data);
      },
    );
  }

  Stream<RegionState> fetchProvinceListUpdate(String provinceUpdate) async* {
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
        int index =
            _provinceList.indexWhere((item) => item.name == provinceUpdate);
        _selectedProvince = _provinceList[index];
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

  Stream<ProfileState> fetchProfile() async* {
    yield ProfileLoading();
    final profileResult = await getProfile();
    yield* profileResult.fold((failure) async* {
      yield ProfileFailure(failure: failure);
    }, (data) async* {
      yield ProfileLoaded(data: data);
    });
  }

  setProfileData(Profile profileData) async {
    usernameController.text = profileData.username;
    firstNameController.text = profileData.firstname ?? '';
    lastNameController.text = profileData.lastname ?? '';
    emailController.text = profileData.email;
    phoneNumberController.text = profileData.phone ?? '';
    companyNameController.text = profileData.companyname ?? '';
    streetNameController.text = profileData.address ?? '';
    postCodeController.text = profileData.postcode ?? '';
    regenciesController.text = profileData.city ?? '';
    notifyListeners();
  }

  Stream<UpdateProfileState> updateProfile(
      Map<String, String> formData) async* {
    showLoading();
    yield UpdateProfileLoading();

    final updateResult = await doUpdateProfile.execute(formData);
    yield* updateResult.fold((failure) async* {
      dismissLoading();

      logMe("failure.message ${failure.message}");
      yield UpdateProfileFailure(failure: failure);
    }, (result) async* {
      dismissLoading();
      yield UpdateProfileSuccess(data: result);
    });
  }
}
