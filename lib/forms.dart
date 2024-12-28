import 'package:flutter/material.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => FormsState();
}

class FormsState extends State<Forms> {
 final TextEditingController foodController=TextEditingController();
 final TextEditingController transportController=TextEditingController();
 final TextEditingController entertainmentController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
            _buildBudgetCard('Food',Colors.redAccent,foodController),
            const SizedBox(height: 20),
            _buildBudgetCard('Transport',Colors.blue,transportController),
            const SizedBox(height: 20),
            _buildBudgetCard('Entertainment',Colors.green,entertainmentController),
            const Spacer(),
            ElevatedButton.icon(onPressed: (){
              print('Add budget pressed');
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Budget'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          
            ),
          ],
          ),),
      ),
    );
  }

Widget _buildBudgetCard(String title,Color color, TextEditingController controller){
return Center(
  child: Container(
    width: MediaQuery.of(context).size.width * 0.8,
    
    padding: const EdgeInsets.all(16),
    decoration:BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Text(
          title,
          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Enter your budget',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
           ),
           const SizedBox(height: 16),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                print('$title budget saved: ${controller.text}');
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: const Text('Save'),
              ),
              ElevatedButton(onPressed: (){
                print('$title budget updated: ${controller.text}');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
               child: const Text('Update'),
               ),
            ],
           )
      ],
    ),
  ),
);

}

 @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    foodController.dispose();
    transportController.dispose();
    entertainmentController.dispose();
    super.dispose();
  }
}

