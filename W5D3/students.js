function Student(firstName, lastName){
  this.firstName = firstName;
  this.lastName = lastName;
  this.enrolled_courses = [];
}

Student.prototype.name = function(){
  return `${this.firstName} ${this.lastName}`;
};

Student.prototype.courses = function(){
  return this.enrolled_courses;
};

Student.prototype.enroll = function(course){
  if (!this.hasConflict(course)){
    this.enrolled_courses.push(course);
    course.enrolled_students.push(this);
  }
};

Student.prototype.courseLoad = function(){
  const hash = {};
  this.courses().forEach(course => {
    if (hash[course.dept] === undefined){
      hash[course.dept] = course.creds;
    } else {
      hash[course.dept] += course.creds;
    }
  });
  return hash;
};

Student.prototype.hasConflict = function(otherCourse) {
  this.courses().forEach(course => {
    if (course.conflictsWith(otherCourse)) {
      return true;
    }
  });

  return false;
};

function Course(name, dept, creds, days, block){
  this.name = name;
  this.dept = dept;
  this.creds = creds;
  this.days = days;
  this.block = block;
  this.enrolled_students = [];
}

Course.prototype.students = function(){
  return this.enrolled_students;
};

Course.prototype.addStudent = function(student){
  student.enroll(this);
};

Course.prototype.conflictsWith = function(other) {
  let conflict = false;
  if (this.block === other.block) {
    this.days.forEach(day => {
      if (other.days.includes(day)) {
        conflict = true;
      }
    });
  }

  return conflict;
};
