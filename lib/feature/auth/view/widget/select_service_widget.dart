import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../bloc/select_service_bloc/select_service_bloc.dart';
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
        // Trigger the BLoC event to fetch services
        context.read<SelectServiceBloc>().add(FetchAllServicesEvent());

        // Listen for the state change to show the dialog when data is fetched
        showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return BlocBuilder<SelectServiceBloc, SelectServiceState>(
              builder: (context, state) {
                if (state is FetchAllAddedServicesLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is FetchAllAddedServicesSuccessState) {
                  return SimpleDialog(
                    title: const Text(
                      'Select Service',
                      style: TextStyle(color: AppColor.secondary),
                      textAlign: TextAlign.center,
                    ),
                    children: state.fetchAllServiceModel.map((service) {
                      return SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, service.serviceName);
                        },
                        child: Text(
                          service.serviceName,
                          style: const TextStyle(color: AppColor.secondary),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  );
                } else if (state is FetchAllAddedServicesFailState) {
                  return SimpleDialog(
                    title: const Text(
                      'Failed to load services',
                      style: TextStyle(color: AppColor.toneSeven),
                      textAlign: TextAlign.center,
                    ),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: const Text(
                            'OK',
                            style: TextStyle(color: AppColor.secondary),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            );
          },
        ).then((selectedService) {
          if (selectedService != null) {
            serviceController.text = selectedService;
          }
        });
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
