import 'package:flutter/material.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/list_of_elements.dart';
import '../util/auth_util.dart';
import 'auth_textformfield_widget.dart';

class SelectDistrictField extends StatelessWidget {
  final TextEditingController districtController;

  const SelectDistrictField({required this.districtController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? selectedDistrict = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text(
                'Select District',
                style: TextStyle(color: AppColor.secondary),
                textAlign: TextAlign.center,
              ),
              children: AppListElements.districts.map((String district) {
                return SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, district);
                  },
                  child: Text(
                    district,
                    style: const TextStyle(color: AppColor.secondary),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            );
          },
        );

        if (selectedDistrict != null) {
          districtController.text = selectedDistrict;
        }
      },
      child: AbsorbPointer(
        child: AuthTextFormField(
          controller: districtController,
          labelText: 'District',
          hintText: 'Select District',
          validator: AuthUtil.validateDistrict,
        ),
      ),
    );
  }
}
