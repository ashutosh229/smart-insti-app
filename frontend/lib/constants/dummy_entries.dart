import '../models/achievement.dart';
import '../models/course.dart';
import '../models/faculty.dart';
import '../models/lost_and_found_item.dart';
import '../models/mess_menu.dart';
import '../models/message.dart';
import '../models/room.dart';
import '../models/skills.dart';
import '../models/student.dart';

class DummyStudents {
  static List<Student> students = [
    Student(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      rollNumber: '89890',
      about: 'I am a computer science student.',
      profilePicURI:
          'https://cdn4.sharechat.com/img_907710_35cec5f5_1681916904360_sc.jpg?tenant=sc&referrer=pwa-sharechat-service&f=360_sc.jpg',
      branch: 'Computer Science',
      graduationYear: 2023,
      skills: [DummySkills.skills[1], DummySkills.skills[2]],
      achievements: Dummyachievements.achievements.sublist(0, 5),
      roles: ['Core Member', 'Coordinator'],
    ),
    Student(
      id: '2',
      name: 'Alice Johnson',
      email: 'alice.johnson@example.com',
      rollNumber: '67890',
      about: 'I am a mechanical engineering student.',
      profilePicURI: '',
      branch: 'Mechanical Engineering',
      roles: ['Student,Class Representative'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '3',
      name: 'John Doe',
      email: 'john.doe@example.com',
      rollNumber: 'R001',
      about: 'I am a computer science student.',
      profilePicURI:
          'https://cdn4.sharechat.com/img_907710_35cec5f5_1681916904360_sc.jpg?tenant=sc&referrer=pwa-sharechat-service&f=360_sc.jpg',
      branch: 'Computer Science',
      graduationYear: 2023,
      skills: [DummySkills.skills[1], DummySkills.skills[2]],
      achievements: [
        Dummyachievements.achievements[1],
        Dummyachievements.achievements[2]
      ],
      roles: ['Core Member', 'Coordinator'],
    ),
    Student(
      id: '4',
      name: 'John Doe',
      email: 'john.doe@example.com',
      rollNumber: 'R001',
      about: 'I am a computer science student.',
      profilePicURI:
          'https://cdn4.sharechat.com/img_907710_35cec5f5_1681916904360_sc.jpg?tenant=sc&referrer=pwa-sharechat-service&f=360_sc.jpg',
      branch: 'Computer Science',
      graduationYear: 2023,
      skills: [DummySkills.skills[1], DummySkills.skills[2]],
      roles: ['Core Member', 'Coordinator'],
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '3',
      name: 'Bob Williams',
      email: 'bob.williams@example.com',
      about: 'I am an electrical engineering student.',
      profilePicURI: '',
      rollNumber: '54321',
      branch: 'Electrical Engineering',
      roles: ['Student'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '4',
      name: 'Eva Davis',
      email: 'eva.davis@example.com',
      about: 'I am a civil engineering student.',
      profilePicURI: '',
      rollNumber: '98765',
      branch: 'Civil Engineering',
      roles: ['Student,Class Representative'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '5',
      name: 'Chris Taylor',
      email: 'chris.taylor@example.com',
      about: 'I am a chemical engineering student.',
      profilePicURI: '',
      rollNumber: '13579',
      branch: 'Chemical Engineering',
      roles: ['Student'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '6',
      name: 'Grace Miller',
      email: 'grace.miller@example.com',
      about: 'I am a biotechnology student.',
      profilePicURI: '',
      rollNumber: '24680',
      branch: 'Biotechnology',
      roles: ['Student,Class Representative'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '7',
      name: 'Daniel Brown',
      email: 'daniel.brown@example.com',
      about: 'I am an aerospace engineering student.',
      profilePicURI: '',
      rollNumber: '97531',
      branch: 'Aerospace Engineering',
      roles: ['Student,Teaching Assistant'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '8',
      name: 'Sophia Wilson',
      email: 'sophia.wilson@example.com',
      about: 'I am an information technology student.',
      profilePicURI: '',
      rollNumber: '86420',
      branch: 'Information Technology',
      roles: ['Student,Teaching Assistant'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '9',
      name: 'Matthew White',
      email: 'matthew.white@example.com',
      about: 'I am a mechatronics student.',
      profilePicURI: '',
      rollNumber: '12340',
      branch: 'Mechatronics',
      roles: ['Student'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '10',
      name: 'Olivia Harris',
      email: 'olivia.harris@example.com',
      about: 'I am a robotics engineering student.',
      profilePicURI: '',
      rollNumber: '56789',
      branch: 'Robotics Engineering',
      roles: ['Student'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '11',
      name: 'William Turner',
      email: 'william.turner@example.com',
      about: 'I am an industrial engineering student.',
      profilePicURI: '',
      rollNumber: '34567',
      branch: 'Industrial Engineering',
      roles: ['Student,Teaching Assistant'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '12',
      name: 'Emma Clark',
      email: 'emma.clark@example.com',
      about: 'I am a computer engineering student.',
      profilePicURI: '',
      rollNumber: '89012',
      branch: 'Computer Engineering',
      roles: ['Student'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '13',
      name: 'Ryan Allen',
      email: 'ryan.allen@example.com',
      about: 'I am a software engineering student.',
      profilePicURI: '',
      rollNumber: '67890',
      branch: 'Software Engineering',
      roles: ['Student'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '14',
      name: 'Ava Young',
      email: 'ava.young@example.com',
      about: 'I am an environmental engineering student.',
      profilePicURI: '',
      rollNumber: '23456',
      branch: 'Environmental Engineering',
      roles: ['Student'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '15',
      name: 'Jackson Walker',
      email: 'jackson.walker@example.com',
      about: 'I am a petrolesum[ engineer]ing student.',
      profilePicURI: '',
      rollNumber: '87654',
      branch: 'Petrolesum Engineer]ing',
      roles: ['Student,Class Representative'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: Dummyachievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '16',
      name: 'Sophie Lee',
      email: 'sophie.lee@example.com',
      about: 'I am a nuclear engineering student.',
      profilePicURI: '',
      rollNumber: '54321',
      branch: 'Nuclear Engineering',
      roles: ['Student,Cultural Secretary'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: DummyAchievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '17',
      name: 'David Hall',
      email: 'david.hall@example.com',
      about: 'I am a biomedical engineering student.',
      profilePicURI: '',
      rollNumber: '10987',
      branch: 'Biomedical Engineering',
      roles: ['Student,Class Representative'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: DummyAchievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '18',
      name: 'Isabella Miller',
      email: 'isabella.miller@example.com',
      about: 'I am a chemical engineering student.',
      profilePicURI: '',
      rollNumber: '87654',
      branch: 'Chemical Engineering',
      roles: ['Student'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: DummyAchievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '19',
      name: 'Mason Baker',
      email: 'mason.baker@example.com',
      about: 'I am an electronics engineering student.',
      profilePicURI: '',
      rollNumber: '54321',
      branch: 'Electronics Engineering',
      roles: ['Student,Class Representative'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: DummyAchievements.achievements.sublist(0, 5),
    ),
    Student(
      id: '20',
      name: 'Ella Turner',
      email: 'ella.turner@example.com',
      about: 'I am a computer science student.',
      profilePicURI: '',
      rollNumber: '98765',
      branch: 'Computer Science',
      roles: ['Student,Teaching Assistant'],
      skills: DummySkills.skills.sublist(0, 5),
      achievements: DummyAchievements.achievements.sublist(0, 5),
    ),
  ];
}

class Dummyachievements {
  static List<Achievement> achievements = [
    Achievement(
        id: '1',
        name: 'Hackathon Winner',
        date: DateTime(2023, 02, 01),
        description: 'First place in XYZ Hackathon'),
    Achievement(
        id: '2',
        name: 'Hackathon Winner',
        date: DateTime(2023, 02, 01),
        description: 'First place in XYZ Hackathon'),
    Achievement(
        id: '3',
        name: 'Hackathon Winner',
        date: DateTime(2023, 02, 01),
        description: 'First place in XYZ Hackathon'),
    Achievement(
        id: '4',
        name: 'Hackathon Winner',
        date: DateTime(2023, 02, 01),
        description: 'First place in XYZ Hackathon'),
    Achievement(
        id: '5',
        name: 'Hackathon Winner',
        date: DateTime(2023, 02, 01),
        description: 'First place in XYZ Hackathon'),
    Achievement(
        id: '6',
        name: 'Hackathon Winner',
        date: DateTime(2023, 02, 01),
        description: 'First place in XYZ Hackathon'),
    Achievement(
        id: '7',
        name: 'Hackathon Winner',
        date: DateTime(2023, 02, 01),
        description: 'First place in XYZ Hackathon'),
    Achievement(
        id: '8',
        name: 'Hackathon Winner',
        date: DateTime(2023, 02, 01),
        description: 'First place in XYZ Hackathon'),
    Achievement(
        id: '9',
        name: 'Hackathon Winner',
        date: DateTime(2023, 02, 01),
        description: 'First place in XYZ Hackathon'),
    Achievement(
        id: '10',
        name: 'Hackathon Winner',
        date: DateTime(2023, 02, 01),
        description: 'First place in XYZ Hackathon')
  ];
}

class DummyCourses {
  static List<Course> courses = [
    Course(
        id: '1',
        courseCode: 'CS101',
        courseName: 'Introduction to Computer Science',
        branches: ['Computer Science'],
        credits: 3,
        primaryRoom: 'LT-1',
        professorId: DummyFaculties.faculties[0].id),
    Course(
        id: '2',
        courseCode: 'ME102',
        courseName: 'Mechanical Engineering Basics',
        branches: ['Mechanical Engineering'],
        credits: 3,
        primaryRoom: 'LT-2',
        professorId: DummyFaculties.faculties[1].id),
    Course(
        id: '3',
        courseCode: 'EE103',
        courseName: 'Electrical Engineering Fundamentals',
        branches: ['Electrical Engineering'],
        credits: 3,
        primaryRoom: 'LT-3',
        professorId: DummyFaculties.faculties[2].id),
    Course(
        id: '4',
        courseCode: 'EE104',
        courseName: 'Civil Engineering Principles',
        branches: ['Civil Engineering'],
        credits: 3,
        primaryRoom: 'LT-4',
        professorId: DummyFaculties.faculties[3].id),
    Course(
        id: '5',
        courseCode: 'CHE105',
        courseName: 'Chemical Engineering Basics',
        branches: ['Chemical Engineering'],
        credits: 3,
        primaryRoom: 'LH-1',
        professorId: DummyFaculties.faculties[4].id),
    Course(
        id: '6',
        courseCode: 'BT106',
        courseName: 'Biotechnology Fundamentals',
        branches: ['Biotechnology'],
        credits: 3,
        primaryRoom: 'LH-2',
        professorId: DummyFaculties.faculties[5].id),
    Course(
        id: '7',
        courseCode: 'AE107',
        courseName: 'Aerospace Engineering Introduction',
        branches: ['Aerospace Engineering'],
        credits: 3,
        primaryRoom: 'LH-3',
        professorId: DummyFaculties.faculties[6].id),
    Course(
        id: '8',
        courseCode: 'IT108',
        courseName: 'Information Technology Essentials',
        branches: ['Information Technology'],
        credits: 3,
        primaryRoom: 'LH-4',
        professorId: DummyFaculties.faculties[7].id),
    Course(
        id: '9',
        courseCode: 'MT109',
        courseName: 'Mechatronics Basics',
        branches: ['Mechatronics'],
        credits: 3,
        primaryRoom: 'LH-5',
        professorId: DummyFaculties.faculties[8].id),
    Course(
        id: '10',
        courseCode: 'RE110',
        courseName: 'Robotics Engineering Fundamentals',
        branches: ['Robotics Engineering'],
        credits: 3,
        primaryRoom: 'LH-6',
        professorId: DummyFaculties.faculties[9].id),
    Course(
        id: '11',
        courseCode: 'IE111',
        courseName: 'Industrial Engineering Principles',
        branches: ['Industrial Engineering'],
        credits: 3,
        primaryRoom: 'LH-7',
        professorId: DummyFaculties.faculties[10].id),
    Course(
        id: '12',
        courseCode: 'CE112',
        courseName: 'Computer Engineering Basics',
        branches: ['Computer Engineering'],
        credits: 3,
        primaryRoom: 'LH-8',
        professorId: DummyFaculties.faculties[11].id),
    Course(
        id: '13',
        courseCode: 'SE113',
        courseName: 'Software Engineering Fundamentals',
        branches: ['Software Engineering'],
        credits: 3,
        primaryRoom: 'ROOM-101',
        professorId: DummyFaculties.faculties[12].id),
    Course(
        id: '14',
        courseCode: 'EN114',
        courseName: 'Environmental Engineering Basics',
        branches: ['Environmental Engineering'],
        credits: 3,
        primaryRoom: 'ROOM-102',
        professorId: DummyFaculties.faculties[13].id),
    Course(
        id: '15',
        courseCode: 'PE115',
        courseName: 'Petrolesum[ Engineer]ing Introduction',
        branches: ['Petrolesum[ Engineer]ing'],
        credits: 3,
        primaryRoom: 'ROOM-103',
        professorId: DummyFaculties.faculties[14].id),
    Course(
        id: '16',
        courseCode: 'NE116',
        courseName: 'Nuclear Engineering Basics',
        branches: ['Nuclear Engineering'],
        credits: 3,
        primaryRoom: 'ROOM-104',
        professorId: DummyFaculties.faculties[15].id),
    Course(
        id: '17',
        courseCode: 'BE117',
        courseName: 'Biomedical Engineering Fundamentals',
        branches: ['Biomedical Engineering'],
        credits: 3,
        primaryRoom: 'ROOM-201',
        professorId: DummyFaculties.faculties[16].id),
    Course(
        id: '18',
        courseCode: 'CE118',
        courseName: 'Chemical Engineering Principles',
        branches: ['Chemical Engineering'],
        credits: 3,
        primaryRoom: 'ROOM-202',
        professorId: DummyFaculties.faculties[17].id),
    Course(
        id: '19',
        courseCode: 'EE119',
        courseName: 'Electronics Engineering Basics',
        branches: ['Electronics Engineering'],
        credits: 3,
        primaryRoom: 'ROOM-203',
        professorId: DummyFaculties.faculties[18].id),
    Course(
        id: '20',
        courseCode: 'CS120',
        courseName: 'Advanced Computer Science Topics',
        branches: ['Computer Science'],
        credits: 3,
        primaryRoom: 'ROOM-204',
        professorId: DummyFaculties.faculties[19].id),
  ];
}

class DummyFaculties {
  static List<Faculty> faculties = [
    Faculty(
        id: '1',
        name: 'Dr. Smith',
        email: 'smith@example.com',
        courses: [
          DummyCourses.courses[0],
          DummyCourses.courses[5],
          DummyCourses.courses[10],
        ],
        cabinNumber: 'C-101',
        department: 'Computer Science'),
    Faculty(
      id: '2',
      name: 'Prof. Johnson',
      email: 'johnson@example.com',
      courses: [
        DummyCourses.courses[1],
        DummyCourses.courses[6],
        DummyCourses.courses[11]
      ],
      cabinNumber: 'C-102',
      department: 'Mechanical Engineering',
    ),
    Faculty(
      id: '3',
      name: 'Dr. Brown',
      email: 'brown@example.com',
      courses: [
        DummyCourses.courses[2],
        DummyCourses.courses[7],
        DummyCourses.courses[12]
      ],
      cabinNumber: 'C-103',
      department: 'Electrical Engineering',
    ),
    Faculty(
        id: '4',
        name: 'Prof. Davis',
        email: 'davis@example.com',
        courses: [
          DummyCourses.courses[3],
          DummyCourses.courses[8],
          DummyCourses.courses[13]
        ],
        cabinNumber: 'C-104',
        department: 'Civil Engineering'),
    Faculty(
        id: '5',
        name: 'Dr. Wilson',
        email: 'wilson@example.com',
        courses: [
          DummyCourses.courses[4],
          DummyCourses.courses[9],
          DummyCourses.courses[14]
        ],
        cabinNumber: 'C-105',
        department: 'Chemical Engineering'),
    Faculty(
        id: '6',
        name: 'Prof. Miller',
        email: 'miller@example.com',
        courses: [
          DummyCourses.courses[0],
          DummyCourses.courses[5],
          DummyCourses.courses[10]
        ],
        cabinNumber: 'C-106',
        department: 'Biotechnology'),
    Faculty(
        id: '7',
        name: 'Dr. Turner',
        email: 'turner@example.com',
        courses: [
          DummyCourses.courses[1],
          DummyCourses.courses[6],
          DummyCourses.courses[11]
        ],
        cabinNumber: 'C-107',
        department: 'Aerospace Engineering'),
    Faculty(
        id: '8',
        name: 'Prof. Clark',
        email: 'clark@example.com',
        courses: [
          DummyCourses.courses[2],
          DummyCourses.courses[7],
          DummyCourses.courses[12]
        ],
        cabinNumber: 'C-108',
        department: 'Information Technology'),
    Faculty(
        id: '9',
        name: 'Dr. Harris',
        email: 'harris@example.com',
        courses: [
          DummyCourses.courses[3],
          DummyCourses.courses[8],
          DummyCourses.courses[13]
        ],
        cabinNumber: 'C-109',
        department: 'Mechatronics'),
    Faculty(
        id: '10',
        name: 'Prof. Turner',
        email: 'turner@example.com',
        courses: [
          DummyCourses.courses[4],
          DummyCourses.courses[9],
          DummyCourses.courses[14]
        ],
        cabinNumber: 'C-110',
        department: 'Robotics Engineering'),
    Faculty(
        id: '11',
        name: 'Dr. White',
        email: 'white@example.com',
        courses: [
          DummyCourses.courses[0],
          DummyCourses.courses[5],
          DummyCourses.courses[10]
        ],
        cabinNumber: 'D-101',
        department: 'Industrial Engineering'),
    Faculty(
        id: '12',
        name: 'Prof. Allen',
        email: 'allen@example.com',
        courses: [
          DummyCourses.courses[1],
          DummyCourses.courses[6],
          DummyCourses.courses[11]
        ],
        cabinNumber: 'D-102',
        department: 'Computer Engineering'),
    Faculty(
        id: '13',
        name: 'Dr. Young',
        email: 'young@example.com',
        courses: [
          DummyCourses.courses[2],
          DummyCourses.courses[7],
          DummyCourses.courses[12]
        ],
        cabinNumber: 'D-103',
        department: 'Software Engineering'),
    Faculty(
        id: '14',
        name: 'Prof. Walker',
        email: 'walker@example.com',
        courses: [
          DummyCourses.courses[3],
          DummyCourses.courses[8],
          DummyCourses.courses[13]
        ],
        cabinNumber: 'D-104',
        department: 'Environmental Engineering'),
    Faculty(
        id: '15',
        name: 'Dr. Lee',
        email: 'lee@example.com',
        courses: [
          DummyCourses.courses[4],
          DummyCourses.courses[9],
          DummyCourses.courses[14]
        ],
        cabinNumber: 'D-105',
        department: 'Petrolesum[ Engineer]ing'),
    Faculty(
        id: '16',
        name: 'Prof. Hall',
        email: 'hall@example.com',
        courses: [
          DummyCourses.courses[0],
          DummyCourses.courses[5],
          DummyCourses.courses[10]
        ],
        cabinNumber: 'D-106',
        department: 'Nuclear Engineering'),
    Faculty(
        id: '17',
        name: 'Dr. Miller',
        email: 'miller@example.com',
        courses: [
          DummyCourses.courses[1],
          DummyCourses.courses[6],
          DummyCourses.courses[11]
        ],
        cabinNumber: 'D-107',
        department: 'Biomedical Engineering'),
    Faculty(
        id: '18',
        name: 'Prof. Baker',
        email: 'baker@example.com',
        courses: [
          DummyCourses.courses[2],
          DummyCourses.courses[7],
          DummyCourses.courses[12]
        ],
        cabinNumber: 'D-108',
        department: 'Chemical Engineering'),
    Faculty(
        id: '19',
        name: 'Dr. Turner',
        email: 'turner@example.com',
        courses: [
          DummyCourses.courses[3],
          DummyCourses.courses[8],
          DummyCourses.courses[13]
        ],
        cabinNumber: 'D-109',
        department: 'Electronics Engineering'),
    Faculty(
        id: '20',
        name: 'Prof. Smith',
        email: 'smith@example.com',
        courses: [
          DummyCourses.courses[4],
          DummyCourses.courses[9],
          DummyCourses.courses[14]
        ],
        cabinNumber: 'D-110',
        department: 'Computer Science'),
  ];
}

class DummyMenus {
  static Map<String, MessMenu> messMenus = {
    'GrandKitchen': MessMenu(
      id: '1',
      kitchenName: 'GrandKitchen',
      messMenu: {
        'Sunday': {
          'Breakfast': ['Blueberry Pancakes', 'Eggs Benedict'],
          'Lunch': ['Roast Chicken', 'Mashed Potatoes'],
          'Dinner': ['Salmon Piccata', 'Caprese Salad'],
          'Snacks': ['Chef\'s Gourmet Delight'],
        },
        'Monday': {
          'Breakfast': ['Belgian Waffles', 'Fruit Parfait'],
          'Lunch': ['Spicy Beef Tacos', 'Cilantro Lime Rice'],
          'Dinner': ['Grilled Swordfish', 'Quinoa Salad'],
          'Snacks': ['Decadent Chocolate Desserts'],
        },
        'Tuesday': {
          'Breakfast': ['Bagels and Lox', 'Greek Yogurt'],
          'Lunch': ['Pesto Pasta', 'Garlic Bread'],
          'Dinner': ['Lemon Herb Chicken', 'Roasted Vegetables'],
          'Snacks': ['Mediterranean Night'],
        },
        'Wednesday': {
          'Breakfast': ['Cinnamon Rolls', 'Fresh Fruit Smoothies'],
          'Lunch': ['Shrimp Pad Thai', 'Spring Rolls'],
          'Dinner': ['Prime Rib', 'Loaded Baked Potatoes'],
          'Snacks': ['International Buffet'],
        },
        'Thursday': {
          'Breakfast': ['Omelette Bar', 'Hash Browns'],
          'Lunch': ['Chicken Caesar Salad', 'Grilled Asparagus'],
          'Dinner': ['Sushi Platter', 'Edamame'],
          'Snacks': ['Sushi Extravaganza'],
        },
        'Friday': {
          'Breakfast': ['Pancetta Frittata', 'Fresh Squeezed Juice'],
          'Lunch': ['Margherita Pizza', 'Caesar Salad'],
          'Dinner': ['Lobster Tail', 'Vegetable Stir-Fry'],
          'Snacks': ['Seafood Feast'],
        },
        'Saturday': {
          'Breakfast': ['French Toast', 'Mixed Berry Compote'],
          'Lunch': ['Caprese Panini', 'Sweet Potato Fries'],
          'Dinner': ['Filet Mignon', 'Brussels Sprouts'],
          'Snacks': ['Steakhouse Night'],
        },
      },
    ),
    'RoyalCuisine': MessMenu(
      id: '2',
      kitchenName: 'RoyalCuisine',
      messMenu: {
        'Sunday': {
          'Breakfast': ['Croissants', 'Fresh Berries'],
          'Lunch': ['Chicken Marsala', 'Truffle Risotto'],
          'Dinner': ['Seared Scallops', 'Greek Salad'],
          'Snacks': ['Royal Feast'],
        },
        'Monday': {
          'Breakfast': ['Scones', 'Clotted Cream'],
          'Lunch': ['Beef Wellington', 'Creamed Spinach'],
          'Dinner': ['Lobster Risotto', 'Caesar Salad'],
          'Snacks': ['Luxurious Dessert Selection'],
        },
        'Tuesday': {
          'Breakfast': ['Peach Danish', 'Yogurt Parfait'],
          'Lunch': ['Lemon Herb Roast Chicken', 'Wild Rice Pilaf'],
          'Dinner': ['Pan-Seared Duck Breast', 'Cranberry Walnut Salad'],
          'Snacks': ['Fine Dining Experience'],
        },
        'Wednesday': {
          'Breakfast': ['Danish Pastries', 'Fresh Fruit Platter'],
          'Lunch': ['Grilled Lamb Chops', 'Mint Pesto Pasta'],
          'Dinner': ['Baked Halibut', 'Roasted Vegetables'],
          'Snacks': ['Seafood Delicacies'],
        },
        'Thursday': {
          'Breakfast': ['Almond Croissants', 'Mixed Berry Smoothies'],
          'Lunch': ['Vegetarian Lasagna', 'Garlic Breadsticks'],
          'Dinner': ['Shrimp Scampi', 'Caprese Salad'],
          'Snacks': ['Italian Night'],
        },
        'Friday': {
          'Breakfast': ['Caramelized Onion Quiche', 'Mango Lassi'],
          'Lunch': ['Teriyaki Salmon', 'Vegetable Tempura'],
          'Dinner': ['Ribeye Steak', 'Loaded Baked Potatoes'],
          'Snacks': ['Asian Fusion'],
        },
        'Saturday': {
          'Breakfast': ['Chocolate Croissants', 'Vanilla Latte'],
          'Lunch': ['Eggplant Parmesan', 'Garlic Knots'],
          'Dinner': ['Grilled Lobster Tail', 'Caesar Salad'],
          'Snacks': ['Gourmet Delights'],
        },
      },
    ),
    'ExquisiteEats': MessMenu(
      id: '3',
      kitchenName: 'ExquisiteEats',
      messMenu: {
        'Sunday': {
          'Breakfast': ['Avocado Toast', 'Smoothie Bowl'],
          'Lunch': ['Quinoa Salad', 'Stuffed Bell Peppers'],
          'Dinner': ['Vegan Curry', 'Cauliflower Rice'],
          'Snacks': ['Plant-Based Delicacies'],
        },
        'Monday': {
          'Breakfast': ['Chia Seed Pudding', 'Mixed Fruit Smoothie'],
          'Lunch': ['Sweet Potato Buddha Bowl', 'Kale Salad'],
          'Dinner': ['Mushroom Risotto', 'Grilled Asparagus'],
          'Snacks': ['Vegan Dessert Paradise'],
        },
        'Tuesday': {
          'Breakfast': ['Acai Bowl', 'Nut Butter Toast'],
          'Lunch': ['Lentil Soup', 'Quinoa Stuffed Acorn Squash'],
          'Dinner': ['Zucchini Noodles', 'Vegan Alfredo Sauce'],
          'Snacks': ['Healthy Indulgence Night'],
        },
        'Wednesday': {
          'Breakfast': ['Green Smoothie', 'Protein Pancakes'],
          'Lunch': ['Chickpea Salad Wrap', 'Sweet Potato Fries'],
          'Dinner': ['Cauliflower Steak', 'Wild Rice Pilaf'],
          'Snacks': ['Vegan Delights'],
        },
        'Thursday': {
          'Breakfast': ['Vegan Pancakes', 'Mixed Berry Compote'],
          'Lunch': ['Spaghetti Squash Primavera', 'Garlic Bread'],
          'Dinner': ['Veggie Stir-Fry', 'Tofu Satay'],
          'Snacks': ['International Vegan Cuisine'],
        },
        'Friday': {
          'Breakfast': ['Almond Butter Toast', 'Fruit Smoothie Bowl'],
          'Lunch': ['Vegan Tacos', 'Guacamole'],
          'Dinner': ['Eggplant Parmesan', 'Zesty Quinoa Salad'],
          'Snacks': ['Vegan Fiesta'],
        },
        'Saturday': {
          'Breakfast': ['Pumpkin Spice Smoothie', 'Granola Parfait'],
          'Lunch': ['Vegan Sushi Rolls', 'Edamame'],
          'Dinner': ['Portobello Mushroom Steak', 'Roasted Brussels Sprouts'],
          'Snacks': ['Gourmet Vegan Experience'],
        },
      },
    ),
    'SavorySpices': MessMenu(
      id: '4',
      kitchenName: 'SavorySpices',
      messMenu: {
        'Sunday': {
          'Breakfast': ['Cinnamon Roll Pancakes', 'Spiced Chai Latte'],
          'Lunch': ['Indian Butter Chicken', 'Naan Bread'],
          'Dinner': ['Lamb Rogan Josh', 'Saffron Rice'],
          'Snacks': ['Indian Spice Festival'],
        },
        'Monday': {
          'Breakfast': ['Masala Chai Oatmeal', 'Cardamom Muffins'],
          'Lunch': ['Vegetable Biryani', 'Cucumber Raita'],
          'Dinner': ['Chicken Tikka Masala', 'Garlic Naan'],
          'Snacks': ['Flavors of India Night'],
        },
        'Tuesday': {
          'Breakfast': ['Turmeric Smoothie Bowl', 'Mango Lassi'],
          'Lunch': ['Palak Paneer', 'Jeera Rice'],
          'Dinner': ['Tandoori Salmon', 'Aloo Gobi'],
          'Snacks': ['Spice Infusion Dinner'],
        },
        'Wednesday': {
          'Breakfast': ['Samosa Stuffed Omelette', 'Minty Yogurt Dip'],
          'Lunch': ['Chicken Korma', 'Pulao Rice'],
          'Dinner': ['Vegetable Jalfrezi', 'Roti'],
          'Snacks': ['Indian Delicacies Night'],
        },
        'Thursday': {
          'Breakfast': ['Chai Spiced Granola', 'Mango Chutney'],
          'Lunch': ['Dal Makhani', 'Garlic Butter Naan'],
          'Dinner': ['Fish Curry', 'Coconut Rice'],
          'Snacks': ['South Asian Feast'],
        },
        'Friday': {
          'Breakfast': ['Curry Leaf Scrambled Eggs', 'Spiced Fruit Salad'],
          'Lunch': ['Aloo Paratha', 'Raita'],
          'Dinner': ['Mutton Biryani', 'Cucumber Mint Chutney'],
          'Snacks': ['Exotic Indian Flavors Night'],
        },
        'Saturday': {
          'Breakfast': ['Spicy Mango Smoothie', 'Papaya Chaat'],
          'Lunch': ['Paneer Tikka', 'Masoor Dal'],
          'Dinner': ['Chicken Curry', 'Basmati Pilaf'],
          'Snacks': ['Indian Culinary Journey'],
        },
      },
    ),
    'SeafoodSensation': MessMenu(
      id: '5',
      kitchenName: 'SeafoodSensation',
      messMenu: {
        'Sunday': {
          'Breakfast': ['Smoked Salmon Bagels', 'Cream Cheese'],
          'Lunch': ['Garlic Butter Shrimp', 'Lemon Herb Couscous'],
          'Dinner': ['Grilled Lobster Tail', 'Asparagus Risotto'],
          'Snacks': ['Seafood Extravaganza'],
        },
        'Monday': {
          'Breakfast': ['Crab Benedict', 'Avocado Toast'],
          'Lunch': ['Spicy Tuna Sushi', 'Edamame'],
          'Dinner': ['Scallop Scampi', 'Wild Rice Pilaf'],
          'Snacks': ['Sushi Night'],
        },
        'Tuesday': {
          'Breakfast': ['Shrimp and Grits', 'Cajun Omelette'],
          'Lunch': ['Lobster Mac and Cheese', 'Garlic Bread'],
          'Dinner': ['Blackened Salmon', 'Quinoa Salad'],
          'Snacks': ['Seafood Delicacies Night'],
        },
        'Wednesday': {
          'Breakfast': ['Smoked Mackerel Hash', 'Dill Hollandaise'],
          'Lunch': ['Clam Linguine', 'Garlic Knots'],
          'Dinner': ['Grilled Swordfish', 'Mango Salsa'],
          'Snacks': ['Fresh Catch Night'],
        },
        'Thursday': {
          'Breakfast': ['Tuna Nicoise Salad', 'Citrus Vinaigrette'],
          'Lunch': ['Cajun Shrimp Po\' Boy', 'Sweet Potato Fries'],
          'Dinner': ['Crab Cakes', 'Remoulade Sauce'],
          'Snacks': ['Seafood Fusion Night'],
        },
        'Friday': {
          'Breakfast': ['Smoked Salmon Omelette', 'Caprese Salad'],
          'Lunch': ['Shrimp and Crab Bisque', 'Garlic Bread'],
          'Dinner': ['Grilled Mahi Mahi', 'Quinoa Pilaf'],
          'Snacks': ['Mediterranean Seafood Night'],
        },
        'Saturday': {
          'Breakfast': ['Shrimp Avocado Toast', 'Citrus Zest Smoothie'],
          'Lunch': ['Seafood Paella', 'Green Bean Almondine'],
          'Dinner': ['Crab Stuffed Mushrooms', 'Roasted Tomato Bruschetta'],
          'Snacks': ['Seafood Extravaganza'],
        },
      },
    ),
  };
}

class DummyRooms {
  //static List<Room> rooms = [];
  static List<Room> rooms = [
    Room(id: '1', name: 'Auditorium', vacant: true),
    Room(id: '2', name: 'Classroom 101', vacant: false, occupantId: 'T001'),
    Room(id: '3', name: 'Robotics Club', vacant: true),
    Room(id: '4', name: 'Library Study Room A', vacant: true),
    Room(id: '5', name: 'Conference Room', vacant: false, occupantId: 'T002'),
    Room(id: '6', name: 'Physics Lab', vacant: true),
    Room(id: '7', name: 'Student Lounge', vacant: false, occupantId: 'S001'),
    Room(id: '8', name: 'Chemistry Lab', vacant: true),
    Room(id: '9', name: 'Art Studio', vacant: false, occupantId: 'T003'),
    Room(id: '10', name: 'Cafeteria', vacant: false, occupantId: 'S002'),
    Room(id: '11', name: 'Computer Lab 201', vacant: true),
    Room(id: '12', name: 'Math Club Room', vacant: true),
    Room(id: '13', name: 'Gymnasium', vacant: false, occupantId: 'S003'),
    Room(id: '14', name: 'Drama Club Rehearsal Room', vacant: true),
    Room(id: '15', name: 'Language Lab', vacant: false, occupantId: 'T004'),
    Room(id: '16', name: 'Outdoor Sports Arena', vacant: true),
    Room(id: '17', name: 'Medical Clinic', vacant: false, occupantId: 'S004'),
    Room(id: '18', name: 'Music Room', vacant: true),
    Room(
        id: '19',
        name: 'Student Council Office',
        vacant: false,
        occupantId: 'T005'),
    Room(id: '20', name: 'Virtual Reality Lab', vacant: true),
  ];
}

class DummyLostAndFound {
  static List<LostAndFoundItem> lostAndFoundItems = [
    LostAndFoundItem(
      name: 'Laptop',
      description: 'Black Dell laptop with a sticker on the back',
      lastSeenLocation: 'Library',
      contactNumber: '+91 1234567890',
      listerId: 'S001',
      isLost: false,
    ),
    LostAndFoundItem(
      name: 'Mobile Phone',
      description: 'White iPhone 12 with a black case',
      lastSeenLocation: 'Cafeteria',
      contactNumber: '+91 9876543210',
      listerId: 'S002',
      isLost: true,
    ),
    LostAndFoundItem(
      name: 'Water Bottle',
      description: 'Blue steel water bottle with a dent on the bottom',
      lastSeenLocation: 'Gymnasium',
      contactNumber: '+91 4567890123',
      listerId: 'S003',
      isLost: false,
    ),
    LostAndFoundItem(
      name: 'Backpack',
      description: 'Red and black backpack with a broken zipper',
      lastSeenLocation: 'Auditorium',
      contactNumber: '+91 7890123456',
      listerId: 'S004',
      isLost: true,
    ),
    LostAndFoundItem(
      name: 'Watch',
      description: 'Silver wristwatch with a black leather strap',
      lastSeenLocation: 'Classroom 101',
      contactNumber: '+91 2345678901',
      listerId: 'S005',
      isLost: false,
    ),
    LostAndFoundItem(
      name: 'Umbrella',
      description: 'Green and white striped umbrella with a broken handle',
      lastSeenLocation: 'Student Lounge',
      contactNumber: '+91 8901234567',
      listerId: 'S006',
      isLost: true,
    ),
    LostAndFoundItem(
      name: 'Sunglasses',
      description: 'Black aviator sunglasses with a scratch on the left lens',
      lastSeenLocation: 'Cafeteria',
      contactNumber: '+91 3456789012',
      listerId: 'S007',
      isLost: false,
    ),
    LostAndFoundItem(
      name: 'Wallet',
      description: 'Brown leather wallet with a broken zipper',
      lastSeenLocation: 'Library',
      contactNumber: '+91 9012345678',
      listerId: 'S008',
      isLost: true,
    ),
    LostAndFoundItem(
      name: 'Headphones',
      description: 'Black over-ear headphones with a missing ear cushion',
      lastSeenLocation: 'Auditorium',
      contactNumber: '+91 6789012345',
      listerId: 'S009',
      isLost: false,
    ),
    LostAndFoundItem(
      name: 'Jacket',
      description: 'Blue denim jacket with a tear on the left sleeve',
      lastSeenLocation: 'Gymnasium',
      contactNumber: '+91 5678901234',
      listerId: 'S010',
      isLost: true,
    ),
  ];
}

class DummySkills {
  static List<Skill> skills = [
    Skill(id: '1', name: 'Programming', level: 5),
    Skill(id: '2', name: 'Web Development', level: 3),
    Skill(id: '3', name: 'Data Analysis', level: 2),
    Skill(id: '4', name: 'Graphic Design', level: 4),
    Skill(id: '5', name: 'Project Management', level: 3),
    Skill(id: '6', name: 'Mobile App Development', level: 2),
    Skill(id: '7', name: 'UI/UX Design', level: 4),
    Skill(id: '8', name: 'Machine Learning', level: 1),
    Skill(id: '9', name: 'Database Management', level: 3),
    Skill(id: '10', name: 'Networking', level: 2),
    Skill(id: '11', name: 'Cybersecurity', level: 1),
    Skill(id: '12', name: 'System Administration', level: 4),
    Skill(id: '13', name: 'Cloud Computing', level: 2),
    Skill(id: '14', name: 'Testing/QA', level: 3),
    Skill(id: '15', name: 'Agile Methodology', level: 4),
    Skill(id: '16', name: 'Technical Writing', level: 3),
    Skill(id: '17', name: 'Problem Solving', level: 5),
    Skill(id: '18', name: 'Communication Skills', level: 4),
    Skill(id: '19', name: 'Time Management', level: 3),
    Skill(id: '20', name: 'Leadership', level: 4),
  ];
}

class DummyAchievements {
  static List<Achievement> achievements = [
    Achievement(
      id: '1',
      name: 'Employee of the Month',
      date: DateTime(2022, 5, 15),
      description: 'Recognized for outstanding performance and dedication.',
    ),
    Achievement(
      id: '2',
      name: 'Project Completion',
      date: DateTime(2022, 8, 20),
      description: 'Successfully led a team to complete a critical project.',
    ),
    Achievement(
      id: '3',
      name: 'Certification Achievement',
      date: DateTime(2022, 3, 10),
      description: 'Obtained a certification in a relevant field of expertise.',
    ),
    Achievement(
      id: '4',
      name: 'Innovation Award',
      date: DateTime(2023, 1, 5),
      description: 'Recognized for introducing innovative solutions.',
    ),
    Achievement(
      id: '5',
      name: 'Customer Appreciation',
      date: DateTime(2023, 7, 12),
      description: 'Received positive feedback and appreciation from a client.',
    ),
    Achievement(
      id: '6',
      name: 'Leadership Excellence',
      date: DateTime(2023, 11, 30),
      description: 'Acknowledged for exemplary leadership skills.',
    ),
    Achievement(
      id: '7',
      name: 'Community Service Award',
      date: DateTime(2022, 6, 8),
      description: 'Recognized for contributions to community service.',
    ),
    Achievement(
      id: '8',
      name: 'Sales Achievement',
      date: DateTime(2022, 9, 25),
      description: 'Achieved significant sales targets and milestones.',
    ),
    Achievement(
      id: '9',
      name: 'Team Collaboration Award',
      date: DateTime(2023, 4, 18),
      description: 'Commended for fostering effective team collaboration.',
    ),
    Achievement(
      id: '10',
      name: 'Publication Recognition',
      date: DateTime(2022, 12, 7),
      description: 'Published work recognized for its impact in the industry.',
    ),
    Achievement(
      id: '11',
      name: 'Safety Excellence Award',
      date: DateTime(2023, 8, 2),
      description: 'Maintained a safe working environment with zero incidents.',
    ),
    Achievement(
      id: '12',
      name: 'Training and Development',
      date: DateTime(2022, 4, 22),
      description:
          'Contributed significantly to employee training and development.',
    ),
    Achievement(
      id: '13',
      name: 'Quality Assurance Recognition',
      date: DateTime(2023, 2, 14),
      description:
          'Acknowledged for ensuring high-quality standards in projects.',
    ),
    Achievement(
      id: '14',
      name: 'Inclusive Workplace Award',
      date: DateTime(2022, 10, 9),
      description: 'Promoted inclusivity and diversity in the workplace.',
    ),
    Achievement(
      id: '15',
      name: 'Milestone Anniversary',
      date: DateTime(2023, 6, 5),
      description: 'Celebrating a significant milestone with the organization.',
    ),
    Achievement(
      id: '16',
      name: 'International Recognition',
      date: DateTime(2022, 11, 19),
      description: 'Recognized internationally for contributions to the field.',
    ),
    Achievement(
      id: '17',
      name: 'Environmental Sustainability Award',
      date: DateTime(2023, 3, 28),
      description: 'Contributed to environmentally sustainable practices.',
    ),
    Achievement(
      id: '18',
      name: 'Customer Service Excellence',
      date: DateTime(2022, 7, 1),
      description: 'Provided outstanding customer service and satisfaction.',
    ),
    Achievement(
      id: '19',
      name: 'Health and Wellness Initiative',
      date: DateTime(2023, 9, 10),
      description:
          'Led initiatives to promote health and wellness in the workplace.',
    ),
    Achievement(
      id: '20',
      name: 'Public Speaking Achievement',
      date: DateTime(2022, 1, 30),
      description:
          'Received acclaim for public speaking skills at a conference.',
    ),
  ];
// You can use the dummyEntries list as needed in your application
}

class DummyMessages {
  static List<Message> messages = [
    Message(
      sender: "Alice",
      content: "Hello there!",
      timestamp: DateTime.now(),
    ),
    Message(
      sender: "Bob",
      content: "Hi Alice!",
      timestamp: DateTime.now().add(Duration(minutes: 5)),
    ),
    Message(
      sender: "Alice",
      content: "How are you?",
      timestamp: DateTime.now().add(Duration(minutes: 10)),
    ),
    Message(
      sender: "Bob",
      content: "I'm doing well, thanks!",
      timestamp: DateTime.now().add(Duration(minutes: 15)),
    ),
    // Add more messages as needed
    Message(
      sender: "Alice",
      content: "What's your plan for the day?",
      timestamp: DateTime.now().add(Duration(minutes: 20)),
    ),
    Message(
      sender: "Bob",
      content: "Just working on some projects.",
      timestamp: DateTime.now().add(Duration(minutes: 25)),
    ),
    Message(
      sender: "Alice",
      content: "Sounds good!",
      timestamp: DateTime.now().add(Duration(minutes: 30)),
    ),
    Message(
      sender: "Bob",
      content: "How about you?",
      timestamp: DateTime.now().add(Duration(minutes: 35)),
    ),
    Message(
      sender: "Alice",
      content: "I have some errands to run.",
      timestamp: DateTime.now().add(Duration(minutes: 40)),
    ),
    Message(
      sender: "Bob",
      content: "Have a great day!",
      timestamp: DateTime.now().add(Duration(minutes: 45)),
    ),
    Message(
      sender: "Alice",
      content: "You too!",
      timestamp: DateTime.now().add(Duration(minutes: 50)),
    ),
  ];
}
