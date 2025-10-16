// lib/data/math_lessons_data.dart
import '../models/lesson.dart';
import '../models/lesson_page.dart';

class MathLessonsData {
  static List<Lesson> getAllLessons() {
    return [
      _getLesson1Numbers1to10(),
      _getLesson2Numbers11to20(),
      _getLesson3CountingObjects(),
      _getLesson4CountingObjects11to20(),
      _getLesson5BasicShapes(),
      _getLesson6MoreShapes(),
      _getLesson7BigAndSmall(),
      _getLesson8TallAndShort(),
      _getLesson9SimpleAddition1to5(),
      _getLesson10SimpleAddition6to10(),
      _getLesson11SimpleSubtraction1to5(),
      _getLesson12SimpleSubtraction6to10(),
      _getLesson13NumberPatterns(),
      _getLesson14SkipCounting(),
      _getLesson15ComparingNumbers(),
    ];
  }

  // Lesson 1: Numbers 1-10
  static Lesson _getLesson1Numbers1to10() {
    return Lesson(
      id: 'math_01',
      lessonNumber: 1,
      title: 'Numbers 1-10',
      subtitle: 'Learn to count from one to ten',
      category: 'Math',
      iconPath: 'assets/images/icons/numbers_icon.png',
      pages: [
        LessonPage(
          id: 'math_01_page_01',
          title: 'O N E ONE',
          primaryText: '1',
          secondaryText: 'One',
          description: 'One apple',
          imagePath: 'assets/images/lessons/math/numbers/one_apple.png',
          audioPath: 'assets/audio/math/one.mp3',
          backgroundColor: '#FFF4E6',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_01_page_02',
          title: 'T W O TWO',
          primaryText: '2',
          secondaryText: 'Two',
          description: 'Two balls',
          imagePath: 'assets/images/lessons/math/numbers/two_balls.png',
          audioPath: 'assets/audio/math/two.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_01_page_03',
          title: 'T H R E E THREE',
          primaryText: '3',
          secondaryText: 'Three',
          description: 'Three stars',
          imagePath: 'assets/images/lessons/math/numbers/three_stars.png',
          audioPath: 'assets/audio/math/three.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 3,
        ),
        LessonPage(
          id: 'math_01_page_04',
          title: 'F O U R FOUR',
          primaryText: '4',
          secondaryText: 'Four',
          description: 'Four flowers',
          imagePath: 'assets/images/lessons/math/numbers/four_flowers.png',
          audioPath: 'assets/audio/math/four.mp3',
          backgroundColor: '#F3E5F5',
          pageNumber: 4,
        ),
        LessonPage(
          id: 'math_01_page_05',
          title: 'F I V E FIVE',
          primaryText: '5',
          secondaryText: 'Five',
          description: 'Five balloons',
          imagePath: 'assets/images/lessons/math/numbers/five_balloons.png',
          audioPath: 'assets/audio/math/five.mp3',
          backgroundColor: '#FFF3E0',
          pageNumber: 5,
        ),
        LessonPage(
          id: 'math_01_page_06',
          title: 'S I X SIX',
          primaryText: '6',
          secondaryText: 'Six',
          description: 'Six birds',
          imagePath: 'assets/images/lessons/math/numbers/six_birds.png',
          audioPath: 'assets/audio/math/six.mp3',
          backgroundColor: '#E0F2F1',
          pageNumber: 6,
        ),
        LessonPage(
          id: 'math_01_page_07',
          title: 'S E V E N SEVEN',
          primaryText: '7',
          secondaryText: 'Seven',
          description: 'Seven butterflies',
          imagePath: 'assets/images/lessons/math/numbers/seven_butterflies.png',
          audioPath: 'assets/audio/math/seven.mp3',
          backgroundColor: '#FCE4EC',
          pageNumber: 7,
        ),
        LessonPage(
          id: 'math_01_page_08',
          title: 'E I G H T EIGHT',
          primaryText: '8',
          secondaryText: 'Eight',
          description: 'Eight candies',
          imagePath: 'assets/images/lessons/math/numbers/eight_candies.png',
          audioPath: 'assets/audio/math/eight.mp3',
          backgroundColor: '#FFF9C4',
          pageNumber: 8,
        ),
        LessonPage(
          id: 'math_01_page_09',
          title: 'N I N E NINE',
          primaryText: '9',
          secondaryText: 'Nine',
          description: 'Nine pencils',
          imagePath: 'assets/images/lessons/math/numbers/nine_pencils.png',
          audioPath: 'assets/audio/math/nine.mp3',
          backgroundColor: '#E1F5FE',
          pageNumber: 9,
        ),
        LessonPage(
          id: 'math_01_page_10',
          title: 'T E N TEN',
          primaryText: '10',
          secondaryText: 'Ten',
          description: 'Ten hearts',
          imagePath: 'assets/images/lessons/math/numbers/ten_hearts.png',
          audioPath: 'assets/audio/math/ten.mp3',
          backgroundColor: '#FFEBEE',
          pageNumber: 10,
        ),
      ],
    );
  }

