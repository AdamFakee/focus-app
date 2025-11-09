import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/common/widgets/buttons/cancel_confirm_buttons.dart';
import 'package:focus_app/utils/const/colors.dart';
import 'package:focus_app/utils/const/sizes.dart';

// Enum để quản lý các loại âm thanh
enum WhiteNoiseSound { none, rainfall, oceanWaves, forestWind }

class ClockWhiteNoiseDialog extends StatefulWidget {
  const ClockWhiteNoiseDialog({super.key});

  @override
  State<ClockWhiteNoiseDialog> createState() => _ClockWhiteNoiseDialogState();
}

class _ClockWhiteNoiseDialogState extends State<ClockWhiteNoiseDialog> {
  // Biến trạng thái
  double _currentVolume = 0.75; // Âm lượng hiện tại (0.0 đến 1.0)
  WhiteNoiseSound _selectedSound = WhiteNoiseSound.rainfall; // Âm thanh được chọn

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề
          Center(
            child: Text(
              "White Noise",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwSections),

          // Thanh trượt âm lượng
          _buildVolumeSlider(),
          const SizedBox(height: Sizes.md),


          // Danh sách các âm thanh
          _buildSoundOption(
            icon: CupertinoIcons.cloud_rain,
            title: 'Rainfall',
            sound: WhiteNoiseSound.rainfall,
          ),
          _buildSoundOption(
            icon: CupertinoIcons.wind,
            title: 'Ocean Waves',
            sound: WhiteNoiseSound.oceanWaves,
          ),
          _buildSoundOption(
            icon: CupertinoIcons.tree,
            title: 'Forest Wind',
            sound: WhiteNoiseSound.forestWind,
          ),
          const SizedBox(height: Sizes.spaceBtwSections),

          CancelConfirmButtons(
            onConfirmed: () {},
            onCanceled: () {},
            confirmTitle: 'Save',
          )
        ],
      ),
    );
  }

  /// Widget con để xây dựng thanh trượt âm lượng
  Widget _buildVolumeSlider() {
    return Row(
      children: [
        Text(
          "Volume",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.red,
              inactiveTrackColor: AppColors.gray,
              thumbColor: AppColors.white,
              overlayColor: AppColors.red.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
            ),
            child: Slider(
              value: _currentVolume,
              min: 0,
              max: 1,
              onChanged: (value) {
                setState(() {
                  _currentVolume = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Widget con để xây dựng một mục tùy chọn âm thanh
  Widget _buildSoundOption({
    IconData? icon,
    required String title,
    required WhiteNoiseSound sound,
  }) {
    final bool isSelected = _selectedSound == sound;
    return InkWell(
      onTap: () => setState(() => _selectedSound = sound),
      child: Column(
        children: [
          const Divider(height: 1, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.md),
            child: Row(
              children: [
                // Icon (nếu có)
                if (icon != null)
                  Icon(icon),
                
                // Khoảng cách nếu không có icon để căn chỉnh
                if (icon == null) const SizedBox(width: 24),

                const SizedBox(width: Sizes.md),
                
                // Tiêu đề
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge
                  ),
                ),
                
                // Dấu tick nếu được chọn
                if (isSelected)
                  Icon(Icons.check, color: AppColors.red, size: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}