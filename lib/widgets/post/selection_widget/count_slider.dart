import 'package:flutter/material.dart';

class CountSlider extends StatefulWidget {

  final void Function(int)? onCountSelected;
  const CountSlider({super.key, this.onCountSelected});

  @override
  State<CountSlider> createState() => _CountSliderState();
}

class _CountSliderState extends State<CountSlider> {

  int? selectedCounts;

  @override
  void initState() {
    super.initState();
    selectedCounts = 3; // 預設值為 3 天
  }

  void _onSizeChanged(int count) {
    setState(() {
      selectedCounts = count;
    });

    if (widget.onCountSelected != null) {
      widget.onCountSelected!(count); // 傳出去
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
          '文章數量',
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
            controller: TextEditingController(text: selectedCounts.toString()),
            onChanged: (value) {
              int? count = int.tryParse(value);
              if (count != null) {
              setState(() {
                if(count !< 1){
                count = 1;
                } else if(count !> 5){
                count = 5;
                }
                selectedCounts = count;
              });
              }
            },
            ),
          ),
          Slider(
            value: (selectedCounts ?? 1).toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            label: '${selectedCounts ?? 1} 篇',
            onChanged: (double value) {
              _onSizeChanged(value.round());
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