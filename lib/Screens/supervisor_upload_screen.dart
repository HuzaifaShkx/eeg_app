import 'package:eeg_app/Custom%20Widget/button1.dart';
import 'package:eeg_app/Custom%20Widget/color.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'supervisor_provider.dart';

class SupervisorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supervisor'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(context, 'Patient', 'Select Patient', (String value) {
             // Provider.of<SupervisorProvider>(context, listen: false).selectPatient(value);
            }),
            SizedBox(height: 16),
            _buildDropdown(context, 'Select Video', 'Select Video', (String value) {
              //Provider.of<SupervisorProvider>(context, listen: false).selectVideo(value);
            }),
            SizedBox(height: 24),
            Center(child: Button1(text: "Start", onTap: (){})),
            SizedBox(height: 32),
            _buildAttachRow(context, 'Attach EEG', Icons.add_box),
            SizedBox(height: 16),
            _buildAttachRow(context, 'Attach Captured Video', Icons.add_box),
            SizedBox(height: 32),
            Center(child: Button1(text: "Submit", onTap: (){})),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(BuildContext context, String label, String hint, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary)),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          hint: Text(hint),
          onChanged: (s){},
          items: [
            DropdownMenuItem(child: Text('Patient 1'), value: 'patient1'),
            DropdownMenuItem(child: Text('Patient 2'), value: 'patient2'),
          ],
        ),
      ],
    );
  }

  Widget _buildAttachRow(BuildContext context, String label, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primary)),
        IconButton(
          icon: Icon(icon, color: primary),
          onPressed: () {
            // Handle attach action
          },
        ),
      ],
    );
  }
}
