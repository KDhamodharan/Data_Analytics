"""
NOVA UNIVERSITY - Student Management Module
Python OOP Console Application

Run: python main.py
"""

from abc import ABC, abstractmethod


class Person(ABC):
    """Base class for people in the university."""

    def __init__(self, name, email, phone):
        self._name = self._validate_text(name, "Name")
        self._email = self._validate_email(email)
        self._phone = self._validate_phone(phone)

    @staticmethod
    def _validate_text(value, field):
        value = str(value).strip()
        if not value:
            raise ValueError(f"{field} cannot be empty.")
        return value

    @staticmethod
    def _validate_email(email):
        email = str(email).strip()
        if "@" not in email or "." not in email.split("@")[-1]:
            raise ValueError("Please enter a valid email address.")
        return email

    @staticmethod
    def _validate_phone(phone):
        phone = str(phone).strip()
        digits = phone.replace("+", "").replace("-", "").replace(" ", "")
        if not digits.isdigit() or len(digits) < 7:
            raise ValueError("Please enter a valid phone number (at least 7 digits).")
        return phone

    @property
    def name(self):
        return self._name

    @property
    def email(self):
        return self._email

    @property
    def phone(self):
        return self._phone

    @abstractmethod
    def display_details(self):
        """Display role-specific details."""
        raise NotImplementedError


class AcademicRules:
    """Reusable academic calculations and business rules."""

    PASS_AVERAGE = 50
    EXAM_ATTENDANCE = 75

    @staticmethod
    def validate_attendance(attendance):
        attendance = float(attendance)
        if not 0 <= attendance <= 100:
            raise ValueError("Attendance must be between 0 and 100.")
        return attendance

    @staticmethod
    def validate_mark(mark, subject):
        mark = float(mark)
        if not 0 <= mark <= 100:
            raise ValueError(f"{subject} mark must be between 0 and 100.")
        return mark

    @staticmethod
    def calculate_total(marks):
        return sum(marks.values())

    @staticmethod
    def calculate_average(marks):
        return AcademicRules.calculate_total(marks) / len(marks)

    @staticmethod
    def get_result(average):
        return "PASS" if average >= AcademicRules.PASS_AVERAGE else "FAIL"

    @staticmethod
    def get_grade(average):
        if average >= 90:
            return "A+"
        if average >= 80:
            return "A"
        if average >= 70:
            return "B"
        if average >= 60:
            return "C"
        if average >= 50:
            return "D"
        return "F"

    @staticmethod
    def is_exam_eligible(attendance):
        return attendance >= AcademicRules.EXAM_ATTENDANCE


class Student(Person):
    """Student record with academic information."""

    SUBJECTS = ("Python", "SQL", "Excel")

    def __init__(self, student_id, name, email, phone, department,
                 attendance, python_mark, sql_mark, excel_mark):
        super().__init__(name, email, phone)
        self.student_id = Person._validate_text(student_id, "Student ID")
        self.department = Person._validate_text(department, "Department")
        self._attendance = AcademicRules.validate_attendance(attendance)
        self._marks = {
            "Python": AcademicRules.validate_mark(python_mark, "Python"),
            "SQL": AcademicRules.validate_mark(sql_mark, "SQL"),
            "Excel": AcademicRules.validate_mark(excel_mark, "Excel"),
        }

    @property
    def attendance(self):
        return self._attendance

    @property
    def marks(self):
        return self._marks.copy()

    def academic_summary(self):
        total = AcademicRules.calculate_total(self._marks)
        average = AcademicRules.calculate_average(self._marks)
        return {
            "total": total,
            "average": average,
            "result": AcademicRules.get_result(average),
            "grade": AcademicRules.get_grade(average),
            "eligible": AcademicRules.is_exam_eligible(self._attendance),
        }

    def display_details(self):
        summary = self.academic_summary()
        print("\n" + "-" * 55)
        print(f"STUDENT ID : {self.student_id}")
        print(f"Name       : {self.name}")
        print(f"Email      : {self.email}")
        print(f"Phone      : {self.phone}")
        print(f"Department : {self.department}")
        print(f"Attendance : {self.attendance:.2f}%")
        print("Marks      : " + ", ".join(
            f"{subject}={mark:g}" for subject, mark in self._marks.items()
        ))
        print(f"Total      : {summary['total']:g} / 300")
        print(f"Average    : {summary['average']:.2f}%")
        print(f"Result     : {summary['result']}")
        print(f"Grade      : {summary['grade']}")
        print("Exam       : " + ("Eligible" if summary["eligible"] else "Not eligible"))
        print("-" * 55)


class Faculty(Person):
    """Faculty member record."""

    def __init__(self, faculty_id, name, email, phone, department, subject):
        super().__init__(name, email, phone)
        self.faculty_id = Person._validate_text(faculty_id, "Faculty ID")
        self.department = Person._validate_text(department, "Department")
        self.subject = Person._validate_text(subject, "Subject")

    def display_details(self):
        print("\n" + "-" * 45)
        print(f"FACULTY ID : {self.faculty_id}")
        print(f"Name       : {self.name}")
        print(f"Email      : {self.email}")
        print(f"Phone      : {self.phone}")
        print(f"Department : {self.department}")
        print(f"Subject    : {self.subject}")
        print("-" * 45)