  // Lesson 2: Numbers 11-20
  static Lesson _getLesson2Numbers11to20() {
    return Lesson(
      id: 'math_02',
      lessonNumber: 2,
      title: 'Numbers 11-20',
      subtitle: 'Count higher numbers',
      category: 'Math',
      iconPath: 'assets/images/icons/numbers_advanced_icon.png',
      pages: [
        LessonPage(
          id: 'math_02_page_01',
          title: 'E L E V E N ELEVEN',
          primaryText: '11',
          secondaryText: 'Eleven',
          description: 'Eleven flowers',
          imagePath: 'assets/images/lessons/math/numbers/eleven_flowers.png',
          audioPath: 'assets/audio/math/eleven.mp3',
          backgroundColor: '#FFF3E0',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_02_page_02',
          title: 'T W E L V E TWELVE',
          primaryText: '12',
          secondaryText: 'Twelve',
          description: 'Twelve stars',
          imagePath: 'assets/images/lessons/math/numbers/twelve_stars.png',
          audioPath: 'assets/audio/math/twelve.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_02_page_03',
          title: 'T H I R T E E N THIRTEEN',
          primaryText: '13',
          secondaryText: 'Thirteen',
          imagePath: 'assets/images/lessons/math/numbers/thirteen.png',
          audioPath: 'assets/audio/math/thirteen.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 3,
        ),
        LessonPage(
          id: 'math_02_page_04',
          title: 'F O U R T E E N FOURTEEN',
          primaryText: '14',
          secondaryText: 'Fourteen',
          imagePath: 'assets/images/lessons/math/numbers/fourteen.png',
          audioPath: 'assets/audio/math/fourteen.mp3',
          backgroundColor: '#F3E5F5',
          pageNumber: 4,
        ),
        LessonPage(
          id: 'math_02_page_05',
          title: 'F I F T E E N FIFTEEN',
          primaryText: '15',
          secondaryText: 'Fifteen',
          imagePath: 'assets/images/lessons/math/numbers/fifteen.png',
          audioPath: 'assets/audio/math/fifteen.mp3',
          backgroundColor: '#FFF3E0',
          pageNumber: 5,
        ),
        LessonPage(
          id: 'math_02_page_06',
          title: 'S I X T E E N SIXTEEN',
          primaryText: '16',
          secondaryText: 'Sixteen',
          imagePath: 'assets/images/lessons/math/numbers/sixteen.png',
          audioPath: 'assets/audio/math/sixteen.mp3',
          backgroundColor: '#E0F2F1',
          pageNumber: 6,
        ),
        LessonPage(
          id: 'math_02_page_07',
          title: 'S E V E N T E E N SEVENTEEN',
          primaryText: '17',
          secondaryText: 'Seventeen',
          imagePath: 'assets/images/lessons/math/numbers/seventeen.png',
          audioPath: 'assets/audio/math/seventeen.mp3',
          backgroundColor: '#FCE4EC',
          pageNumber: 7,
        ),
        LessonPage(
          id: 'math_02_page_08',
          title: 'E I G H T E E N EIGHTEEN',
          primaryText: '18',
          secondaryText: 'Eighteen',
          imagePath: 'assets/images/lessons/math/numbers/eighteen.png',
          audioPath: 'assets/audio/math/eighteen.mp3',
          backgroundColor: '#FFF9C4',
          pageNumber: 8,
        ),
        LessonPage(
          id: 'math_02_page_09',
          title: 'N I N E T E E N NINETEEN',
          primaryText: '19',
          secondaryText: 'Nineteen',
          imagePath: 'assets/images/lessons/math/numbers/nineteen.png',
          audioPath: 'assets/audio/math/nineteen.mp3',
          backgroundColor: '#E1F5FE',
          pageNumber: 9,
        ),
        LessonPage(
          id: 'math_02_page_10',
          title: 'T W E N T Y TWENTY',
          primaryText: '20',
          secondaryText: 'Twenty',
          imagePath: 'assets/images/lessons/math/numbers/twenty.png',
          audioPath: 'assets/audio/math/twenty.mp3',
          backgroundColor: '#FFEBEE',
          pageNumber: 10,
        ),
      ],
    );
  }

