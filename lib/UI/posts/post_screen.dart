import 'package:demo_firebase/UI/auth/login_screen.dart';
import 'package:demo_firebase/UI/posts/add_post.dart';
import 'package:demo_firebase/screen/ticket_details_page.dart';
import 'package:demo_firebase/utlis/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'controller/dashboard_controller.dart'; // Import the new file

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchController = TextEditingController();
  final editTicketController = TextEditingController();
  final engineerController = TextEditingController();
  final remarkController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showExitConfirmationDialog(context) ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Dashboard"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPostScreen()),
                );
              },
              icon: const Icon(Icons.add, size: 28, color: Colors.green),
            ),
            const SizedBox(width: 18),
            IconButton(
              onPressed: () {
                showLogoutConfirmationDialog(context).then((value) {
                  if (value == true) {
                    auth.signOut().then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    }).catchError((error) {
                      Utils.showSnackbar(context, error.toString());
                    });
                  }
                });
              },
              icon: const Icon(Icons.login_outlined),
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: "Search By Customer Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
            ),
            SizedBox(
              height: 200,
              child: PieChart(
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                defaultChild: const Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  final customer = snapshot.child('Customer').value.toString();
                  if (searchController.text.isEmpty ||
                      customer.toLowerCase().contains(searchController.text.toLowerCase())) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: 187,
                        child: InkWell(
                          onLongPress: () {
                            showDeleteConfirmationDialog(context).then((value) {
                              if (value == true) {
                                _deletePost(snapshot.child('id').value.toString());
                              }
                            });
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const TicketDetailsPage()),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Wrap(
                                  spacing: 30,
                                  children: [
                                    Text(
                                      "Customer : ${snapshot.child('Customer').value.toString()}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Ticket No : ${snapshot.child('id').value.toString()}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.deepOrangeAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Engineer : ${snapshot.child('Engineer').value.toString()}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Address  : ${snapshot.child('Address').value.toString()}",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Mobile     : ${snapshot.child('Mobile').value.toString()}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Status : ${snapshot.child('Status').value.toString()}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Remarks  : ${snapshot.child('Remark').value.toString()}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        PopupMenuButton(
                                          icon: const Icon(Icons.more_vert),
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 1,
                                              child: ListTile(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  editTicketPage(
                                                    customer,
                                                    snapshot.child('Engineer').value.toString(),
                                                    snapshot.child('Remark').value.toString(),
                                                    snapshot.child('id').value.toString(),
                                                  );
                                                },
                                                leading: const Icon(Icons.edit),
                                                trailing: const Text('Edit'),
                                              ),
                                            ),
                                            PopupMenuItem(
                                              child: ListTile(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  showDeleteConfirmationDialog(context).then((value) {
                                                    if (value == true) {
                                                      _deletePost(snapshot.child('id').value.toString());
                                                    }
                                                  });
                                                },
                                                leading: const Icon(Icons.delete),
                                                trailing: const Text('Delete'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deletePost(String id) {
    try {
      ref.child(id).remove();
      Utils.showSnackbar(context, 'Post deleted successfully');
    } catch (e) {
      Utils.showSnackbar(context, e.toString());
    }
  }

  Future<void> editTicketPage(String customer, String engineer, String remark, String id) async {
    editTicketController.text = customer;
    engineerController.text = engineer;
    remarkController.text = remark;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text('Update')),
          content: SizedBox(
            width: 300, // Set the desired width here
            height: 270, // Set the desired height here
            child: Column(
              // mainAxisSize: MainAxisSize.,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Customer", style: TextStyle(fontSize: 19),),
                TextField(
                  controller: editTicketController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'Customer', // Add a label text for clarity
                  ),
                ),
                const SizedBox(height: 7),
                const Text("Engineer", style: TextStyle(fontSize: 19),),
                TextField(
                  controller: engineerController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'Engineer', // Add a label text for clarity
                  ),
                ),
                const SizedBox(height: 7),
                const Text("Remark", style: TextStyle(fontSize: 19),),
                TextField(
                  // maxLines: 2,
                  controller: remarkController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    // labelText: 'Remark', // Add a label text for clarity
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref.child(id).update({
                  'Customer': editTicketController.text,
                  'Engineer': engineerController.text,
                  'Remark': remarkController.text,
                }).then((value) {
                  Utils.showSnackbar(context,"Post Updated");
                }).onError((error, stackTrace) {
                  Utils.showSnackbar(context, error.toString());
                });
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
