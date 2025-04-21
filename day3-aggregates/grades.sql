-- Students table
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    name TEXT
);

-- Sample Students
INSERT INTO students VALUES (1, 'Alice');
INSERT INTO students VALUES (2, 'Bob');
INSERT INTO students VALUES (3, 'Charlie');
INSERT INTO students VALUES (4, 'Dana');
INSERT INTO students VALUES (5, 'Eve');

-- Subjects table
CREATE TABLE subjects (
  subject_id INTEGER PRIMARY KEY,
  name TEXT
);

-- Sample subjects
INSERT INTO subjects VALUES (101, 'Math');
INSERT INTO subjects VALUES (102, 'Science');
INSERT INTO subjects VALUES (103, 'History');
INSERT INTO subjects VALUES (104, 'English');

-- Grades table (the scores students earned in subjects)
CREATE TABLE grades (
  student_id INTEGER,
  subject_id INTEGER,
  score INTEGER,
  FOREIGN KEY(student_id) REFERENCES students(student_id),
  FOREIGN KEY(subject_id) REFERENCES subjects(subject_id)
);

-- Sample grades
INSERT INTO grades VALUES (1, 101, 85);  -- Alice - Math
INSERT INTO grades VALUES (1, 102, 92);  -- Alice - Science
INSERT INTO grades VALUES (2, 101, 76);  -- Bob - Math
INSERT INTO grades VALUES (2, 104, 88);  -- Bob - English
INSERT INTO grades VALUES (3, 103, 90);  -- Charlie - History
INSERT INTO grades VALUES (3, 104, 67);  -- Charlie - English
INSERT INTO grades VALUES (4, 102, 73);  -- Dana - Science
INSERT INTO grades VALUES (4, 101, 95);  -- Dana - Math
INSERT INTO grades VALUES (5, 104, 58);  -- Eve - English

--AGGREGATION
-- What is the average score in each subject?”
SELECT subjects.subject_id,
        subjects.name,
        AVG(gr.score)
FROM subjects
LEFT JOIN grades AS gr
USING (subject_id)
GROUP BY subjects.subject_id,
        subjects.name

-- “Which student has the highest total score across all subjects?”
