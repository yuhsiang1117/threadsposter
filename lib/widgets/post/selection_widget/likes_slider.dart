import 'package:flutter/material.dart';

class LikesSlider extends StatefulWidget {

  final int selectedLikes;
  final void Function(int)? onLikesSelected;
  const LikesSlider({super.key, this.onLikesSelected, required this.selectedLikes});

  @override
  State<LikesSlider> createState() => _LikesSliderState();
}

class _LikesSliderState extends State<LikesSlider> {

  int? selectedLikes;

  @override
  void initState() {
    super.initState();
    selectedLikes = widget.selectedLikes;
  }

  void _onLikesChanged(int likes) {
    setState(() {
      selectedLikes = likes;
    });

    if (widget.onLikesSelected != null) {
      widget.onLikesSelected!(likes); // 傳出去
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
          '最少按讚數',
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
            controller: TextEditingController(text: selectedLikes.toString()),
            onChanged: (value) {
              int? likes = int.tryParse(value);
              if (likes != null) {
              setState(() {
                if(likes !< 1000){
                likes = 1000;
                } else if(likes !> 5000){
                likes = 5000;
                }
                selectedLikes = likes;
              });
              }
            },
            ),
          ),
          Slider(
            value: (selectedLikes ?? 1).toDouble(),
            min: 1000,
            max: 5000,
            divisions: 4000,
            label: '${selectedLikes ?? 1000} 讚',
            onChanged: (double value) {
              _onLikesChanged(value.round());
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