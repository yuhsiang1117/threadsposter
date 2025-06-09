import 'package:flutter/material.dart';

class DaysSlider extends StatefulWidget {

  final int selectedDays;
  final void Function(int)? onDaysSelected;
  const DaysSlider({super.key, this.onDaysSelected, required this.selectedDays});

  @override
  State<DaysSlider> createState() => _DaysSliderState();
}

class _DaysSliderState extends State<DaysSlider> {

  int? selectedDays;

  @override
  void initState() {
    super.initState();
    selectedDays = widget.selectedDays;
  }

  void _onDayChanged(int days) {
    setState(() {
      selectedDays = days;
    });

    if (widget.onDaysSelected != null) {
      widget.onDaysSelected!(days); // 傳出去
    }
  }

  @override
  Widget build(BuildContext contex) {
    return SizedBox(
      width: double.infinity,
      child: IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Text(
          '天數範圍',
          style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          )
        ),
        const SizedBox(height: 10),
        Row(
          children: [
          SizedBox(
            width: 60,
            child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            ),
            controller: TextEditingController(text: selectedDays.toString()),
            onChanged: (value) {
              int? days = int.tryParse(value);
              if (days != null) {
              setState(() {
                if(days !< 1){
                days = 1;
                } else if(days !> 30){
                days = 30;
                }
                selectedDays = days;
              });
              }
            },
            ),
          ),
          Slider(
            value: (selectedDays ?? 1).toDouble(),
            min: 1,
            max: 30,
            divisions: 29,
            label: '${selectedDays ?? 1} 天',
            onChanged: (double value) {
              _onDayChanged(value.round());
            },
          ),
          ],
        ),
        ],
      ),
      ),
    );
  }
}