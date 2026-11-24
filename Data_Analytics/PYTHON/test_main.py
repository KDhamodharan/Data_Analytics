import unittest

from main import AcademicRules, Faculty, Person, Student


class TestAcademicRules(unittest.TestCase):
    def test_attendance_boundaries(self):
        for value in (0, 75, 100):
            self.assertEqual(AcademicRules.validate_attendance(value), float(value))

    def test_invalid_attendance(self):
        for value in (-5, 105):
            with self.assertRaises(ValueError):
                AcademicRules.validate_attendance(value)

    def test_attendance_eligibility(self):
        self.assertTrue(AcademicRules.is_exam_eligible(75))
        self.assertFalse(AcademicRules.is_exam_eligible(74.99))

    def test_mark_validation(self):
        self.assertEqual(AcademicRules.validate_mark(100, "Python"), 100.0)
        for value in (-1, 101):
            with self.assertRaises(ValueError):
                AcademicRules.validate_mark(value, "Python")

    def test_academic_calculation_and_grade(self):
        marks = {"Python": 80, "SQL": 70, "Excel": 90}
        self.assertEqual(AcademicRules.calculate_total(marks), 240)
        self.assertEqual(AcademicRules.calculate_average(marks), 80)
        self.assertEqual(AcademicRules.get_result(80), "PASS")
        self.assertEqual(AcademicRules.get_grade(80), "A")

    def test_fail_result(self):
        self.assertEqual(AcademicRules.get_result(49.99), "FAIL")
        self.assertEqual(AcademicRules.get_grade(49.99), "F")


class TestPeople(unittest.TestCase):
    def test_student_inherits_person(self):
        student = Student("S001", "Anu", "anu@example.com", "9876543210",
                          "Computer Science", 75, 80, 70, 90)
        self.assertIsInstance(student, Person)
        self.assertEqual(student.academic_summary()["average"], 80)

    def test_faculty_inherits_person(self):
        faculty = Faculty("F001", "Ravi", "ravi@example.com", "9876543211",
                          "Computer Science", "Python")
        self.assertIsInstance(faculty, Person)
        self.assertEqual(faculty.subject, "Python")

    def test_invalid_email(self):
        with self.assertRaises(ValueError):
            Student("S002", "Test", "not-an-email", "9876543210",
                    "IT", 75, 50, 50, 50)


if __name__ == "__main__":
    unittest.main()
