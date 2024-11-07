import 'package:flutter/material.dart';

class TicketDetailsPage extends StatefulWidget {
  const TicketDetailsPage({super.key});

  @override
  State<TicketDetailsPage> createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("Store Name : ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold ),),
                     Text("Mobile No : "),
                     Text("Engineer Assign : "),
                   ]
             )
                   ),
           ),
          Container(
            child: Column(
              children: [

              ],
            ),
          )
        ],
      ),
    );
  }
}
