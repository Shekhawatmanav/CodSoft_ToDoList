import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {

    final String taskname;
  final bool taskcompleted;
  Function(bool?)?onChanged;
  Function(BuildContext)? deletefunction;

  TodoTile({super.key, required this.taskname,required this.taskcompleted, required this.onChanged, required this.deletefunction});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(left:25.0,right:25.0,top:25.0),
    child: Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(onPressed: deletefunction,icon: Icons.delete, backgroundColor: Colors.red,borderRadius: BorderRadius.circular(12),),
          
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.deepPurple,borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            
            //checkbox
            Checkbox(value: taskcompleted, onChanged: onChanged, activeColor: Colors.black, checkColor: Colors.white, ),
      
            //task name
            Text(taskname, style: TextStyle(decoration: taskcompleted ? TextDecoration.lineThrough : TextDecoration.none,color: Colors.white), ),
          ],
        ),
      ),
    ),
    );
  }
}