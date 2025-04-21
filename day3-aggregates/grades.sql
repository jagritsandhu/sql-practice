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
        subjects.name;

-- “Which student has the highest total score across all subjects?”
SELECT st.name,
        SUM(gr.score) AS total_score
FROM students AS st
LEFT JOIN grades AS gr
USING(student_id)
GROUP BY st.name
ORDER BY total_score DESC
LIMIT 1;

-- “Which students scored above the class average overall?”
SELECT st.name,
        SUM(gr.score) AS total_score
FROM students AS st
LEFT JOIN grades AS gr
USING (student_id)
GROUP BY st.name
HAVING total_score  > (SELECT AVG(gr.score) FROM grades AS gr )

-- "Which subjects are underperforming — with an average score less than 75?"
SELECT sub.subject_id,
        sub.name,
        AVG(gr.score) AS avg_score
FROM subjects AS sub
LEFT JOIN grades AS gr
USING(subject_id)
GROUP BY sub.subject_id,
        sub.name
HAVING avg_score < 75;

-- ===========================================
-- CASE & Filtering (Day 4)
-- ===========================================
SELECT 
  s.name,
  g.subject_id,
  g.score,
  CASE 
    WHEN g.score >= 90 THEN 'A'
    WHEN g.score >= 80 THEN 'B'
    WHEN g.score >= 70 THEN 'C'
    WHEN g.score >= 60 THEN 'D'
    ELSE 'F'
  END AS letter_grade
FROM grades AS g
JOIN students AS s ON g.student_id = s.student_id;

-- “Who scored between 60 and 80?”
SELECT s.name,
        g.score
FROM grades AS g
JOIN students AS s ON g.student_id = s.student_id
WHERE g.score BETWEEN 60 AND 80;


-- ===========================================
-- Views & Indexing (Day 5)
-- ===========================================
-- Create a view to show student name, subject, and score
CREATE VIEW student_scores_view AS
SELECT 
  s.name AS student_name,
  sub.name AS subject_name,
  g.score
FROM grades AS g
JOIN students AS s ON g.student_id = s.student_id
JOIN subjects AS sub ON g.subject_id = sub.subject_id;

-- Add index to speed up lookups by student_id
CREATE INDEX idx_student_id ON grades(student_id);