  // Lesson 3: Counting Objects 1-10
  static Lesson _getLesson3CountingObjects() {
    return Lesson(
      id: 'math_03',
      lessonNumber: 3,
      title: 'Counting Objects',
      subtitle: 'Count things around you',
      category: 'Math',
      iconPath: 'assets/images/icons/counting_icon.png',
      pages: [
        LessonPage(
          id: 'math_03_page_01',
          title: 'Count 3 Apples',
          primaryText: '3',
          secondaryText: 'Three Apples',
          description: 'How many apples can you see?',
          imagePath: 'assets/images/lessons/math/counting/three_apples.png',
          audioPath: 'assets/audio/math/count_three.mp3',
          backgroundColor: '#FCE4EC',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_03_page_02',
          title: 'Count 5 Cars',
          primaryText: '5',
          secondaryText: 'Five Cars',
          description: 'Count all the cars',
          imagePath: 'assets/images/lessons/math/counting/five_cars.png',
          audioPath: 'assets/audio/math/count_five.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_03_page_03',
          title: 'Count 7 Balloons',
          primaryText: '7',
          secondaryText: 'Seven Balloons',
          imagePath: 'assets/images/lessons/math/counting/seven_balloons.png',
          audioPath: 'assets/audio/math/count_seven.mp3',
          backgroundColor: '#FFF9C4',
          pageNumber: 3,
        ),
      ],
    );
  }

  // Lesson 4: Counting Objects 11-20
  static Lesson _getLesson4CountingObjects11to20() {
    return Lesson(
      id: 'math_04',
      lessonNumber: 4,
      title: 'Counting More Objects',
      subtitle: 'Count bigger groups',
      category: 'Math',
      iconPath: 'assets/images/icons/counting_icon.png',
      pages: [
        LessonPage(
          id: 'math_04_page_01',
          title: 'Count 12 Stars',
          primaryText: '12',
          secondaryText: 'Twelve Stars',
          imagePath: 'assets/images/lessons/math/counting/twelve_stars.png',
          audioPath: 'assets/audio/math/count_twelve.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_04_page_02',
          title: 'Count 15 Balls',
          primaryText: '15',
          secondaryText: 'Fifteen Balls',
          imagePath: 'assets/images/lessons/math/counting/fifteen_balls.png',
          audioPath: 'assets/audio/math/count_fifteen.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 2,
        ),
      ],
    );
  }

  // Lesson 5: Basic Shapes
  static Lesson _getLesson5BasicShapes() {
    return Lesson(
      id: 'math_05',
      lessonNumber: 5,
      title: 'Basic Shapes',
      subtitle: 'Learn Circle, Square, Triangle',
      category: 'Math',
      iconPath: 'assets/images/icons/shapes_icon.png',
      pages: [
        LessonPage(
          id: 'math_05_page_01',
          title: 'C I R C L E CIRCLE',
          primaryText: 'Circle',
          secondaryText: 'Round Shape',
          description: 'A circle is round',
          imagePath: 'assets/images/lessons/math/shapes/circle.png',
          audioPath: 'assets/audio/math/shape_circle.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_05_page_02',
          title: 'S Q U A R E SQUARE',
          primaryText: 'Square',
          secondaryText: '4 Equal Sides',
          description: 'A square has 4 corners',
          imagePath: 'assets/images/lessons/math/shapes/square.png',
          audioPath: 'assets/audio/math/shape_square.mp3',
          backgroundColor: '#FFF3E0',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_05_page_03',
          title: 'T R I A N G L E TRIANGLE',
          primaryText: 'Triangle',
          secondaryText: '3 Sides',
          description: 'A triangle has 3 corners',
          imagePath: 'assets/images/lessons/math/shapes/triangle.png',
          audioPath: 'assets/audio/math/shape_triangle.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 3,
        ),
      ],
    );
  }

