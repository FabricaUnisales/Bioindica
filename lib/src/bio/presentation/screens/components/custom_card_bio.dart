import 'package:bioindica/src/base/presentation/components/custom_radius_image.dart';
import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:bioindica/src/core/utils/formatters.dart';
import 'package:bioindica/src/bio/data/enums/bio_state.dart';
import 'package:bioindica/src/bio/data/enums/fauna_or_flora.dart';
import 'package:bioindica/src/bio/domain/entities/bio_data.dart';
import 'package:bioindica/src/bio/presentation/screens/components/custom_bio_life_state.dart';
import 'package:flutter/material.dart';

class CustomCardBio extends StatelessWidget {
  final BioData bioData;
  final VoidCallback onTap;

  const CustomCardBio({super.key, required this.bioData, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    final bool photosIsEmpty = bioData.photos.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow:  [
          BoxShadow(
            color: labelColor.withOpacity(0.55),
            spreadRadius: 0,
            blurStyle: BlurStyle.outer,
            blurRadius: 10,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          child: InkWell(
            splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
            onTap: onTap,
            child: Padding(
              padding:  const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                      decoration: bioData.photos.isNotEmpty
                          ? null
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: secondaryColor,
                                width: 2,
                              ),
                            ),
                      width: 100.s,
                      height: 100.s,
                      child: _buildPhoto(photosIsEmpty),
                  ),
                  SizedBox(width: 10.s),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: UIText.cardTitle(Formatters.getVernacularName(bioData.specie), maxLines: 2)),
                            Visibility(
                              visible: bioData.faunaOrFlora == FaunaOrFlora.fauna,
                              child: CustomBioLifeState(
                                bioLifeState: bioData.lifeStateInFauna?.value ?? '',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.s),
                        UIText.cardSubtitle(bioData.latimName!),
                        SizedBox(height: 10.s),
                        Row(
                          children: [
                            UIText.cardLabel('Localização: '),
                            Expanded(child: UIText.data(bioData.localization.address!)),
                          ],
                        ),
                        UIText.data(Formatters.formatDatetime(bioData.createdAt)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoto(bool photosIsEmpty) {
    return photosIsEmpty
        ? CustomRadiusImage(image: bioData.photos.first)
        : const Icon(Icons.image_not_supported_outlined);
  }
}
