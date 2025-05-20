import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TaskProgressBar extends StatelessWidget {
  final int totalTasks;
  final int completedTasks;

  const TaskProgressBar({
    super.key,
    required this.totalTasks,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    double percent = totalTasks == 0 ? 0 : completedTasks / totalTasks;
    int progressPercent = (percent * 100).round();

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: LinearPercentIndicator(
        barRadius: const Radius.circular(18),
        width: 200.0,
        animation: true,
        animationDuration: 1000,
        lineHeight: 40.0,
        leading: Text("$completedTasks Done"),
        trailing: Text("${totalTasks - completedTasks} Left"),
        percent: percent.clamp(0.0, 1.0),
        center: Text("$progressPercent%"),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: const Color.fromARGB(255, 231, 50, 50),
        backgroundColor: Colors.grey.shade300,
      ),
    );
  }
}