  // Lesson 6: More Shapes
  static Lesson _getLesson6MoreShapes() {
    return Lesson(
      id: 'math_06',
      lessonNumber: 6,
      title: 'More Shapes',
      subtitle: 'Rectangle, Oval, Star',
      category: 'Math',
      iconPath: 'assets/images/icons/shapes_icon.png',
      pages: [
        LessonPage(
          id: 'math_06_page_01',
          title: 'R E C T A N G L E RECTANGLE',
          primaryText: 'Rectangle',
          secondaryText: 'Long Shape',
          description: 'A rectangle is longer than a square',
          imagePath: 'assets/images/lessons/math/shapes/rectangle.png',
          audioPath: 'assets/audio/math/shape_rectangle.mp3',
          backgroundColor: '#FCE4EC',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_06_page_02',
          title: 'O V A L OVAL',
          primaryText: 'Oval',
          secondaryText: 'Egg Shape',
          description: 'An oval looks like an egg',
          imagePath: 'assets/images/lessons/math/shapes/oval.png',
          audioPath: 'assets/audio/math/shape_oval.mp3',
          backgroundColor: '#F0E6FF',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_06_page_03',
          title: 'S T A R STAR',
          primaryText: 'Star',
          secondaryText: '5 Points',
          description: 'A star has 5 points',
          imagePath: 'assets/images/lessons/math/shapes/star.png',
          audioPath: 'assets/audio/math/shape_star.mp3',
          backgroundColor: '#E1F5FE',
          pageNumber: 3,
        ),
      ],
    );
  }

  // Lesson 7: Big and Small
  static Lesson _getLesson7BigAndSmall() {
    return Lesson(
      id: 'math_07',
      lessonNumber: 7,
      title: 'Big and Small',
      subtitle: 'Compare sizes',
      category: 'Math',
      iconPath: 'assets/images/icons/comparison_icon.png',
      pages: [
        LessonPage(
          id: 'math_07_page_01',
          title: 'B I G BIG',
          primaryText: 'Big',
          secondaryText: 'Large Size',
          description: 'This ball is big',
          imagePath: 'assets/images/lessons/math/comparison/big_ball.png',
          audioPath: 'assets/audio/math/comp_big.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_07_page_02',
          title: 'S M A L L SMALL',
          primaryText: 'Small',
          secondaryText: 'Little Size',
          description: 'This ball is small',
          imagePath: 'assets/images/lessons/math/comparison/small_ball.png',
          audioPath: 'assets/audio/math/comp_small.mp3',
          backgroundColor: '#FCE4EC',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_07_page_03',
          title: 'C O M P A R E COMPARE',
          primaryText: 'Compare',
          secondaryText: 'Which is Bigger?',
          description: 'The elephant is bigger than the mouse',
          imagePath: 'assets/images/lessons/math/comparison/elephant_mouse.png',
          audioPath: 'assets/audio/math/comp_compare.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 3,
        ),
      ],
    );
  }

