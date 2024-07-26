import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/theme/color/app_color.dart';
import '../../../../core/util/list_of_elements.dart';
import '../util/auth_util.dart';
import 'auth_textformfield_widget.dart';

class SelectServiceField extends StatelessWidget {
  final TextEditingController serviceController;

  const SelectServiceField({required this.serviceController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String? selectedService = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text(
                'Select Service',
                style: TextStyle(color: AppColor.secondary),
                textAlign: TextAlign.center,
              ),
              children: AppListElements.services.map((String service) {
                return SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, service);
                  },
                  child: Text(
                    service,
                    style: const TextStyle(color: AppColor.secondary),
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            );
          },
        );

        if (selectedService != null) {
          serviceController.text = selectedService;
        }
      },
      child: AbsorbPointer(
        child: AuthTextFormField(
          controller: serviceController,
          labelText: 'Service',
          hintText: 'Select Service',
          validator: AuthUtil.validateService,
        ),
      ),
    );
  }
}
