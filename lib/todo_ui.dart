//import 'package:advanced_todo/todo_model.dart';
import 'dart:developer';

import 'package:advance_todo_sqflite/todo_database.dart';
import 'package:advance_todo_sqflite/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TodoAppUi extends StatefulWidget {
  const TodoAppUi({super.key});

  @override
  State createState() => _TodoAppUiState();
}

class _TodoAppUiState extends State {
  @override
  void initState(){
    super.initState();
    getdata();

  }
  void getdata()async{
    List<Map> cardlist= await  TodoAppDatabase().getTodoItem();
    log("Card list:$cardlist ");
    for(var element in cardlist){
      todocards.add(
        TodoModel(
          title: element["title"],
           date: element["date"], 
           description: element["description"],
           id: element["id"],
           ),
      );
    }
    setState(() { });
  }


  List<TodoModel> todocards=[
// TodoModel(title: "Flutter", date: "12 sep 2025", description: "Sqflite,State management")

  ];
  void clearcontroller(){
    titleEditingController.clear();
    descrittionEditingController.clear();
    dateEditingController.clear();
  }
  


    
   
      TextEditingController titleEditingController =TextEditingController();
      TextEditingController descrittionEditingController =TextEditingController();
      TextEditingController dateEditingController =TextEditingController();
    List<Color> colorlist=[
      Color.fromRGBO(250, 232, 232, 1),
      Color.fromRGBO(232, 237, 250, 1),
      Color.fromRGBO(250, 249, 232, 1),
      Color.fromRGBO(250, 232, 250, 1),
    ];



    void submit(bool doedit,[TodoModel? obj]){
      if(titleEditingController.text.isNotEmpty&& descrittionEditingController.text.isNotEmpty&& dateEditingController.text.isNotEmpty)
      {
        if(doedit){
          obj!.title=titleEditingController.text;
          obj.description=descrittionEditingController.text;
          obj.date=dateEditingController.text;

          // ha map updated value ni bharlela asnar hya madhe updated value asnar
          // mg to database madhe pn update honar ani tya cards madhe pn update honar
          Map <String ,dynamic> mapobj={
            "title":obj.title,
            "description":obj.description,
            "date":obj.date,
            "id":obj.id

          };
          TodoAppDatabase().updateTodoItem(mapobj);
        }
        else{
          todocards.add(TodoModel
          (title: titleEditingController.text,
           date: dateEditingController.text,
            description:descrittionEditingController.text,
            ),

            );

            // map thorough apan database madhe data add karnar ahe adhi  data cards madhe add honar nantr to
            // database madhe add honar map chya format madhe

            Map<String,dynamic> datamap={
              "title":titleEditingController.text,
              "description":descrittionEditingController.text,
              "date":dateEditingController.text
            };

            TodoAppDatabase().insertTodoItem(datamap);
        }
         

      }
      
    }



    

  void showmybottomsheet(bool doedit,[TodoModel? obj]){
    showModalBottomSheet(context: context,
     builder: (BuildContext context){
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: 
              Text("Create To Do",style: GoogleFonts.quicksand(fontSize: 22,fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: 8,),
             Text("Title",style: GoogleFonts.quicksand(fontSize: 18,color: Color.fromRGBO(0, 139, 148, 1)),),
              SizedBox(height: 6,),
              TextField(
                controller: titleEditingController,
                
        
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:"Enter Title",
                  hoverColor: Colors.cyan
                ),
              ),
              SizedBox(height: 10,),
           Text("Description",style: GoogleFonts.quicksand(fontSize: 18,color: Color.fromRGBO(0, 139, 148, 1)),),             SizedBox(height: 7,),
              TextField(
                controller: descrittionEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:"Enter Description",
                  hoverColor: Colors.cyan
                  
                ),
                
              ),
              SizedBox(height: 10,),
            Text("Date",style: GoogleFonts.quicksand(fontSize: 18,color: Color.fromRGBO(0, 139, 148, 1)),),            SizedBox(height: 7,),
              TextField(
                controller: dateEditingController,
                
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText:"Select Date",
                  hoverColor: Colors.cyan,
                  suffixIcon: 
                  GestureDetector(
                    onTap: () async{
                      DateTime? pickeddate = await showDatePicker(context: context, 
                      firstDate: DateTime(2025), lastDate: DateTime(2027)
                      );
                      dateEditingController.text=DateFormat.yMMMd().format(pickeddate!);
                      
                    },
                    child: Icon(Icons.calendar_month))
                ),
              ),
               SizedBox(height: 8,),
              Center(
                child: SizedBox(
                  width: 200,
                  
                  child: 
                   ElevatedButton(onPressed: (){
                      if(doedit){
                        // calling for editing old cards
                        submit(doedit,obj);
                            
                      }
                      else
                      {
                        //add new cards
                        submit(doedit);
                      }
                            
                            
                    
                       clearcontroller();
                       Navigator.of(context).pop();
                      setState(() {
                        
                      });
                            
                    }, 
                    
                     style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll
                      (Color.fromRGBO(0, 139, 148, 1))),
                     child:
                    
                     Text("Submit",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Color.fromRGBO(255, 255, 255, 1)),),
                     ),
                  ),
              ),
              
              SizedBox(height: 15,),
              
           
            ],
            
          ),
      );
        
     }
     );
  }
  @override
  Widget build(BuildContext context) {

    
    
    return Scaffold(
      
      
      appBar: AppBar(
        title: Text(
          "To-do List",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(2, 167, 177, 1),
        titleSpacing: 50,
        
        //leading: Image.asset("assets/todoleadingimage.jpg",height: 32,width: 32,),
      ),
      body: ListView.builder(
        itemCount: todocards.length,
        itemBuilder: (BuildContext context, int index) {
          return 
          Padding(
            padding:  EdgeInsets.all(11),
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colorlist[index % colorlist.length],
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          
                          child: 
                         Image.asset("assets/todoimage.jpg",height: 50,width: 70)
                         // Image.network("https://static.vecteezy.com/system/resources/previews/003/529/153/non_2x/business-to-do-list-flat-icon-modern-style-vector.jpg",height: 50,width: 70,),
                        ),



                       
                        SizedBox(width: 7,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              Text(todocards[index].title,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1)),),
                              SizedBox(height: 5,),
                              Text(todocards[index].description,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Color.fromRGBO(84, 84, 84, 1)),),
                              SizedBox(height: 10,),
                          
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(todocards[index].date,style: TextStyle(fontSize: 15,color: Colors.black),),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            titleEditingController.text=todocards[index].title;
                            dateEditingController.text=todocards[index].date;
                            descrittionEditingController.text=todocards[index].description;
                            showmybottomsheet(true,todocards[index]);
                            setState(() {
                              
                            });
                          },
                          child: Icon(Icons.edit,color: Color.fromRGBO(0, 139, 148, 1),size: 25,)),
                        SizedBox(width: 7,),
                        GestureDetector
                        (child: 
                        Icon(Icons.delete_outlined,color: Color.fromRGBO(0, 139, 148, 1),size: 25,),
                        onTap: (){
                          int id=todocards[index].id;
                          todocards.removeAt(index);
                          TodoAppDatabase().deletetodoItem(id);
                          setState(() {
                            
                          });
                        },),

                      ],
                    )
                  ],
                ),
              ),
               ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showmybottomsheet(false);
          setState(() {
            
          });
        },
      child: 
      Icon(Icons.add,),),
    );
  }
}
