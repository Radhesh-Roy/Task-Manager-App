import 'package:flutter/material.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/data/service/api_caller.dart';
import 'package:task_manager/utils/urls.dart';
import 'package:task_manager/widget/snackbar.dart';

class CustomTaskCard extends StatefulWidget {
  final TaskModel taskModel;
  final Color statusColor;
  final VoidCallback refreshParent;

  const CustomTaskCard({
    super.key,
    required this.taskModel,
    required this.statusColor,
    required this.refreshParent,
  });

  @override
  State<CustomTaskCard> createState() => _CustomTaskCardState();
}

class _CustomTaskCardState extends State<CustomTaskCard> {
  Future<void> deleteTask() async {
    final response = await ApiCaller().getRequest(
      URL: TMUrls.deleteTask(widget.taskModel.sId.toString()),
    );

    if (response.isSuccess) {
      widget.refreshParent();
      showSnackbar(context, "Task deleted successfully.");
      setState(() {
      });
    } else {
      showSnackbar(
        context,
        response.responseData["message"] ?? "Delete failed",
      );
    }
  }

  Future<void> changeStatus(String status) async {
    final response = await ApiCaller().getRequest(
      URL: TMUrls.updateTask(
        widget.taskModel.sId.toString(),
        status,
      ),
    );

    if (response.isSuccess) {
      Navigator.pop(context);
      widget.refreshParent();
      showSnackbar(context, "Task updated successfully.");
    } else {
      showSnackbar(
        context,
        response.responseData["message"] ?? "Update failed",
      );
    }
  }

  void showChangeStatusDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Change Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildStatusItem("New"),
              buildStatusItem("Progress"),
              buildStatusItem("Completed"),
              buildStatusItem("Cancelled"),
            ],
          ),
        );
      },
    );
  }

  Widget buildStatusItem(String status) {
    return Card(
      child: ListTile(
        title: Text(status),
        trailing: widget.taskModel.status == status
            ? const Icon(
          Icons.check_circle,
          color: Colors.green,
        )
            : null,
        onTap: () {
          changeStatus(status);
          setState(() {
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            widget.taskModel.title ?? "",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(
                widget.taskModel.description ?? "",
              ),
              const SizedBox(height: 6),
              Text(
                "Date: ${widget.taskModel.createdDate}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    label: Text(
                      widget.taskModel.status ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: widget.statusColor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(25),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: showChangeStatusDialog,
                    icon: const Icon(
                      Icons.edit_note,
                      color: Colors.orange,
                    ),
                  ),
                  IconButton(
                    onPressed: deleteTask,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}