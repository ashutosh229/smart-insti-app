import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_insti_app/models/achievement.dart';
import 'package:smart_insti_app/models/student.dart';
import 'package:smart_insti_app/provider/auth_provider.dart';
import 'edit_profile.dart';
import 'package:smart_insti_app/constants/dummy_entries.dart';

class StudentProfile extends ConsumerWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider);

    final currentStudent = auth.currentUser as Student?;

    if (currentStudent == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Student Profile'),
        ),
        body: Center(
          child: Text('No student data available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightBlueAccent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: currentStudent.profilePicURI != null
                      ? NetworkImage(currentStudent.profilePicURI!)
                      : const AssetImage('assets/openlake.png')
                          as ImageProvider<Object>,
                  radius: 55,
                  child: currentStudent.profilePicURI == null
                      ? const Icon(
                          Icons.person,
                          size: 55,
                          color: Colors.grey,
                        )
                      : null,
                ),
                const SizedBox(height: 8),
                Text(
                  currentStudent.name ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5,
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.6,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildInfoRow("ID", currentStudent.rollNumber ?? ''),
                            buildInfoRow("Email", currentStudent.email ?? ''),
                            buildInfoRow("Branch", currentStudent.branch ?? ''),
                            buildInfoRow(
                              "Class of",
                              "${currentStudent.graduationYear}" ?? '',
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'About:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(currentStudent.about ?? 'No information'),
                            const SizedBox(height: 5),
                            const Text(
                              'Roles: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${currentStudent.roles?.join(", ") ?? "No roles"}',
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Skills:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (currentStudent.skills != null)
                              Column(
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: currentStudent.skills!
                                          .map(
                                            (skill) => SizedBox(
                                              width: 105,
                                              height: 80,
                                              child: PieChart(
                                                PieChartData(
                                                  sections: [
                                                    PieChartSectionData(
                                                      value: skill.level
                                                          .toDouble(),
                                                      title: skill.name ?? '',
                                                      color: getRandomColor(),
                                                    ),
                                                    PieChartSectionData(
                                                      value: (100 - skill.level)
                                                          .toDouble(),
                                                      title: '',
                                                      color: Color.fromARGB(
                                                          255, 184, 212, 240),
                                                    ),
                                                  ],
                                                  sectionsSpace: 0,
                                                  centerSpaceRadius: 0,
                                                  borderData: FlBorderData(
                                                    show: false,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Slider(
                                    value: 10,
                                    onChanged: (double value) {},
                                    min: 0,
                                    max: 100,
                                  ),
                                ],
                              ),
                            const SizedBox(height: 5),
                            const Text(
                              'Achievements:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: currentStudent.achievements
                                        ?.map(
                                          (achievement) => SizedBox(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    48 -
                                                    40) /
                                                2,
                                            child: buildAchievementCard(
                                                achievement),
                                          ),
                                        )
                                        .toList() ??
                                    [],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Slider(
                              value: 10,
                              onChanged: (double value) {},
                              min: 0,
                              max: 100,
                              divisions: 5,
                              label: 'Achievement Slider',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    );
  }

  Widget buildAchievementCard(Achievement achievement) {
    return Card(
      color: Colors.lightBlue,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              achievement.name ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            Text(
              'Date: ${achievement.date}',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              achievement.description ?? '',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Color getRandomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
}