  // Lesson 8: Tall and Short
  static Lesson _getLesson8TallAndShort() {
    return Lesson(
      id: 'math_08',
      lessonNumber: 8,
      title: 'Tall and Short',
      subtitle: 'Compare heights',
      category: 'Math',
      iconPath: 'assets/images/icons/comparison_icon.png',
      pages: [
        LessonPage(
          id: 'math_08_page_01',
          title: 'T A L L TALL',
          primaryText: 'Tall',
          secondaryText: 'High',
          description: 'This tree is tall',
          imagePath: 'assets/images/lessons/math/comparison/tall_tree.png',
          audioPath: 'assets/audio/math/comp_tall.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_08_page_02',
          title: 'S H O R T SHORT',
          primaryText: 'Short',
          secondaryText: 'Low',
          description: 'This tree is short',
          imagePath: 'assets/images/lessons/math/comparison/short_tree.png',
          audioPath: 'assets/audio/math/comp_short.mp3',
          backgroundColor: '#FFF3E0',
          pageNumber: 2,
        ),
      ],
    );
  }

  // Lesson 9: Simple Addition 1-5
  static Lesson _getLesson9SimpleAddition1to5() {
    return Lesson(
      id: 'math_09',
      lessonNumber: 9,
      title: 'Simple Addition (1-5)',
      subtitle: 'Learn to add small numbers',
      category: 'Math',
      iconPath: 'assets/images/icons/addition_icon.png',
      pages: [
        LessonPage(
          id: 'math_09_page_01',
          title: '1 + 1 = 2',
          primaryText: '1 + 1',
          secondaryText: '= 2',
          description: 'One plus one equals two',
          imagePath: 'assets/images/lessons/math/addition/one_plus_one.png',
          audioPath: 'assets/audio/math/add_1_1.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_09_page_02',
          title: '2 + 1 = 3',
          primaryText: '2 + 1',
          secondaryText: '= 3',
          description: 'Two plus one equals three',
          imagePath: 'assets/images/lessons/math/addition/two_plus_one.png',
          audioPath: 'assets/audio/math/add_2_1.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_09_page_03',
          title: '2 + 2 = 4',
          primaryText: '2 + 2',
          secondaryText: '= 4',
          description: 'Two plus two equals four',
          imagePath: 'assets/images/lessons/math/addition/two_plus_two.png',
          audioPath: 'assets/audio/math/add_2_2.mp3',
          backgroundColor: '#FFF3E0',
          pageNumber: 3,
        ),
        LessonPage(
          id: 'math_09_page_04',
          title: '3 + 1 = 4',
          primaryText: '3 + 1',
          secondaryText: '= 4',
          description: 'Three plus one equals four',
          imagePath: 'assets/images/lessons/math/addition/three_plus_one.png',
          audioPath: 'assets/audio/math/add_3_1.mp3',
          backgroundColor: '#FCE4EC',
          pageNumber: 4,
        ),
        LessonPage(
          id: 'math_09_page_05',
          title: '2 + 3 = 5',
          primaryText: '2 + 3',
          secondaryText: '= 5',
          description: 'Two plus three equals five',
          imagePath: 'assets/images/lessons/math/addition/two_plus_three.png',
          audioPath: 'assets/audio/math/add_2_3.mp3',
          backgroundColor: '#F3E5F5',
          pageNumber: 5,
        ),
      ],
    );
  }

  // Lesson 10: Simple Addition 6-10
  static Lesson _getLesson10SimpleAddition6to10() {
    return Lesson(
      id: 'math_10',
      lessonNumber: 10,
      title: 'Simple Addition (6-10)',
      subtitle: 'Add bigger numbers',
      category: 'Math',
      iconPath: 'assets/images/icons/addition_icon.png',
      pages: [
        LessonPage(
          id: 'math_10_page_01',
          title: '3 + 3 = 6',
          primaryText: '3 + 3',
          secondaryText: '= 6',
          description: 'Three plus three equals six',
          imagePath: 'assets/images/lessons/math/addition/three_plus_three.png',
          audioPath: 'assets/audio/math/add_3_3.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_10_page_02',
          title: '4 + 3 = 7',
          primaryText: '4 + 3',
          secondaryText: '= 7',
          description: 'Four plus three equals seven',
          imagePath: 'assets/images/lessons/math/addition/four_plus_three.png',
          audioPath: 'assets/audio/math/add_4_3.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_10_page_03',
          title: '5 + 3 = 8',
          primaryText: '5 + 3',
          secondaryText: '= 8',
          description: 'Five plus three equals eight',
          imagePath: 'assets/images/lessons/math/addition/five_plus_three.png',
          audioPath: 'assets/audio/math/add_5_3.mp3',
          backgroundColor: '#FFF3E0',
          pageNumber: 3,
        ),
      ],
    );
  }

