import 'dart:typed_data';

import 'package:bioindica/src/auth/presentation/controllers/auth_controller.dart';
import 'package:bioindica/src/bio/data/enums/bio_state.dart';
import 'package:bioindica/src/bio/data/enums/fauna_or_flora.dart';
import 'package:bioindica/src/bio/domain/entities/bio_data.dart';
import 'package:bioindica/src/bio/domain/entities/location.dart';
import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:bioindica/src/core/utils/formatters.dart';
import 'package:bioindica/src/core/utils/mock_app_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFaunaForm extends StatefulWidget {
  final Location localization;
  final List<Uint8List> selectedPhotos;
  final List<String> species;
  final Future<void> Function(BioData bioData) registerBio;

  const CustomFaunaForm(
      {super.key,
      required this.localization,
      required this.selectedPhotos,
      required this.registerBio,
      required this.species});

  @override
  State<CustomFaunaForm> createState() => _CustomFaunaFormState();
}

class _CustomFaunaFormState extends State<CustomFaunaForm> {
  BioState _bioState = BioState.vivo;
  VestigioType _vestigioType = VestigioType.pegadas;

  String _quantityFound = '1';
  String _approximateAge = 'Adulto';

  final List<String> _quantityOptions = ['1', '2', '3', '4', '5 ou mais'];
  final List<String> _approximateAgeOptions = ['Adulto', 'Jovem', 'Filhote'];

  final TextEditingController _ctrlSpecie = TextEditingController(text: especiesFauna.first);
  final TextEditingController _ctrlObservations = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomSearchSpecieTextField(
          labelText: 'Selecione a espécie',
          controller: _ctrlSpecie,
          species: especiesFauna,
        ),
        SizedBox(height: 10.s),
        CustomDropdown<BioState>(
          // Estado do animal
          onChanged: (newState) => setState(() => _bioState = newState),
          label: 'Estado do animal',
          initialValue: BioState.vivo,
          items: BioState.values
              .map((bioState) => DropdownMenuItem(
                  value: bioState, child: Text(bioState.value)))
              .toList(),
        ),
        SizedBox(height: 10.s),
        Visibility(
          visible: _bioState == BioState.vestigio,
          child: CustomDropdown<VestigioType>(
            // Estado do animal
            onChanged: (newVestigioType) => _vestigioType = newVestigioType,
            label: 'Tipo de vestígio',
            initialValue: _vestigioType,
            items: VestigioType.values
                .map((vestigioDetail) => DropdownMenuItem<VestigioType>(
                    value: vestigioDetail, child: Text(vestigioDetail.value)))
                .toList(),
          ),
        ),
        SizedBox(height: 10.s),
        CustomDropdown<String>(
          // Quantidade encontrada
          initialValue: _quantityFound,
          onChanged: (newQuantity) => _quantityFound = newQuantity,
          label: 'Quantidade encontrada',
          items: _quantityOptions.map((quantityOption) {
            return DropdownMenuItem(
                value: quantityOption, child: Text(quantityOption));
          }).toList(),
        ),
        SizedBox(height: 10.s),
        CustomDropdown<String>(
          // Idade aproximada
          onChanged: (newNextAge) => _approximateAge = newNextAge,
          label: 'Idade aproximada',
          initialValue: _approximateAge,
          items: _approximateAgeOptions.map((approximateAge) {
            return DropdownMenuItem(
                value: approximateAge, child: Text(approximateAge));
          }).toList(),
        ),
        SizedBox(height: 10.s),
        CustomTextField2(
          controller: _ctrlObservations,
          labelText: 'Anotação livre',
          hintText: 'Ex: Encontrado próximo a uma árvore de grande porte',
          minLines: 5,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
        ),
        SizedBox(height: 15.s),
        CustomPrimaryButton(  // Botão de salvar
          onPressed: () {
            final BioData bioData = BioData(
              userId: Get.find<AuthController>().user!.id,
              latimName: Formatters.getLatimName(_ctrlSpecie.text),
              photos: widget.selectedPhotos,
              localization: widget.localization.address == null
                  ? widget.localization.copyWith(address: 'Não informado')
                  : widget.localization,
              faunaOrFlora: FaunaOrFlora.fauna,
              specie: _ctrlSpecie.text,
              lifeStateInFauna: _bioState,
              quantityFound: int.parse(_quantityFound),
              aproximatedAge: _approximateAge,
              observations: _ctrlObservations.text,
              createdAt: DateTime.now(),
            );

            widget.registerBio(bioData);
          },
          titleText: 'Salvar',
        ),
      ],
    );
  }
}
