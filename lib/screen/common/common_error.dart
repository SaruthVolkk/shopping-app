import 'package:flutter/material.dart';
import 'package:shopping_app/gen/figma_color.dart';
import 'package:shopping_app/gen/figma_text_style.dart';
import 'package:shopping_app/screen/common/primary_button.dart';

class CommonErrorWidget extends StatefulWidget {
  final Function? onTryAgain;

  const CommonErrorWidget({
    super.key,
    this.onTryAgain,
  });

  @override
  State<CommonErrorWidget> createState() => _CommonErrorWidgetState();
}

class _CommonErrorWidgetState extends State<CommonErrorWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.cancel_outlined, size: 54, color: FigmaColors.errorRed),
          const SizedBox(height: 10),
          Text('Something went wrong', style: FigmaTextStyles.m3Large.copyWith(color: FigmaColors.textDark)),
          const SizedBox(height: 10),
          PrimaryButton(
            label: 'Refresh',
            onPressed: () => {if (widget.onTryAgain != null) widget.onTryAgain!()},
          ),
        ],
      ),
    );
  }
}
