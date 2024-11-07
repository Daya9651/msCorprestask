import 'package:demo_firebase/utlis/utils.dart';
import 'package:demo_firebase/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  // final List<String> customers;
  const AddPostScreen({super.key,});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key
  bool loading = false;
  // final String ?customers;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final postController = TextEditingController();
  final nameController = TextEditingController();
  final engineerController = TextEditingController();
  final addController = TextEditingController();
  final remarkController = TextEditingController();
  final mobileController = TextEditingController();
  String? selectedStatus;
  final List<String> statusOptions = ['Pending', 'In Progress', 'Closed', 'Hold'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form( // Wrap the Column in a Form
            key: _formKey, // Assign the form key
            child: Column(
              children: [
                const SizedBox(height: 2),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Customer's Name",
                      border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Customer Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: engineerController,
                  decoration: const InputDecoration(
                      hintText: "Engineer's Name",
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: addController,
                  decoration: const InputDecoration(
                      hintText: "Address",
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  maxLines: 2,
                  controller: remarkController,
                  decoration: const InputDecoration(
                      hintText: 'Add Remark',
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  controller: mobileController,
                  decoration: const InputDecoration(
                      hintText: 'Customer Mobile',
                      prefixText: '+91 ',
                      border: OutlineInputBorder(
                      ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Customer Number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5,),

                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  decoration: const InputDecoration(
                    hintText: 'Select Status',
                    // labelText: 'Post Status',
                    border: OutlineInputBorder(),
                  ),
                  items: statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedStatus = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a status';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 7),
                RoundButton(
                  title: 'Add',
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      String id = DateTime.now().millisecondsSinceEpoch.toString();
                      databaseRef.child(id).set({
                        'Customer': nameController.text.toString(),
                        'Engineer': engineerController.text.toString(),
                        'Address': addController.text.toString(),
                        'Remark': remarkController.text.toString(),
                        'Mobile': mobileController.text.toString(),
                        'Status': selectedStatus,
                        'id': id
                      }).then((value) {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()));
                        Utils.showSnackbar(context, 'Post added');
                        setState(() {
                          loading = false;
                        });
                      }).onError((error, stackTrace) {
                        Utils.showSnackbar(context, error.toString());
                        setState(() {
                          loading = false;
                        });
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
