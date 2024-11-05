import 'package:demo_firebase/UI/auth/login_screen.dart';
import 'package:demo_firebase/UI/posts/add_post.dart';
import 'package:demo_firebase/screen/ticket_details_page.dart';
import 'package:demo_firebase/utlis/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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

  Map<String, double> dataMap = {
    "Pending": 5,
    "In Progress": 3,
    "Closed": 2,
    "Hold": 2,
  };
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context);
      },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Dashboard"),
            actions: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPostScreen()));
              }, icon: const Icon(Icons.add, size: 28, color: Colors.green,)),
              const SizedBox(width: 18,),
              IconButton(onPressed: (){
                _showLogoutConfirmationDialog(context);
              }, icon: const Icon(Icons.login_outlined)),
              const SizedBox(width: 15,)
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 21.0, right: 21.0),
                child: TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: "Search By Customer Name ",
                    border: OutlineInputBorder()
                  ),
                  onChanged: (String value){
                    setState(() {

                    });
                  },
                ),
              ),
              // Expanded(
              //     child: StreamBuilder(
              //         stream: ref.onValue,
              //         builder: (context.AsyncSnapshot<DatabaseEvent> snapshot) {
              //           if(!snapshot.hasData){
              //             return const CircularProgressIndicator();
              //           }
              //           else {
              //
              //           }
              //         })),
              SizedBox(
                height: 200,
                  child: PieChart(dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 800),)),
             Expanded(
               child: FirebaseAnimatedList(
                 defaultChild: const Center(child: Text("Loading...", style: TextStyle(fontSize: 25),)),
                   query: ref,
                   itemBuilder: (context, snapshot, animation, index){
                     // return ListTile(
                     //   title: Text(snapshot.child('title').value.toString()),
                     //   subtitle: Text(snapshot.child('id').value.toString()),
                     // );
                     final customer = snapshot.child('Customer').value.toString();
                     final engineer = snapshot.child('Engineer').value.toString();
                     final remark = snapshot.child('Remark').value.toString();
                     if(searchController.text.isEmpty){
                       return Padding(
                         padding: const EdgeInsets.all(15.0),
                         child: Container(
                           decoration: BoxDecoration(
                               color: Colors.blueGrey,
                               borderRadius: BorderRadius.circular(15)
                           ),
                           height: 187,
                           child: InkWell(
                             onLongPress: (){
                               _showDeleteConfirmationDialog(context, snapshot.child('id').value.toString());
                               // ref.child(snapshot.child('id').value.toString()).remove();
                             },
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=> const TicketDetailsPage()));
                             },
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: Wrap(
                                     spacing: 30 ,
                                     // children: Row(
                                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text("Customer : ${snapshot.child('Customer').value.toString()}", style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),),
                                         Text("Ticket No : ${snapshot.child('id').value.toString()}", style: const TextStyle(fontSize: 16, color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),),
                                       ],
                                     ),
                                   ),

                                 Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text("Engineer : ${snapshot.child('Engineer').value.toString()}", style: const TextStyle(fontSize: 15, color: Colors.white,),),
                                       Text("Address  : ${snapshot.child('Address').value.toString()}", style: const TextStyle(fontSize: 15, color: Colors.white,),),

                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("Mobile     : ${snapshot.child('Mobile').value.toString()}", style: const TextStyle(fontSize: 15, color: Colors.white,),),
                                           Text("Status : ${snapshot.child('Status').value.toString()}", style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),),

                                         ],
                                       ),

                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text("Remarks  : ${snapshot.child('Remark').value.toString()}", style: const TextStyle(fontSize: 15, color: Colors.white, ),),
                                           PopupMenuButton(
                                             icon: const Icon(Icons.more_vert,),
                                               itemBuilder: (context)=>[
                                                 PopupMenuItem(
                                                   value:1,
                                                     child: ListTile(
                                                       onTap: (){
                                                         Navigator.pop(context);
                                                         editTicketPage(customer,engineer,remark,snapshot.child('id').value.toString());
                                                       },
                                                      leading: const Icon(Icons.edit),
                                                      trailing: const Text('Edit'),
                                                 )),
                                                 PopupMenuItem(
                                                     child: ListTile(
                                                       onTap: (){
                                                         _showDeleteConfirmationDialog(context, snapshot.child('id').value.toString());
                                                         // Navigator.pop(context);
                                                         // ref.child(snapshot.child('id').value.toString()).remove();
                                                       },
                                                     leading: const Icon(Icons.delete),
                                                     trailing: const Text('Delete'),
                                                 ))

                                               ])
                                         ],
                                       )
                                     ],
                                   ),
                                 )
                               ],
                             ),
                           ),
                         ),
                       );
                     } else if(customer.toLowerCase().contains(searchController.text.toLowerCase().toLowerCase())){
                       return Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Container(
                           decoration: BoxDecoration(
                               color: Colors.blueGrey,
                               borderRadius: BorderRadius.circular(15)
                           ),
                           height: 170,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text("Customer : ${snapshot.child('Customer').value.toString()}", style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),),
                                     Text("Ticket No : ${snapshot.child('id').value.toString()}", style: const TextStyle(fontSize: 16, color: Colors.deepOrangeAccent, fontWeight: FontWeight.bold),),
                                   ],
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.all(10.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text("Engineer : ${snapshot.child('Engineer').value.toString()}", style: const TextStyle(fontSize: 15, color: Colors.white,),),
                                     Text("Address  : ${snapshot.child('Address').value.toString()}", style: const TextStyle(fontSize: 15, color: Colors.white,),),
                                     Text("Mobile     : ${snapshot.child('Mobile').value.toString()}", style: const TextStyle(fontSize: 15, color: Colors.white,),),
                                     Text("Remarks  : ${snapshot.child('Remark').value.toString()}", style: const TextStyle(fontSize: 15, color: Colors.white, ),),

                                   ],
                                 ),
                               )

                             ],
                           ),
                         ),
                       );
                     }else{
                       return Container();
                     }

                   }),
             )

            ],
          ),
          // floatingActionButton: Container(
          //   height: 50,
          //   decoration: BoxDecoration(
          //       color: Colors.green,
          //     borderRadius: BorderRadius.circular(15)
          //   ),
          //   child: TextButton(onPressed: (){
          //     Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPostScreen()));
          //   },
          //     child: const Text("Create Ticket", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
          //   ),
          // ),
        ),
    );
  }

  // Future<void> editPage()async{
  //   return ()
  // }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, String postId) async {
    bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete?', style: TextStyle(fontSize: 17)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User does not want to delete
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User wants to delete
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    // If user confirms deletion, delete the post
    if (shouldDelete == true) {
      _deletePost(postId);
    }
  }

  Future<void> _deletePost(String postId) async {
    try {
      await ref.child(postId).remove();
      Utlis().toastMessage("Post Deleted");
    } catch (e) {
      Utlis().toastMessage("Error deleting post: $e");
    }
  }


  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?', style: TextStyle(fontSize: 17),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User does not want to logout
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User wants to logout
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    // If user confirms, log them out
    if (shouldLogout == true) {
      auth.signOut().then((value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
        );
      }).onError((error, stackTrace) {
        Utlis().toastMessage(error.toString());
      });
    }
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Exit'),
          content: const Text('Are you sure you want to exit?', style: TextStyle(fontSize: 17),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User does not want to exit
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User wants to exit
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false); // Return false if the dialog is dismissed without a selection
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
            height: 249, // Set the desired height here
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
                  Utlis().toastMessage("Post Updated");
                }).onError((error, stackTrace) {
                  Utlis().toastMessage(error.toString());
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



