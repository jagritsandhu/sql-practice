-- Students table
-- Students table
CREATE TABLE students (
  student_id INTEGER PRIMARY KEY,
  name TEXT
);

-- Sample data
INSERT INTO students VALUES (1, 'Alice');
INSERT INTO students VALUES (2, 'Bob');
INSERT INTO students VALUES (3, 'Charlie');
INSERT INTO students VALUES (4, 'Dana');

-- Classes table
CREATE TABLE classes (
  class_id INTEGER PRIMARY KEY,
  subject TEXT
);

-- Sample data
INSERT INTO classes VALUES (101, 'Math');
INSERT INTO classes VALUES (102, 'History');
INSERT INTO classes VALUES (103, 'Biology');
INSERT INTO classes VALUES (104, 'Computer Science');

-- Enrollments table (many-to-many relationship)
CREATE TABLE enrollments (
  student_id INTEGER,
  class_id INTEGER,
  FOREIGN KEY(student_id) REFERENCES students(student_id),
  FOREIGN KEY(class_id) REFERENCES classes(class_id)
);

-- Sample enrollments
INSERT INTO enrollments VALUES (1, 101); -- Alice in Math
INSERT INTO enrollments VALUES (1, 104); -- Alice in CS
INSERT INTO enrollments VALUES (2, 102); -- Bob in History
INSERT INTO enrollments VALUES (3, 101); -- Charlie in Math
INSERT INTO enrollments VALUES (3, 103); -- Charlie in Bio
INSERT INTO enrollments VALUES (4, 104); -- Dana in CS
