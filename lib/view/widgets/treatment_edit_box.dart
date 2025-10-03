import 'package:flutter/material.dart';

class TreatmentEditDialog extends StatefulWidget {
  final Map<String, dynamic>? treatment;
  final Function(Map<String, dynamic>) onSave;

  const TreatmentEditDialog({
    Key? key,
    this.treatment,
    required this.onSave,
  }) : super(key: key);

  @override
  State<TreatmentEditDialog> createState() => _TreatmentEditDialogState();
}

class _TreatmentEditDialogState extends State<TreatmentEditDialog> {
  String _selectedTreatment = 'Choose preferred treatment';
  int _maleCount = 0;
  int _femaleCount = 0;

  List<String> treatments = [
    'Choose preferred treatment',
    'Couple Combo package 1',
    'Couple Combo package 2',
    'Single Treatment',
    'Family Package',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.treatment != null) {
      String treatmentName = widget.treatment!['name'] ?? 'Choose preferred treatment';
      
      // Check if the treatment exists in the list, if not add it or use default
      if (treatments.contains(treatmentName)) {
        _selectedTreatment = treatmentName;
      } else if (treatmentName != 'Choose preferred treatment') {
        // Optionally add the treatment to the list
        treatments.add(treatmentName);
        _selectedTreatment = treatmentName;
      }
      
      _maleCount = widget.treatment!['male'] ?? 0;
      _femaleCount = widget.treatment!['female'] ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Treatment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            // Treatment Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedTreatment,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                  items: treatments.map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedTreatment = val!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Add Patients Label
            const Text(
              'Add Patients',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            
            // Male Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Male',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    _buildCounterButton(
                      icon: Icons.remove,
                      onTap: () {
                        if (_maleCount > 0) {
                          setState(() => _maleCount--);
                        }
                      },
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Center(
                        child: Text(
                          _maleCount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildCounterButton(
                      icon: Icons.add,
                      onTap: () {
                        setState(() => _maleCount++);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Female Counter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Female',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    _buildCounterButton(
                      icon: Icons.remove,
                      onTap: () {
                        if (_femaleCount > 0) {
                          setState(() => _femaleCount--);
                        }
                      },
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                      ),
                      child: Center(
                        child: Text(
                          _femaleCount.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    _buildCounterButton(
                      icon: Icons.add,
                      onTap: () {
                        setState(() => _femaleCount++);
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSave({
                    'name': _selectedTreatment,
                    'male': _maleCount,
                    'female': _femaleCount,
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006837),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF006837),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}