class StudentManagementSystem:
    """Manages student and faculty records."""

    def __init__(self):
        self.students = {}
        self.faculty_members = {}

    @staticmethod
    def _read_non_empty(prompt):
        while True:
            value = input(prompt).strip()
            if value:
                return value
            print("Input cannot be empty. Please try again.")

    @staticmethod
    def _read_number(prompt):
        while True:
            try:
                return float(input(prompt).strip())
            except ValueError:
                print("Invalid input. Please enter a numeric value.")

    @classmethod
    def _read_range(cls, prompt, minimum, maximum, field):
        while True:
            value = cls._read_number(prompt)
            if minimum <= value <= maximum:
                return value
            print(f"{field} must be between {minimum} and {maximum}.")

    def add_student(self):
        print("\n--- ADD STUDENT ---")
        student_id = self._read_non_empty("Student ID: ")
        if student_id in self.students:
            print("A student with this ID already exists.")
            return
        name = self._read_non_empty("Name: ")
        email = self._read_non_empty("Email: ")
        phone = self._read_non_empty("Phone: ")
        department = self._read_non_empty("Department: ")
        attendance = self._read_range("Attendance (0-100): ", 0, 100, "Attendance")
        python_mark = self._read_range("Python mark (0-100): ", 0, 100, "Python mark")
        sql_mark = self._read_range("SQL mark (0-100): ", 0, 100, "SQL mark")
        excel_mark = self._read_range("Excel mark (0-100): ", 0, 100, "Excel mark")

        try:
            student = Student(student_id, name, email, phone, department,
                              attendance, python_mark, sql_mark, excel_mark)
            self.students[student_id] = student
            print(f"Student '{name}' added successfully.")
        except ValueError as error:
            print(f"Could not add student: {error}")

    def view_students(self):
        if not self.students:
            print("\nNo student records found.")
            return
        print(f"\nTotal students: {len(self.students)}")
        for student in self.students.values():
            student.display_details()

    def check_attendance(self):
        student_id = self._read_non_empty("Enter Student ID: ")
        student = self.students.get(student_id)
        if not student:
            print("Student ID not found.")
            return
        status = "ELIGIBLE" if AcademicRules.is_exam_eligible(student.attendance) else "NOT ELIGIBLE"
        print(f"{student.name} - Attendance: {student.attendance:.2f}% - {status}")

    def view_academic_result(self):
        student_id = self._read_non_empty("Enter Student ID: ")
        student = self.students.get(student_id)
        if not student:
            print("Student ID not found.")
            return
        summary = student.academic_summary()
        print(f"\nAcademic Result - {student.name} ({student.student_id})")
        print(f"Python: {student.marks['Python']:g}")
        print(f"SQL   : {student.marks['SQL']:g}")
        print(f"Excel : {student.marks['Excel']:g}")
        print(f"Total: {summary['total']:g}/300 | Average: {summary['average']:.2f}%")
        print(f"Result: {summary['result']} | Grade: {summary['grade']}")

    def add_faculty(self):
        print("\n--- ADD FACULTY ---")
        faculty_id = self._read_non_empty("Faculty ID: ")
        if faculty_id in self.faculty_members:
            print("A faculty member with this ID already exists.")
            return
        name = self._read_non_empty("Name: ")
        email = self._read_non_empty("Email: ")
        phone = self._read_non_empty("Phone: ")
        department = self._read_non_empty("Department: ")
        subject = self._read_non_empty("Subject: ")
        try:
            faculty = Faculty(faculty_id, name, email, phone, department, subject)
            self.faculty_members[faculty_id] = faculty
            print(f"Faculty member '{name}' added successfully.")
        except ValueError as error:
            print(f"Could not add faculty: {error}")

    def view_faculty(self):
        if not self.faculty_members:
            print("\nNo faculty records found.")
            return
        print(f"\nTotal faculty members: {len(self.faculty_members)}")
        for faculty in self.faculty_members.values():
            faculty.display_details()

    def run(self):
        menu = {
            "1": ("Add Student", self.add_student),
            "2": ("View Students", self.view_students),
            "3": ("Check Attendance Eligibility", self.check_attendance),
            "4": ("View Academic Result", self.view_academic_result),
            "5": ("Add Faculty", self.add_faculty),
            "6": ("View Faculty", self.view_faculty),
        }
        while True:
            print("\n" + "=" * 55)
            print("             NOVA UNIVERSITY")
            print("          STUDENT MANAGEMENT MODULE")
            print("=" * 55)
            for key, (label, _) in menu.items():
                print(f"{key}. {label}")
            print("0. Exit")
            choice = input("Enter your choice: ").strip()

            if choice == "0":
                print("Thank you for using Nova University Student Management Module.")
                break
            action = menu.get(choice)
            if action:
                try:
                    action[1]()
                except (EOFError, KeyboardInterrupt):
                    print("\nInput interrupted. Returning to menu.")
            else:
                print("Invalid menu choice. Please select 0 to 6.")


if __name__ == "__main__":
    StudentManagementSystem().run()
