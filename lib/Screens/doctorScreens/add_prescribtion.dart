import 'package:eeg_app/Custom%20Widget/button2.dart';
import 'package:flutter/material.dart';

class AddPrescribtion extends StatefulWidget {
  const AddPrescribtion({super.key});

  @override
  State<AddPrescribtion> createState() => _AddPrescribtionState();
}

class _AddPrescribtionState extends State<AddPrescribtion> {
  TextEditingController _presController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Prescribtion'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Doctor's Note",style: TextStyle(fontSize: 20),),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _presController,
                  scrollPadding: const EdgeInsets.all(20),
                  maxLines: 20, // This allows the input to span multiple lines
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Write prescribtion here!',
                    //border: OutlineInputBorder(),
                    hintText: 'Your prescribtion here',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Center(child: Button2(text: "Add Prescribtion", onTap: (){
                
              }))
            ],
          ),
        ),
      ),
    );
  }
}
