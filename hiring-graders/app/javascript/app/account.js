/**
 * Change the form action of the sign up or login form based on the
 * selected radio button
 */
setAccountFormAction = function(element) {
  if(element.name.toUpperCase() ===  'ROLEREGISTER') {
    if(element.value.toUpperCase() === 'STUDENT') {
      element.parentElement.parentElement.action = '/student/create';
    } else if (element.value.toUpperCase() === 'INSTRUCTOR') {
      element.parentElement.parentElement.action = '/instructor/create';
    }
  } else if(element.name.toUpperCase() === "ROLELOGIN") {
    if(element.value.toUpperCase() === 'STUDENT') {
      element.parentElement.parentElement.action = '/student/login';
    } else if (element.value.toUpperCase() === 'INSTRUCTOR') {
      element.parentElement.parentElement.action = '/instructor/login';
    } else if (element.value.toUpperCase() === 'ADMIN') {
      element.parentElement.parentElement.action = '/admin/login';
    }
    
  }
  console.log(element.parentElement.parentElement);
}