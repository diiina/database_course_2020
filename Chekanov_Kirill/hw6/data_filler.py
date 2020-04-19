import mysql.connector
import factory
from factory import fuzzy
from random import randint
import time
import random

# utils
def str_time_prop(start, end, format, prop):
    """Get a time at a proportion of a range of two formatted times.

    start and end should be strings specifying times formated in the
    given format (strftime-style), giving an interval [start, end].
    prop specifies how a proportion of the interval to be taken after
    start.  The returned time will be in the specified format.
    """

    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + prop * (etime - stime)

    return time.strftime(format, time.localtime(ptime))

mydb = mysql.connector.connect(
  host="localhost",
  user="test_user",
  passwd="12345",
  database="fizra"
)


SPEC_NUMBER = 0
SPECIALIZATIONS = [
        "basketball",
        "OFP",
        "football",
        "volleyball",
        "skiing",
        "athletics",
        "special med. group"
    ]
SEMESTER_NUMBER = 0
INSTRUCTORS_NUMBER = 0
STUDENTS_NUMBER = 0

def generate_specialisation():
    global SPEC_NUMBER
    mycursor = mydb.cursor()

    val = []
    for spec in SPECIALIZATIONS:
        val.append((spec, ))

    SPEC_NUMBER = len(val)

    sql = "INSERT INTO specialization (name) VALUES (%s)"
    mycursor.executemany(sql, val)


def fill_students(n):
    global SPEC_NUMBER, STUDENTS_NUMBER
    STUDENTS_NUMBER = n
    mycursor = mydb.cursor()
    sql = "INSERT INTO students (specialization_id, first_name, last_name, email, studak_number) VALUES (%s, %s, %s, %s, %s)"

    val = []
    for _ in range(n):
        val.append((
            str(randint(0, SPEC_NUMBER - 1) + 1),
            str(factory.Faker('first_name').generate()),
            str(factory.Faker('last_name').generate()),
            str(factory.Faker('email').generate()),
            str(randint(100000, 999999))
        ))

    mycursor.executemany(sql, val)

def fill_instructors(n):
    global INSTRUCTORS_NUMBER
    INSTRUCTORS_NUMBER = n
    mycursor = mydb.cursor()
    sql = "INSERT INTO instructors (first_name, last_name, email) VALUES (%s, %s, %s)"

    val = []
    for _ in range(n):
        val.append((
            str(factory.Faker('first_name').generate()),
            str(factory.Faker('last_name').generate()),
            str(factory.Faker('email').generate()),
        ))

    mycursor.executemany(sql, val)

def fill_semesters():
    global SEMESTER_NUMBER
    mycursor = mydb.cursor()
    sql = "INSERT INTO semester (semester_start, semester_end) VALUES (%s, %s)"

    val = [
        ("2019-09-01", "2020-01-30"),
        ("2019-02-04", "2019-06-30"),
    ]
    SEMESTER_NUMBER = len(val)
    mycursor.executemany(sql, val)

def fill_spec_to_instructors():
    global INSTRUCTORS_NUMBER, SPEC_NUMBER
    mycursor = mydb.cursor()
    sql = "INSERT INTO spec_to_insructors (instructor_id, specialization_id) VALUES (%s, %s)"
    val = []
    for spec_id in range(1, SPEC_NUMBER):
        for _ in range(4):
            val.append(
                (randint(0, INSTRUCTORS_NUMBER - 1) + 1,
                    spec_id)
            )
    mycursor.executemany(sql, val)


def fill_lesson():
    global SPEC_NUMBER, INSTRUCTORS_NUMBER
    mycursor = mydb.cursor()
    sql = "INSERT INTO lesson (instructor_id, week_day, lesson_time, specialization_id) VALUES (%s, %s, %s, %s)"

    week_days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
    lesson_time = ['9.00 - 10.25', '10.45 - 12.10', '13.55 - 15.20', '15.30 - 16.55', '17.05 - 18.30']
    val = []
    for day in week_days[:len(week_days) - 1]:
        for time in lesson_time:
            for spec_id in range(1,SPEC_NUMBER+1):
                val.append((
                    # TODO: add instructors that have this specialization
                    randint(0, INSTRUCTORS_NUMBER - 1) + 1,
                    day,
                    time,
                    spec_id
                ))

    mycursor.executemany(sql, val)


def random_date(start, end, prop):
    return str_time_prop(start, end, '%Y-%m-%d', prop)

def fill_visits():
    global STUDENTS_NUMBER, SPEC_NUMBER
    mycursor = mydb.cursor()
    sql = "INSERT INTO visit (user_id, lesson_id, visit_date ) VALUES (%s, %s, %s)"
    val = []
    # 20 visits per semester in average
    for _ in range(STUDENTS_NUMBER * 20):
        val.append((
            randint(0, STUDENTS_NUMBER - 1) + 1,
            randint(1, 6 * 5 * SPEC_NUMBER), # TODO: add check that student go on his spec
            "2019-10-10" # TODO: generate random time
        ))

    mycursor.executemany(sql, val)

def fill_student_schedule():
    global STUDENTS_NUMBER, SPEC_NUMBER
    mycursor = mydb.cursor()
    sql = "INSERT INTO student_schedule (student_id, pair_id, semester_id ) VALUES (%s, %s, %s)"
    val = []
    for i in range(1, STUDENTS_NUMBER + 1):
        for _ in range(2): # two lessons
            val.append((
                i,
                randint(1, 6 * 5 * SPEC_NUMBER),
                2,
            ))
    mycursor.executemany(sql, val)

if __name__ == "__main__":
    generate_specialisation()
    mydb.commit()
    fill_students(100)
    fill_instructors(20)
    fill_semesters()
    fill_spec_to_instructors()
    fill_lesson()
    fill_visits()
    fill_student_schedule()
    mydb.commit()
