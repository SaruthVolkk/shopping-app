import 'package:flutter/material.dart';
import 'package:shopping_app/gen/figma_color.dart';

class CounterWidget extends StatefulWidget {
  final num? initialValue;
  final Function? onChanged;

  const CounterWidget({
    super.key,
    this.initialValue = 1,
    this.onChanged,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  num counter = 0;
  TextEditingController counterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    counter = widget.initialValue ?? 1;
    counterController.text = counter.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void increment() {
    setState(() {
      counter++;
    });
    counterController.text = counter.toString();
    widget.onChanged?.call(counter);
  }

  void decrement() {
    if (counter > 0) {
      setState(() {
        counter--;
      });
      counterController.text = counter.toString();
      widget.onChanged?.call(counter);
    }
  }

  Widget buildButton(IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: FigmaColors.primaryPurple,
        padding: const EdgeInsets.all(0),
        minimumSize: const Size(32, 32),
      ),
      child: Icon(icon, color: Colors.white, size: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildButton(Icons.remove, decrement),
        SizedBox(
          width: 40,
          child: TextField(
            controller: counterController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(isDense: true, border: InputBorder.none),
            onSubmitted: (value) {
              final newValue = int.tryParse(value);
              if (newValue != null) {
                setState(() {
                  counter = newValue;
                  counterController.text = counter.toString();
                });
              } else {
                setState(() {
                  counter = 0;
                  counterController.text = '0';
                });
              }
              widget.onChanged?.call(counter);
            },
          ),
        ),
        buildButton(Icons.add, increment),
      ],
    );
  }
}
