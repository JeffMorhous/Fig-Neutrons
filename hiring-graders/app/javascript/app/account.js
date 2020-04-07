
$( document ).ready(function() {
  $('input[type=radio][name=roleRegister]').change(function() {
    if(this.value.toUpperCase() == 'INSTRUCTOR') {
      this.parentElement.parentElement.action = '/instructor/create';
    } else if (this.value.toUpperCase() == "STUDENT") {
      this.parentElement.parentElement.action = '/student/create';
    }
  });

  $('input[type=radio][name=roleLogin]').change(function() {
    if(this.value.toUpperCase() == 'INSTRUCTOR') {
      this.parentElement.parentElement.action = '/instructor/login';
    } else if (this.value.toUpperCase() == 'STUDENT') {
      this.parentElement.parentElement.action = '/student/login';
    } else if (this.value.toUpperCase() == 'ADMIN') {
      this.parentElement.parentElement.action = '/admin/login';
    }
  });
})