  // Lesson 11: Simple Subtraction 1-5
  static Lesson _getLesson11SimpleSubtraction1to5() {
    return Lesson(
      id: 'math_11',
      lessonNumber: 11,
      title: 'Simple Subtraction (1-5)',
      subtitle: 'Learn to subtract',
      category: 'Math',
      iconPath: 'assets/images/icons/subtraction_icon.png',
      pages: [
        LessonPage(
          id: 'math_11_page_01',
          title: '2 - 1 = 1',
          primaryText: '2 - 1',
          secondaryText: '= 1',
          description: 'Two minus one equals one',
          imagePath: 'assets/images/lessons/math/subtraction/two_minus_one.png',
          audioPath: 'assets/audio/math/sub_2_1.mp3',
          backgroundColor: '#FCE4EC',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_11_page_02',
          title: '3 - 1 = 2',
          primaryText: '3 - 1',
          secondaryText: '= 2',
          description: 'Three minus one equals two',
          imagePath: 'assets/images/lessons/math/subtraction/three_minus_one.png',
          audioPath: 'assets/audio/math/sub_3_1.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_11_page_03',
          title: '4 - 2 = 2',
          primaryText: '4 - 2',
          secondaryText: '= 2',
          description: 'Four minus two equals two',
          imagePath: 'assets/images/lessons/math/subtraction/four_minus_two.png',
          audioPath: 'assets/audio/math/sub_4_2.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 3,
        ),
        LessonPage(
          id: 'math_11_page_04',
          title: '5 - 2 = 3',
          primaryText: '5 - 2',
          secondaryText: '= 3',
          description: 'Five minus two equals three',
          imagePath: 'assets/images/lessons/math/subtraction/five_minus_two.png',
          audioPath: 'assets/audio/math/sub_5_2.mp3',
          backgroundColor: '#FFF3E0',
          pageNumber: 4,
        ),
      ],
    );
  }

  // Lesson 12: Simple Subtraction 6-10
  static Lesson _getLesson12SimpleSubtraction6to10() {
    return Lesson(
      id: 'math_12',
      lessonNumber: 12,
      title: 'Simple Subtraction (6-10)',
      subtitle: 'Subtract bigger numbers',
      category: 'Math',
      iconPath: 'assets/images/icons/subtraction_icon.png',
      pages: [
      LessonPage(
      id: 'math_12_page_01',
      title: '6 - 3 = 3',
      primaryText: '6 - 3',
      secondaryText: '= 3',
      description: 'Six minus three equals three',
      imagePath: 'assets/images/lessons/math/subtraction/six_minus_three.png',
      audioPath: 'assets/audio/math/sub_6_3.mp3',
      backgroundColor: '#E3F2FD',
      pageNumber: 1,
    ),
    LessonPage(
    id: 'math_12_page_02',
    title: '8 - 4 = 4',
    primaryText: '8 - 4',
    secondaryText: '= 4',
    description: 'Eight minus four equals four',
      imagePath: 'assets/images/lessons/math/subtraction/eight_minus_four.png',
      audioPath: 'assets/audio/math/sub_8_4.mp3',
      backgroundColor: '#E8F5E9',
      pageNumber: 2,
    ),
        LessonPage(
          id: 'math_12_page_03',
          title: '10 - 5 = 5',
          primaryText: '10 - 5',
          secondaryText: '= 5',
          description: 'Ten minus five equals five',
          imagePath: 'assets/images/lessons/math/subtraction/ten_minus_five.png',
          audioPath: 'assets/audio/math/sub_10_5.mp3',
          backgroundColor: '#FFF3E0',
          pageNumber: 3,
        ),
      ],
    );
  }

