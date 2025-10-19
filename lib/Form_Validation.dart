import 'package:flutter/material.dart';

class FormDemoScreen extends StatefulWidget {
  const FormDemoScreen({super.key});

  @override
  State<FormDemoScreen> createState() => _FormDemoScreenState();
}

class _FormDemoScreenState extends State<FormDemoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  String? _role;
  String _gender = 'male';
  bool _acceptTerms = false;
  bool _subscribe = true;
  double _satisfaction = 3;
  DateTime? _date;
  List<String> _hobbies = [];

  final List<String> _roles = ['Student', 'Developer', 'Designer', 'Manager'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) =>
      date == null ? 'Select date' : '${date.day}/${date.month}/${date.year}';

  void _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _toggleHobby(String hobby, bool selected) {
    setState(() => selected ? _hobbies.add(hobby) : _hobbies.remove(hobby));
  }

  void _submitForm() {
    // Form validation
    if (!(_formKey.currentState?.validate() ?? false)) return;

    // Terms check
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must accept terms!')));
      return;
    }

    // Collect data
    final data = {
      'Name': _nameCtrl.text,
      'Email': _emailCtrl.text,
      'Password': '*' * _passwordCtrl.text.length,
      'Role': _role ?? 'Not selected',
      'Gender': _gender,
      'Subscribe': _subscribe ? 'Yes' : 'No',
      'Satisfaction': _satisfaction.toStringAsFixed(1),
      'Date': _formatDate(_date),
      'Hobbies': _hobbies.isEmpty ? 'None' : _hobbies.join(', '),
      'Notes': _notesCtrl.text.isEmpty ? 'None' : _notesCtrl.text,
    };

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Submitted Data'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              data.entries.map((e) => Text('${e.key}: ${e.value}')).toList(),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('OK'))
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String label, {
    bool obscure = false,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: ctrl,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator ?? (v) => v!.isEmpty ? '$label is required' : null,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Validation Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_nameCtrl, 'Full Name'),
              const SizedBox(height: 12),
              _buildTextField(_emailCtrl, 'Email', validator: (v) {
                if (v == null || v.isEmpty) return 'Email required';
                final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!regex.hasMatch(v)) return 'Enter a valid email';
                return null;
              }),
              const SizedBox(height: 12),
              _buildTextField(_passwordCtrl, 'Password', obscure: true,
                  validator: (v) {
                if (v == null || v.isEmpty) return 'Password required';
                if (v.length < 6)
                  return 'Password must be at least 6 characters';
                return null;
              }),
              const SizedBox(height: 12),

              // Role dropdown
              DropdownButtonFormField<String>(
                value: _role,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                items: _roles
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (v) => setState(() => _role = v),
                validator: (v) => v == null ? 'Please select a role' : null,
              ),
              const SizedBox(height: 12),

              // Gender
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ['male', 'female', 'other']
                    .map((g) => RadioListTile(
                          value: g,
                          groupValue: _gender,
                          title: Text(g[0].toUpperCase() + g.substring(1)),
                          onChanged: (v) => setState(() => _gender = v!),
                        ))
                    .toList(),
              ),

              // Hobbies
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ['Reading', 'Travelling', 'Cooking']
                    .map((h) => CheckboxListTile(
                          value: _hobbies.contains(h),
                          title: Text(h),
                          onChanged: (v) => _toggleHobby(h, v!),
                        ))
                    .toList(),
              ),

              // Subscribe
              SwitchListTile(
                  title: const Text('Subscribe'),
                  value: _subscribe,
                  onChanged: (v) => setState(() => _subscribe = v)),

              // Satisfaction slider
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Satisfaction'),
                  Slider(
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: _satisfaction.toStringAsFixed(1),
                    value: _satisfaction,
                    onChanged: (v) => setState(() => _satisfaction = v),
                  ),
                ],
              ),

              // Date picker
              OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today),
                label: Text(_formatDate(_date)),
              ),
              const SizedBox(height: 12),
              _buildTextField(_notesCtrl, 'Notes', validator: (_) => null),

              // Terms
              CheckboxListTile(
                  value: _acceptTerms,
                  title: const Text('Accept Terms & Conditions'),
                  onChanged: (v) => setState(() => _acceptTerms = v!)),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                        setState(() {
                          _role = null;
                          _gender = 'male';
                          _acceptTerms = false;
                          _subscribe = true;
                          _satisfaction = 3;
                          _date = null;
                          _hobbies.clear();
                        });
                        _nameCtrl.clear();
                        _emailCtrl.clear();
                        _passwordCtrl.clear();
                        _notesCtrl.clear();
                      },
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
