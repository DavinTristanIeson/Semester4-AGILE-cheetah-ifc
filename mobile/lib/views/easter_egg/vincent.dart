import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';

/* Pertemuan 5:
- Checkbox
- Chips */
class VincentPage extends StatefulWidget {
  const VincentPage({super.key});
  @override
  State<VincentPage> createState() => _VincentPageState();
}

class _VincentPageState extends State<VincentPage> {
  final List<String> _chips = ['Ambatubus', 'Ambatukam', 'Ambatublou'];
  final List<bool> _checkboxValues = [false, true, false];
  final TextEditingController _chipInputController = TextEditingController();

  @override
  void dispose() {
    _chipInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: COLOR_PRIMARY,
      appBar: AppBar(
        title: const Text('my best effort :)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chips:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _buildChips(),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chipInputController,
                    decoration: const InputDecoration(
                      labelText: 'Tambah Chip Baru',
                      fillColor: COLOR_SECONDARY,
                      filled: true
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addChip,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Checkboxes:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Column(
              children: _buildCheckboxes(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildChips() {
    return _chips.map((String chip) {
      return InputChip(
        label: Text(chip),
        onDeleted: () {
          setState(() {
            _chips.remove(chip);
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildCheckboxes() {
    return _checkboxValues.asMap().entries.map((entry) {
      final index = entry.key;
      final value = entry.value;

      return CheckboxListTile(
        title: Text('Box ke ${index + 1}'),
        value: value,
        activeColor: COLOR_PRIMARY_DARK,
        onChanged: (newValue) {
          setState(() {
            _checkboxValues[index] = newValue!;
          });
        },
      );
    }).toList();
  }

  void _addChip() {
    final newChip = _chipInputController.text.trim();
    if (newChip.isNotEmpty) {
      setState(() {
        _chips.add(newChip);
      });
      _chipInputController.clear();
    }
  }
}