import 'package:bioindica/src/auth/presentation/controllers/auth_controller.dart';
import 'package:bioindica/src/bio/presentation/controllers/filter_controller.dart';
import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:bioindica/src/bio/domain/entities/bio_data.dart';
import 'package:bioindica/src/bio/presentation/controllers/bio_controller.dart';

import 'package:bioindica/src/core/routes.dart';
import 'package:bioindica/src/core/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  late BioController _bioController;
  final TextEditingController _searchTxtController = TextEditingController();
  final TextEditingController _initialDateController =
      TextEditingController(text: Formatters.formatDatetime(DateTime(2024)));
  final TextEditingController _finalDateController =
      TextEditingController(text: Formatters.formatDatetime(DateTime.now()));
  late List<BioData> _animalsList;

  @override
  void initState() {
    _bioController = Get.find<BioController>();
    _animalsList = _bioController.animalsList;
    super.initState();
  }

  @override
  void dispose() {
    _searchTxtController.dispose();
    _initialDateController.dispose();
    _finalDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeSearchHeader(
              searchController: _searchTxtController,
              searchBioByName: () async {
                await _bioController.getBioListBySpecieName(
                    search: _searchTxtController.text);
              },
              openFilters: () => _showFiltersModelBottomSheet(context),
            ),
            Expanded(
              child: Obx(
                () => CustomRefreshIndicator(
                  onRefresh: () async {
                    _searchTxtController.clear();
                    _bioController.getBioList();
                    _resetFilters();
                  },
                  child: CustomScrollView(
                      physics: _bioController.isLoading
                          ? const NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        CustomListLoader(
                          isSliver: true,
                          state: _bioController.appState.value,
                          buildLoadedList: _buildLoadedList,
                          buildLoadingList: _buildLoadingList,
                          emptyState: const CustomNotificationState(
                            title: 'Nenhum animal encontrado',
                            subtitle: 'Tente novamente com outros filtros',
                          ),
                          isEmptyList: _animalsList.isEmpty,
                          failureState: const CustomNotificationState(
                            title: 'Erro ao carregar animais',
                            subtitle: 'Tente novamente mais tarde',
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedList() {
    return UISliverPadding(
      context: context,
      useVerticalPadding: true,
      useHorizontalPadding: true,
      child: SliverList.separated(
        separatorBuilder: (context, index) => SizedBox(height: 14.s),
        itemCount: _animalsList.length,
        itemBuilder: (context, index) {
          final BioData bioData = _animalsList[index];
          return CustomCardBio(
            bioData: bioData,
            onTap: () {
              _bioController.selectBioData(bioData);
              Get.toNamed(ScreensRoutes.about);
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingList() {
    return UISliverPadding(
      useVerticalPadding: true,
      useHorizontalPadding: true,
      context: context,
      child: SliverList.separated(
        separatorBuilder: (context, index) => SizedBox(height: 14.s),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: labelColor.withOpacity(0.55),
                  spreadRadius: 0,
                  blurStyle: BlurStyle.outer,
                  blurRadius: 10,
                )
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: Shimmer.fromColors(
              baseColor: baseShimmerColor,
              highlightColor: highlightShimmerColor,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: baseShimmerColor,
                    ),
                    width: 100.s,
                    height: 100.s,
                  ),
                  SizedBox(width: 10.s),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 45.w,
                          height: 18,
                          color: baseShimmerColor,
                        ),
                        SizedBox(height: 14.s),
                        Container(
                          width: 37.w,
                          height: 15.s,
                          color: baseShimmerColor,
                        ),
                        SizedBox(height: 10.s),
                        Container(
                          width: 37.w,
                          height: 15,
                          color: baseShimmerColor,
                        ),
                        SizedBox(height: 10.s),
                        Container(
                          width: 37.w,
                          height: 15,
                          color: baseShimmerColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFiltersModelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GetBuilder<FilterController>(
          builder: (filterController) {
            return Container(
              decoration: const BoxDecoration(
                color: bottomNavigationColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      UIText.body4('Filtrar'),
                      SizedBox(width: 4.s),
                      const Icon(Icons.filter_list, color: secondaryColor),
                    ],
                  ),
                  SizedBox(height: 10.s),
                  CustomCheckboxAndLabel(
                    label: UIText.label4('Apenas meus registros'),
                    value: filterController.onlyMyRegisters,
                    onChanged: (newValue) =>
                        filterController.setOnlyMyRegisters(newValue!),
                  ),
                  CustomCheckboxAndLabel(
                    label: UIText.label4('Filtrar por data'),
                    value: filterController.filterByDateRange,
                    onChanged: (newValue) =>
                        filterController.setFilterByDateRange(newValue!),
                  ),
                  SizedBox(height: 10.s),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDateTextField(
                          enabled: filterController.filterByDateRange,
                          selectDate: () =>
                              _pickDateTime(filterController: filterController),
                          labelText: 'Data Inicial',
                          prefixIcon: Icons.today,
                          controller: _initialDateController,
                        ),
                      ),
                      SizedBox(width: 10.s),
                      Expanded(
                        child: CustomDateTextField(
                          enabled: filterController.filterByDateRange,
                          selectDate: () => _pickDateTime(
                              isInitial: false,
                              filterController: filterController),
                          labelText: 'Data Final',
                          suffixIcon: Icons.event,
                          controller: _finalDateController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.s),
                  CustomPrimaryButton(
                    titleText: 'APLICAR',
                    onPressed: _applyFilters,
                  ),
                  SizedBox(height: 10.s),
                  CustomPrimaryButton(
                    isALternative: true,
                    titleText: 'REMOVER FILTROS',
                    onPressed: _resetFilters,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _applyFilters() {
    final filterController = Get.find<FilterController>();
    final authController = Get.find<AuthController>();
    List<BioData> filteredList = _bioController.animalsList;

    if (!filterController.onlyMyRegisters && !filterController.filterByDateRange) {
      return _resetFilters();
    }

      // Filtrar pelos registros do usuário
      if (filterController.onlyMyRegisters) {
      filteredList = filteredList.where((animal) {
        return animal.userId == authController.user!.id;
      }).toList();

      if (!filterController.filterByDateRange) {
        _initialDateController.text = Formatters.formatDatetime(DateTime(2024));
        _finalDateController.text = Formatters.formatDatetime(DateTime.now());
        filterController.resetDateRange();

        setState(() => _animalsList = filteredList);
        Get.back();
        return;
      }
    }

    // Filtrar por data
    if (filterController.filterByDateRange) {
      if (!filterController.onlyMyRegisters) {
        filteredList = _bioController.animalsList;
      }

      filteredList = filteredList.where((animal) {
        return (animal.createdAt.isAfter(filterController.initialDate) ||
                animal.createdAt
                    .isAtSameMomentAs(filterController.initialDate)) &&
            (animal.createdAt.isBefore(filterController.finalDate) ||
                animal.createdAt.isAtSameMomentAs(filterController.finalDate));
      }).toList();
    }

    setState(() => _animalsList = filteredList);
    Get.back();
  }

  void _resetFilters() {
    setState(() {
      _initialDateController.text = Formatters.formatDatetime(DateTime(2024));
      _finalDateController.text = Formatters.formatDatetime(DateTime.now());
      Get.find<FilterController>().resetFilters();
      _animalsList = _bioController.animalsList;
    });
    Get.back();
  }

  Future<void> _pickDateTime(
      {bool isInitial = true,
      required FilterController filterController}) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      locale: const Locale('pt', 'BR'),
      initialDate:
          isInitial ? filterController.initialDate : filterController.finalDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      selectableDayPredicate: isInitial
          ? (DateTime day) => day.isBefore(filterController.finalDate)
          : (DateTime day) => day.isAfter(filterController.initialDate),
    );

    if (pickedDateTime != null) {
      if (isInitial) {
        filterController.setInitialDate(pickedDateTime);
        _initialDateController.text = Formatters.formatDatetime(pickedDateTime);
      } else {
        filterController.setFinalDate(pickedDateTime);
        _finalDateController.text = Formatters.formatDatetime(pickedDateTime);
      }
    }
  }
}
