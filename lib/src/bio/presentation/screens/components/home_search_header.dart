import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:flutter/material.dart';

class HomeSearchHeader extends StatelessWidget {
  final TextEditingController searchController;
  final Future<void> Function() searchBioByName;
  final VoidCallback openFilters;

  const HomeSearchHeader({
    super.key,
    required this.searchController,
    required this.searchBioByName,
    required this.openFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bottomNavigationColor,
      // padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      child: Row(
        // Pesquisa
        children: [
          _buildSearchTextField(),
          SizedBox(width: 10.s),
          InkWell(
            onTap: openFilters,
            child: Row(
              children: [
                UIText.body4('Filtrar'),
                SizedBox(width: 4.s),
                const Icon(Icons.filter_list, color: secondaryColor),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchTextField() {
    return Expanded(
      child: TextFormField(
        controller: searchController,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        onFieldSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        cursorColor: secondaryColor,
        style: textFieldHintStyle,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: bodyTextColor, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: bodyTextColor, width: 2.2),
          ),
          constraints: const BoxConstraints(maxHeight: 35),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: 'Pesquisar',
          suffixIcon: GestureDetector(
              onTap: () async => searchBioByName(),
              child: const Icon(Icons.search, color: bodyTextColor)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onEditingComplete: () async => searchBioByName(),
      ),
    );
  }
}
