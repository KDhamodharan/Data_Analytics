# NOVA UNIVERSITY – Student Management Module

A Python console application built using Object-Oriented Programming (OOP) for the NOVA UNIVERSITY OOP Application Activity.

## 1. Business Problem

Nova University needs a simple application to maintain student and faculty information and perform basic academic checks. This application supports multiple student and faculty records, attendance eligibility, and academic result calculations.

## 2. Features

- Add and view multiple students
- Store Student ID, name, email, phone, department, attendance, and Python/SQL/Excel marks
- Check examination eligibility (attendance must be **75% or above**)
- Calculate total marks, average, pass/fail result, and grade
- Add and view faculty members
- Validate attendance and marks from 0 to 100
- Handle non-numeric input and invalid menu choices without unexpectedly terminating
- Prevent duplicate student and faculty IDs during a session

## 3. Design Approach

The application uses a class-based design:

| Class | Responsibility |
|---|---|
| `Person` | Abstract base class containing common name, email, and phone information |
| `Student` | Stores student details and provides academic summary |
| `Faculty` | Stores and displays faculty details |
| `AcademicRules` | Reusable attendance, mark, result, total, average, and grade rules |
| `StudentManagementSystem` | Maintains records and provides the console menu |

## 4. OOP Concepts Used

- **Encapsulation:** common person details and student attendance/marks are stored as protected attributes and exposed through properties.
- **Inheritance:** `Student` and `Faculty` inherit common fields and validation from `Person`.
- **Abstraction:** `Person` is an abstract base class with an abstract `display_details()` method.
- **Polymorphism:** both `Student` and `Faculty` implement `display_details()` in their own way.
- **Reusable methods:** `AcademicRules` centralizes academic calculations and business rules.

## 5. Academic Rules

- Attendance range: 0–100
- Exam eligibility: attendance >= 75%
- Each subject mark range: 0–100
- Subjects: Python, SQL, Excel
- Total: sum of the three subject marks (maximum 300)
- Average: total / 3
- Pass: average >= 50; otherwise Fail

### Grade scale

| Average | Grade |
|---:|---|
| 90–100 | A+ |
| 80–89.99 | A |
| 70–79.99 | B |
| 60–69.99 | C |
| 50–59.99 | D |
| Below 50 | F |

The pass/fail decision is based on the assignment's average-mark rule. Attendance eligibility is shown separately.

## 6. Requirements

- Python 3.8 or later
- No external packages required
- No database, API, GUI, or framework required

## 7. How to Run

1. Download or clone this repository.
2. Open a terminal in the project folder.
3. Run:

```bash
python main.py
```

On some systems, use:

```bash
python3 main.py
```

## 8. Menu

```text
1. Add Student
2. View Students
3. Check Attendance Eligibility
4. View Academic Result
5. Add Faculty
6. View Faculty
0. Exit
```

## 9. Sample Academic Calculation

Example input:

- Attendance: 80
- Python: 80
- SQL: 70
- Excel: 90

Expected calculation:

- Total = 80 + 70 + 90 = 240 / 300
- Average = 240 / 3 = 80.00%
- Result = PASS
- Grade = A
- Exam eligibility = Eligible (80% attendance)

## 10. Validation and Testing

Run the automated tests with:

```bash
python -m unittest -v
```

The test file checks attendance boundaries (0, 75, 100), invalid attendance (-5, 105), mark validation, academic calculations, pass/fail, grade, and student/faculty inheritance and display methods.

Also manually test the console application with:
- A non-numeric value at a numeric prompt
- Attendance below 0 or above 100
- Marks below 0 or above 100
- An invalid menu option
- A repeated student or faculty ID

## 11. Current Data Storage

Records are maintained in memory while the program is running. They are cleared when the application exits. Persistent database or file storage was not part of the supplied assignment requirements.

## 12. GitHub Submission

Repository name: **`nova-university-oop`**

Suggested repository structure:

```text
nova-university-oop/
├── main.py
├── test_main.py
├── README.md
└── .gitignore
```

### Upload using Git

Create a new GitHub repository named `nova-university-oop`, then run these commands inside this project folder:

```bash
git init
git add .
git commit -m "Complete Nova University OOP Student Management Module"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/nova-university-oop.git
git push -u origin main
```

Replace `YOUR-USERNAME` with your GitHub username. If GitHub asks you to authenticate, complete the sign-in process.

## 13. Assignment Checklist

- [x] Student information
- [x] Faculty information
- [x] Multiple records during one run
- [x] Academic information display
- [x] Total, average, result, and grade
- [x] Attendance eligibility at 75%
- [x] Attendance and mark validation
- [x] Invalid numeric input handling
- [x] OOP design
- [x] README documentation
- [x] Automated test cases
