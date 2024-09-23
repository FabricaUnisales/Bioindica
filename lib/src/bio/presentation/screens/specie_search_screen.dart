import 'package:bioindica/src/bio/presentation/screens/components/bio_ui_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecieSearchScreen extends StatefulWidget {
  const SpecieSearchScreen({super.key});

  @override
  State<SpecieSearchScreen> createState() => _SpecieSearchScreenState();
}

class _SpecieSearchScreenState extends State<SpecieSearchScreen> {
  late ValueNotifier<List<String>> species;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    species = ValueNotifier(Get.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Get.back(),
        ),
        title: TextField(
          autofocus: true,
          controller: _searchController,
          cursorColor: primaryColor,
          decoration: const InputDecoration(
            hintText: 'Pesquisar...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: _searchSpecie,
        ),
        actions: [
          ValueListenableBuilder(
              valueListenable: _searchController,
              builder: (context, textEditingValue, child) {
                return IconButton(
                  icon: Visibility(
                    visible: textEditingValue.text.isEmpty,
                    replacement: const Icon(
                      Icons.close,
                      color: primaryColor,
                    ),
                    child: const Icon(
                      Icons.search,
                      color: primaryColor,
                    ),
                  ),
                  onPressed: () {
                    if (textEditingValue.text.isNotEmpty) {
                      _searchController.clear();
                      _resetList();
                    }
                  },
                );
              }),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: species,
        builder: (context, species, child) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(thickness: 0.2),
            itemCount: species.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: UIText.boxContent(species[index], maxLines: 3),
                onTap: () => Get.back(result: species[index]),
              );
            },
          );
        },
      ),
    );
  }

  void _searchSpecie(String searchValue) {
    if (searchValue.isEmpty) {
      _resetList();
      return;
    }
    species.value = species.value
        .where((specie) =>
            specie.toLowerCase().contains(searchValue.toLowerCase()))
        .toList();
  }

  void _resetList() {
    species.value = Get.arguments;
  }
}
