
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomYearPicker extends StatelessWidget {
  const CustomYearPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Select Year"),
            content: SizedBox(
              width: 300,
              height: 300,
              child: YearPicker(
                firstDate: DateTime(DateTime.now().year),
                lastDate:
                DateTime(DateTime.now().year + 10),
                selectedDate: DateTime.now(),
                onChanged: (value) {
                  context.pop();
                },
              ),
            ),
          );
        },
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<
            RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
        minimumSize: MaterialStateProperty.all(
          const Size.fromHeight(60),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Icon(Icons.calendar_month),
            const SizedBox(width: 10),
            Text(
                "Graduation Year : ${DateTime.now().year}"),
          ],
        ),
      ),
    );
  }
}
