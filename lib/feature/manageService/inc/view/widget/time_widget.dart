import 'package:flutter/cupertino.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';
import '../../../../../core/theme/color/app_color.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({
    super.key,
    required this.workedTimeController,
  });

  final TextEditingController workedTimeController;

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  // Initialize the selected time to "00:00"
  DateTime _selectedTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);

  @override
  void initState() {
    super.initState();
    // Initialize the controller with "00:00"
    widget.workedTimeController.text =
        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.toneTwelve,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Select Your Worked Time',
                style: TextStyle(
                  color: AppColor.secondary,
                ),
              ),
              TimePickerSpinnerPopUp(
                mode: CupertinoDatePickerMode.time,
                initTime: _selectedTime,
                minuteInterval: 1,
                cancelText: 'Cancel',
                confirmText: 'OK',
                pressType: PressType.singlePress,
                timeFormat: 'HH:mm',
                onChange: (dateTime) {
                  setState(() {
                    _selectedTime = dateTime;
                    widget.workedTimeController.text =
                        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
