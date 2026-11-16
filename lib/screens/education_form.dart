import 'package:flutter/material.dart';

import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _institutionController = TextEditingController();
  final _levelController = TextEditingController();
  final _programController = TextEditingController();
  final _startYearController = TextEditingController();
  final _endYearController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _institutionController.dispose();
    _levelController.dispose();
    _programController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Kolom ini wajib diisi.';
    }
    return null;
  }

  String? _yearValidator(String? value) {
    final requiredError = _requiredValidator(value);
    if (requiredError != null) return requiredError;

    final year = int.tryParse(value!.trim());
    if (year == null || year < 1900 || year > 2100) {
      return 'Masukkan tahun antara 1900 dan 2100.';
    }
    return null;
  }

  String? _endYearValidator(String? value) {
    final yearError = _yearValidator(value);
    if (yearError != null) return yearError;

    final startYear = int.tryParse(_startYearController.text.trim());
    final endYear = int.parse(value!.trim());
    if (startYear != null && endYear < startYear) {
      return 'Tahun selesai tidak boleh sebelum tahun mulai.';
    }
    return null;
  }

  Future<void> _saveEducation() async {
    if (!_formKey.currentState!.validate()) return;

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data edukasi berhasil disimpan'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _summary('Institusi', _institutionController.text),
              _summary('Jenjang', _levelController.text),
              _summary('Program studi', _programController.text),
              _summary(
                'Periode',
                '${_startYearController.text}–${_endYearController.text}',
              ),
              _summary('Deskripsi', _descriptionController.text),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _summary(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text('$label: ${value.trim()}'),
      );

  Widget _textField({
    required TextEditingController controller,
    required String label,
    String? hint,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator ?? _requiredValidator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          alignLabelWithHint: maxLines > 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Edukasi'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Tambahkan riwayat pendidikan',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _textField(
                controller: _institutionController,
                label: 'Nama institusi',
                hint: 'Contoh: Universitas Indonesia',
              ),
              _textField(
                controller: _levelController,
                label: 'Jenjang pendidikan',
                hint: 'Contoh: S1',
              ),
              _textField(
                controller: _programController,
                label: 'Program studi',
                hint: 'Contoh: Sistem Informasi',
              ),
              Row(
                children: [
                  Expanded(
                    child: _textField(
                      controller: _startYearController,
                      label: 'Tahun mulai',
                      keyboardType: TextInputType.number,
                      validator: _yearValidator,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _textField(
                      controller: _endYearController,
                      label: 'Tahun selesai',
                      keyboardType: TextInputType.number,
                      validator: _endYearValidator,
                    ),
                  ),
                ],
              ),
              _textField(
                controller: _descriptionController,
                label: 'Deskripsi',
                hint: 'Mata kuliah, fokus, atau pencapaian terkait',
                maxLines: 4,
              ),
              FilledButton.icon(
                onPressed: _saveEducation,
                icon: const Icon(Icons.save_outlined),
                label: const Text('Simpan'),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
