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

class CustomFloraForm extends StatefulWidget {
  final Location localization;
  final List<Uint8List> selectedPhotos;
  final List<String> species;
  final Future<void> Function(BioData bioData) registerBio;

  const CustomFloraForm({super.key, required this.localization, required this.selectedPhotos, required this.registerBio, required this.species});

  @override
  State<CustomFloraForm> createState() => _CustomFloraFormState();
}

class _CustomFloraFormState extends State<CustomFloraForm> {
  RegisterInformation _registerInformation = RegisterInformation.nativa;
  bool _isFlowering = true;
  bool _isFruiting = true;
  Porte _porte = Porte.arboreo;

  String _quantidadeEncontrada = '1';

  final List<String> _quantityOptions = ['1', '2', '3', '4', '5 ou mais'];

  final TextEditingController _ctrlSpecie = TextEditingController(text: especiesFlora.first);
  final TextEditingController _ctrlObservations = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomSearchSpecieTextField(
          labelText: 'Selecione a espécie',
          controller: _ctrlSpecie,
          species: especiesFlora,
        ),
        SizedBox(height: 10.s),
        CustomDropdown<RegisterInformation>(
          // Informações do registro da planta
          onChanged: (newInformation) => _registerInformation = newInformation,
          label: 'Informações do registro',
          initialValue: RegisterInformation.nativa,
          items: RegisterInformation.values
              .map((information) => DropdownMenuItem(
                  value: information, child: Text(information.value)))
              .toList(),
        ),
        SizedBox(height: 10.s),
        Column( // Em floração
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIText.label4('Em floração'),
            SizedBox(height: 5.s),
            Row(
              children: [
                CustomCheckboxAndLabel(
                  label: UIText.label4('Sim'),
                  value: _isFlowering,
                  onChanged: (_) => setState(() => _isFlowering = true),
                ),
                CustomCheckboxAndLabel(
                  label: UIText.label4('Não'),
                  value: !_isFlowering,
                  onChanged: (_) => setState(() => _isFlowering = false),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.s),
        Column(
          // Com frutos/sementes
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UIText.label4('Com frutos/sementes'),
            SizedBox(height: 5.s),
            Row(
              children: [
                CustomCheckboxAndLabel(
                  label: UIText.label4('Sim'),
                  value: _isFruiting,
                  onChanged: (_) => setState(() => _isFruiting = true),
                ),
                CustomCheckboxAndLabel(
                  label: UIText.label4('Não'),
                  value: !_isFruiting,
                  onChanged: (_) => setState(() => _isFruiting = false),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.s),
        CustomDropdown<Porte>(
          // Porte
          onChanged: (newPorte) => _porte = newPorte,
          label: 'Porte',
          initialValue: _porte,
          items: Porte.values.map((porteOption) {
            return DropdownMenuItem<Porte>(
                value: porteOption, child: Text(porteOption.value));
          }).toList(),
        ),
        SizedBox(height: 10.s),
        CustomDropdown<String>(
          // Quantidade encontrada
          onChanged: (newQuantity) => _quantidadeEncontrada = newQuantity,
          label: 'Quantidade encontrada',
          initialValue: _quantidadeEncontrada,
          items: _quantityOptions.map((quantityOption) {
            return DropdownMenuItem(
                value: quantityOption, child: Text(quantityOption));
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
        CustomPrimaryButton(
          onPressed: () {
            final BioData bioData = BioData(
              userId: Get.find<AuthController>().user!.id,
              latimName: Formatters.getLatimName(_ctrlSpecie.text),
              photos: widget.selectedPhotos,
              localization: widget.localization.address == null
                  ? widget.localization.copyWith(address: 'Não informado')
                  : widget.localization,
              faunaOrFlora: FaunaOrFlora.flora,
              specie: _ctrlSpecie.text,
              quantityFound: int.parse(_quantidadeEncontrada),
              observations: _ctrlObservations.text,
              createdAt: DateTime.now(),
              registerInformation: _registerInformation,
            );

            widget.registerBio(bioData);
          },
          titleText: 'Salvar',
        ),
      ],
    );
  }
}
