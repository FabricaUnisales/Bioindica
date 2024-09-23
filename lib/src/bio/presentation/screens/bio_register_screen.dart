import 'dart:typed_data';

import 'package:bioindica/src/base/presentation/components/custom_navigate_back_button.dart';
import 'package:bioindica/src/base/presentation/components/custom_snack_bar.dart';
import 'package:bioindica/src/bio/domain/entities/bio_data.dart';
import 'package:bioindica/src/bio/presentation/controllers/location_controller.dart';
import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:bioindica/src/bio/data/enums/fauna_or_flora.dart';
import 'package:bioindica/src/bio/presentation/controllers/bio_controller.dart';
import 'package:bioindica/src/bio/presentation/screens/components/form_components/register_forms/custom_fauna_form.dart';
import 'package:bioindica/src/bio/presentation/screens/components/form_components/register_forms/custom_flora_form.dart';
import 'package:bioindica/src/core/routes.dart';
import 'package:bioindica/src/core/utils/photo_util.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class BioRegisterScreen extends StatefulWidget {
  const BioRegisterScreen({super.key});

  @override
  State<BioRegisterScreen> createState() => _BioRegisterScreenState();
}

class _BioRegisterScreenState extends State<BioRegisterScreen> {
  late BioController _bioController;
  late LocationController _locationController;
  final ScrollController _scrollController = ScrollController();

  final int photosLimit = 4;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Uint8List> selectedPhotos = [];
  FaunaOrFlora _faunaOrFlora = FaunaOrFlora.fauna;
  List<String> speciesList = [];

  @override
  void initState() {
    _locationController = Get.find<LocationController>();
    _bioController = Get.find<BioController>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        selectedPhotos.add(Get.arguments as Uint8List);
      });
      await _getCurrentLocation();
      speciesList = await _bioController.getSpeciesList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _showDialogLoosingData(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.s, vertical: 10.s),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10.s, bottom: 15.s),
                      alignment: Alignment.topLeft,
                      child: CustomNavigateBackButton(
                        navigateBackFunction: () => _showDialogLoosingData(context),
                      ),
                    ),
                    GetBuilder<LocationController>(
                      builder: (locationController) {
                        return CustomTextField2(
                          enabled: false,
                          controller: TextEditingController(text: locationController.location.value.address ?? 'A localização será exibida aqui...'),
                          labelText: 'Localização',
                          suffixIcon: Icons.pin_drop_outlined,
                          isSVGSuffixIcon: true,
                          svgSuffixIcon: 'assets/custom_icons/mapIcon.svg',
                        );
                      },
                    ),
                    SizedBox(height: 10.s),
                    _buildPhotosSection(),
                    SizedBox(height: 10.s),
                    UIText.label4('Você está registrando sobre:'),
                    CustomCheckboxAndLabel(
                      label: UIText.label4('Fauna'),
                      value: _faunaOrFlora == FaunaOrFlora.fauna,
                      onChanged: (_) =>
                          setState(() => _faunaOrFlora = FaunaOrFlora.fauna),
                    ),
                    CustomCheckboxAndLabel(
                      label: UIText.label4('Flora'),
                      value: _faunaOrFlora == FaunaOrFlora.flora,
                      onChanged: (_) =>
                          setState(() => _faunaOrFlora = FaunaOrFlora.flora),
                    ),
                    SizedBox(height: 10.s),
                    Visibility(
                      visible: _faunaOrFlora == FaunaOrFlora.fauna,
                      replacement: CustomFloraForm(
                        localization: _locationController.location.value,
                        selectedPhotos: selectedPhotos,
                        species: speciesList,
                        registerBio: _registerBio,
                      ),
                      child: CustomFaunaForm(
                        localization: _locationController.location.value,
                        selectedPhotos: selectedPhotos,
                        species: speciesList,
                        registerBio: _registerBio,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotosSection() {
    return SizedBox(
      height: 100.s,
      child: Scrollbar(
        thumbVisibility: true,
        controller: _scrollController,
        child: ListView.separated(
          controller: _scrollController,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemCount: selectedPhotos.length == photosLimit
              ? selectedPhotos.length
              : selectedPhotos.length + 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final bool isOnLimit = selectedPhotos.length == photosLimit;
            if (index == selectedPhotos.length && !isOnLimit) {
              return _buildAddPhotosButton();
            }

            return GestureDetector(
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: UIText.title('Excluir Foto'),
                        content: UIText.body5(
                          'Deseja mesmo excluir a foto registrada?',
                          maxLines: 2,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: UIText.cancelButton('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() => selectedPhotos.removeAt(index));
                              Get.back();
                            },
                            child: UIText.confirmButton('Excluir'),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: bodyTextColor),
                ),
                height: 100.s,
                width: 100.s,
                child: CustomRadiusImage(
                  image: selectedPhotos[index],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddPhotosButton() {
    return GestureDetector(
      onTap: () async {
        await PhotoUtil.takePhoto().then((photoBytes) {
          if (photoBytes != null) {
            setState(() => selectedPhotos.add(photoBytes));
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: bodyTextColor,
            width: 2,
          ),
        ),
        height: 100.s,
        width: 100.s,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: bodyTextColor),
            UIText.body6('Adicionar'),
          ],
        ),
      ),
    );
  }

  Future<void> _registerBio(BioData bioData) async {
    if (_formKey.currentState!.validate()) {
      if (selectedPhotos.isEmpty) {
        return showSnackBar(context, const CustomSnackBar.error(message: 'É nececessário adicionar ao menos uma foto ao registro.'));
      }

      await _bioController.registerNewBio(bioData);
      Get.back();
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!serviceEnabled && mounted) {
      showSnackBar(
        context,
        const CustomSnackBar.error(
          message: 'O serviço de localização está desabilitado.',
        ),
      );
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) {
          showSnackBar(
            context,
            const CustomSnackBar.error(
                message:
                    'A permissão para localização foi negada. Habilite nas configurações do dispositivo.'),
          );
        }
        return;
      }
    }

    final Position currentLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      forceAndroidLocationManager: true,
    );

    await _locationController
        .getLocation(
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
    )
        .then((value) {
      if (_locationController.isFailure) {
        showSnackBar(
          context,
          CustomSnackBar.error(message: value!),
        );
      }
    });
  }

  void _showDialogLoosingData(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: UIText.title('Atenção'),
          content: UIText.body5(
            'Deseja mesmo sair?\nOs dados não salvos serão perdidos.',
            maxLines: 4,
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: UIText.cancelButton('Cancelar'),
            ),
            TextButton(
              onPressed: () => Get.offNamed(ScreensRoutes.base),
              child: UIText.confirmButton('Sair'),
            ),
          ],
        );
      },
    );
  }
}
