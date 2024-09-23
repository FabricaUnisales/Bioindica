import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:bioindica/src/bio/data/enums/bio_state.dart';
import 'package:bioindica/src/bio/data/enums/fauna_or_flora.dart';
import 'package:bioindica/src/bio/domain/entities/bio_data.dart';
import 'package:bioindica/src/bio/presentation/controllers/bio_controller.dart';
import 'package:bioindica/src/base/presentation/components/custom_navigate_back_button.dart';
import 'package:bioindica/src/core/utils/formatters.dart';
import 'package:carousel_slider/carousel_slider.dart' as lib;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AboutTabScreen extends StatefulWidget {
  const AboutTabScreen({super.key});

  @override
  State<AboutTabScreen> createState() => _AboutTabScreenState();
}

class _AboutTabScreenState extends State<AboutTabScreen> {
  late BioData _bioData;
  late lib.CarouselController _carouselController;
  int _currentIndicator = 0;
  final ScrollController _scrollController = ScrollController();

  late bool _hasManyPhotos;

  @override
  void initState() {
    _bioData = Get.find<BioController>().selectedAnimal!;

    _carouselController = lib.CarouselController();
    _hasManyPhotos = _bioData.photos.isNotEmpty && _bioData.photos.length > 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UIText.title(Formatters.getVernacularName(_bioData.specie)),
                          UIText.subtitle(_bioData.latimName!),
                        ],
                      ),
                      Visibility(
                        visible: _bioData.faunaOrFlora == FaunaOrFlora.fauna,
                        child: CustomBioLifeState(
                          bioLifeState: _bioData.lifeStateInFauna?.value ?? '',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    child: SizedBox(
                      height: 43.h,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: UIText.body5(
                          _bioData.observations,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.s),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UIText.label4('Localização'),
                            UIText.dataMajor(_bioData.localization.address!, maxLines: 5,),
                          ],
                        ),
                      ),
                      UIText.dataMajor(Formatters.formatDatetime(_bioData.createdAt))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageHeader() {
    return Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: switch (_bioData.photos.length) {
                0 => Container(
                    alignment: Alignment.center,
                    color: bottomNavigationColor,
                    height: 270,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      size: 150,
                    ),
                  ),
                1 => Image.memory(_bioData.photos.first),
                _ => Stack(
                  children: [
                      Positioned.fill(
                        child: ColoredBox(color: baseShimmerColor),
                      ),
                    lib.CarouselSlider(
                        carouselController: _carouselController,
                        disableGesture: true,
                        items: _bioData.photos.isNotEmpty ? _buildImagesList() : [],
                        options: lib.CarouselOptions(
                          height: 270,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.06,
                          initialPage: 0,
                          enableInfiniteScroll: true, // Permite rolagem infinita
                          autoPlay: true, // Reprodução automática
                          autoPlayInterval: const Duration(seconds: 5),
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          pauseAutoPlayOnTouch: true,
                          pauseAutoPlayOnManualNavigate: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          onPageChanged: (index, reason) {
                            setState(() => _currentIndicator = index);
                          },
                        ),
                    ),
                  ],
                ),
              },
            ),
            Positioned(
              top: 30,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomNavigateBackButton(
                      navigateBackFunction: Get.back,
                      backgroundColor: secondaryColor.withOpacity(0.7),
                    ),
                    Image.asset('assets/logo2.png'),
                  ],
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: _hasManyPhotos,
          replacement: const SizedBox(height: 10),
          child: _buildCarrouselIndicators(),
        )
      ],
    );
  }

  List<Widget> _buildImagesList() {
    return _bioData.photos.map((imagePath) {
      return SizedBox(
        width: double.infinity,
        child: Image.memory(
          imagePath,
          fit: BoxFit.fill,
        ),
      );
    }).toList();
  }

  Widget _buildCarrouselIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _bioData.photos.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _carouselController.animateToPage(entry.key),
          child: Container(
            width: 7,
            height: 7,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: secondaryColor.withOpacity(_currentIndicator == entry.key ? 0.9 : 0.4),
            ),
          ),
        );
      }).toList(),
    );
  }
}
