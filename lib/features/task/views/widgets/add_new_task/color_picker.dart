import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:focus_app/common/widgets/modal_bottom_sheets/model_bottom_sheet_barrier.dart';
import 'package:focus_app/common/widgets/sections/section_lable.dart';
import 'package:focus_app/utils/const/sizes.dart';
import 'package:focus_app/utils/data/colors/task_colors.dart';

class ColorPickerWidget extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;
  final VoidCallback? onCustomColorTap; // Callback cho nút chọn màu tùy chỉnh

  const ColorPickerWidget({
    super.key, 
    required this.selectedColor, 
    required this.onColorSelected,
    this.onCustomColorTap,
  });

  final Color pickerColor = const Color(0xff443a49);


  void onPicker (BuildContext ctx) async {
    final color = await ModelBottomSheetBarrier().show<Color>(
      context: ctx, 
      initialChildSize: 0.6,
      child: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: MaterialPicker(
              pickerColor: pickerColor,
              portraitOnly: true,
              onColorChanged: (color) {
                Navigator.of(context).pop(color);
              },
            ),
          );
        }
      )
    );

    print(color.toString());
  }
  
  @override
  Widget build(BuildContext context) {    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLable(title: 'Color'),
        const SizedBox(height: Sizes.sm),

        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: Sizes.md,
            mainAxisSpacing: Sizes.md,
          ),
          
          itemCount: taskColors.length + 1,
          
          itemBuilder: (context, index) {
            // Kiểm tra nếu đây là index của nút custom (vị trí cuối cùng)
            if (index == taskColors.length) {
              // --- Build nút chọn màu tùy chỉnh ---
              return GestureDetector(
                onTap: () => onPicker(context),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [ Colors.red, Colors.yellow, Colors.green, Colors.blue, Colors.red ],
                      ),
                    ),
                  ),
                ),
              );
            }
            
            // --- Nếu không, build một ô màu bình thường ---
            final color = taskColors[index];
            final isSelected = selectedColor.value == color.value;

            return GestureDetector(
              onTap: () => onColorSelected(color),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: color,
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 24)
                    : null,
              ),
            );
          },

          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ],
    );
  }
}