  // Lesson 13: Number Patterns
  static Lesson _getLesson13NumberPatterns() {
    return Lesson(
      id: 'math_13',
      lessonNumber: 13,
      title: 'Number Patterns',
      subtitle: 'Find the pattern',
      category: 'Math',
      iconPath: 'assets/images/icons/patterns_icon.png',
      pages: [
        LessonPage(
          id: 'math_13_page_01',
          title: 'P A T T E R N PATTERN 1,2,3',
          primaryText: '1, 2, 3',
          secondaryText: 'Counting Up',
          description: 'Numbers go up by one',
          imagePath: 'assets/images/lessons/math/patterns/pattern_123.png',
          audioPath: 'assets/audio/math/pattern_123.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_13_page_02',
          title: 'P A T T E R N PATTERN 10,9,8',
          primaryText: '10, 9, 8',
          secondaryText: 'Counting Down',
          description: 'Numbers go down by one',
          imagePath: 'assets/images/lessons/math/patterns/pattern_1098.png',
          audioPath: 'assets/audio/math/pattern_1098.mp3',
          backgroundColor: '#FCE4EC',
          pageNumber: 2,
        ),
      ],
    );
  }

  // Lesson 14: Skip Counting
  static Lesson _getLesson14SkipCounting() {
    return Lesson(
      id: 'math_14',
      lessonNumber: 14,
      title: 'Skip Counting',
      subtitle: 'Count by 2s, 5s, 10s',
      category: 'Math',
      iconPath: 'assets/images/icons/skip_counting_icon.png',
      pages: [
        LessonPage(
          id: 'math_14_page_01',
          title: 'C O U N T COUNT by 2s',
          primaryText: '2, 4, 6',
          secondaryText: 'Skip Count',
          description: 'Count by twos: 2, 4, 6, 8, 10',
          imagePath: 'assets/images/lessons/math/patterns/skip_2.png',
          audioPath: 'assets/audio/math/skip_2.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_14_page_02',
          title: 'C O U N T COUNT by 5s',
          primaryText: '5, 10, 15',
          secondaryText: 'Skip Count',
          description: 'Count by fives: 5, 10, 15, 20',
          imagePath: 'assets/images/lessons/math/patterns/skip_5.png',
          audioPath: 'assets/audio/math/skip_5.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_14_page_03',
          title: 'C O U N T COUNT by 10s',
          primaryText: '10, 20, 30',
          secondaryText: 'Skip Count',
          description: 'Count by tens: 10, 20, 30, 40',
          imagePath: 'assets/images/lessons/math/patterns/skip_10.png',
          audioPath: 'assets/audio/math/skip_10.mp3',
          backgroundColor: '#FFF3E0',
          pageNumber: 3,
        ),
      ],
    );
  }

  // Lesson 15: Comparing Numbers
  static Lesson _getLesson15ComparingNumbers() {
    return Lesson(
      id: 'math_15',
      lessonNumber: 15,
      title: 'Comparing Numbers',
      subtitle: 'Greater, Less, Equal',
      category: 'Math',
      iconPath: 'assets/images/icons/comparison_icon.png',
      pages: [
        LessonPage(
          id: 'math_15_page_01',
          title: 'G R E A T E R GREATER THAN',
          primaryText: '5 > 3',
          secondaryText: 'Greater',
          description: 'Five is greater than three',
          imagePath: 'assets/images/lessons/math/comparison/greater_than.png',
          audioPath: 'assets/audio/math/greater_than.mp3',
          backgroundColor: '#E8F5E9',
          pageNumber: 1,
        ),
        LessonPage(
          id: 'math_15_page_02',
          title: 'L E S S LESS THAN',
          primaryText: '2 < 7',
          secondaryText: 'Less',
          description: 'Two is less than seven',
          imagePath: 'assets/images/lessons/math/comparison/less_than.png',
          audioPath: 'assets/audio/math/less_than.mp3',
          backgroundColor: '#FCE4EC',
          pageNumber: 2,
        ),
        LessonPage(
          id: 'math_15_page_03',
          title: 'E Q U A L EQUAL TO',
          primaryText: '4 = 4',
          secondaryText: 'Equal',
          description: 'Four equals four',
          imagePath: 'assets/images/lessons/math/comparison/equal_to.png',
          audioPath: 'assets/audio/math/equal_to.mp3',
          backgroundColor: '#E3F2FD',
          pageNumber: 3,
        ),
      ],
    );
  }
}