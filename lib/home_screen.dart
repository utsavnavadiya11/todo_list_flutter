import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/controller/todo_controller.dart';
import 'package:todo_getx/model/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoController controller = Get.put(TodoController());

  late TextEditingController titleController;
  late GlobalKey<FormState> formKey;
  late AutovalidateMode titlevalidate;

  @override
  void initState() {
    super.initState();
    controller.readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo Getx'),
        backgroundColor: const Color(0xff8687E7),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Completed'),
                    GetBuilder<TodoController>(
                        builder: (controller) =>
                            Text(controller.getCompletedTask().toString())),
                  ],
                ),
                Column(
                  children: [
                    const Text('Remaining'),
                    GetBuilder<TodoController>(
                        builder: (controller) => Text((controller.todos.length -
                                controller.getCompletedTask())
                            .toString())),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Flexible(
              child: GetBuilder<TodoController>(
                builder: (_) => controller.todos.isEmpty
                    ? const Center(
                        child: Text('Noting here, try Adding..'),
                      )
                    : controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text('Remaining'),
                                controller.remainingTodos.isNotEmpty
                                    ? ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            Dismissible(
                                          key: UniqueKey(),
                                          onDismissed: (direction) =>
                                              controller.delete(controller
                                                  .remainingTodos[index].id),
                                          confirmDismiss: (direction) =>
                                              showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title:
                                                  const Text('Are You Sure?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: const Text('Yes'))
                                              ],
                                            ),
                                          ),
                                          background: Container(
                                            color: Colors.red,
                                            alignment: Alignment.centerRight,
                                            child: const Icon(Icons.delete),
                                          ),
                                          child: ListTile(
                                            leading: Checkbox(
                                              activeColor:
                                                  const Color(0xff8687E7),
                                              value: controller
                                                  .remainingTodos[index]
                                                  .isCompleted,
                                              onChanged: (value) {
                                                controller.updateisCompleted(
                                                    controller
                                                        .remainingTodos[index]
                                                        .id,
                                                    value!);
                                              },
                                            ),
                                            title: Text(controller
                                                .remainingTodos[index].title),
                                            trailing: IconButton(
                                              //Updating data
                                              onPressed: () => updateData(
                                                  controller
                                                      .remainingTodos[index].id,
                                                  controller),
                                              icon: const Icon(Icons.edit),
                                            ),
                                          ),
                                        ),
                                        itemCount:
                                            controller.remainingTodos.length,
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                          'Hurrah! Nothing Remaining',
                                          style: TextStyle(
                                              color: Color(0xff8687E7),
                                              fontSize: 15.0),
                                        ),
                                      ),
                                //Completed List
                                const Text('Completed'),
                                controller.completedTodos.isNotEmpty
                                    ? ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            Dismissible(
                                          key: UniqueKey(),
                                          onDismissed: (direction) =>
                                              controller.delete(controller
                                                  .completedTodos[index].id),
                                          confirmDismiss: (direction) =>
                                              showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title:
                                                  const Text('Are You Sure?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: const Text('Yes'))
                                              ],
                                            ),
                                          ),
                                          background: Container(
                                            color: Colors.red,
                                            alignment: Alignment.centerRight,
                                            child: const Icon(Icons.delete),
                                          ),
                                          child: ListTile(
                                            leading: Checkbox(
                                              activeColor:
                                                  const Color(0xff8687E7),
                                              value: controller
                                                  .completedTodos[index]
                                                  .isCompleted,
                                              onChanged: (value) {
                                                controller.updateisCompleted(
                                                    controller
                                                        .completedTodos[index]
                                                        .id,
                                                    value!);
                                              },
                                            ),
                                            title: Text(controller
                                                .completedTodos[index].title),
                                            trailing: IconButton(
                                              //Updating data
                                              onPressed: () => updateData(
                                                  controller
                                                      .completedTodos[index].id,
                                                  controller),
                                              icon: const Icon(Icons.edit),
                                            ),
                                          ),
                                        ),
                                        itemCount:
                                            controller.completedTodos.length,
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                          'Ohh! Nothing Done',
                                          style: TextStyle(
                                              color: Color(0xff8687E7),
                                              fontSize: 15.0),
                                        ),
                                      ),
                              ],
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
      //Bottom sheet to add todo
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff8687E7),
        onPressed: () {
          //initializing variables
          titleController = TextEditingController();
          formKey = GlobalKey<FormState>();
          titlevalidate = AutovalidateMode.disabled;

          Get.bottomSheet(
            StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Container(
                  height: 200.0,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0)),
                      color: Color(0xff8687E7)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Form(
                          key: formKey,
                          child: TextFormField(
                            autovalidateMode: titlevalidate,
                            controller: titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Title";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10.0),
                              label: Text('Enter Title'),
                              labelStyle: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              titlevalidate = AutovalidateMode.always;
                              setState(() {});
                              if (formKey.currentState!.validate()) {
                                titlevalidate = AutovalidateMode.disabled;
                                setState(() {});
                                controller.add(
                                  TodoModel(
                                      id: DateTime.now().toString(),
                                      title: titleController.text),
                                );
                                titleController.clear();
                                Get.back();
                              }
                            },
                            icon: const Icon(Icons.send, color: Colors.white))
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void updateData(String id, TodoController controller) {
    TextEditingController titleEditingController = TextEditingController();
    AutovalidateMode editValidator = AutovalidateMode.always;
    GlobalKey<FormState> editKey = GlobalKey<FormState>();

    TodoModel currentTodo = controller.getById(id);
    titleEditingController.text = currentTodo.title;
    Get.bottomSheet(
      StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Container(
            height: 200.0,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)),
                color: Color(0xff8687E7)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Form(
                    key: editKey,
                    autovalidateMode: editValidator,
                    child: TextFormField(
                      controller: titleEditingController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        label: Text('Enter Title'),
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter title";
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        
                        if (editKey.currentState!.validate()) {
                          editValidator = AutovalidateMode.disabled;
                          setState(() {});
                          controller.updateTodo(
                            TodoModel(
                                id: currentTodo.id,
                                title: titleEditingController.text,
                                isCompleted: currentTodo.isCompleted),
                          );
                          titleEditingController.text = '';
                          Get.back();
                        }
                        
                      },
                      icon: const Icon(Icons.send, color: Colors.white))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
