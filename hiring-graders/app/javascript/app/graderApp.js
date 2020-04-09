/**
 * Add a new row to the form to fill out grades
 */
addGradeRow = function () {

  const graderAppForm = $('.form-group div.gradeRow:last').parent()
  let numClasses = $('.form-group .gradeRow').length + 1;
  let gradeRow = $('.form-group .gradeRow:last').clone();
  gradeRow.find(".courseNum")[0].name = `courseNum${(numClasses)}`;
  gradeRow.find(".grade")[0].name = `grade${(numClasses)}`;
  gradeRow.appendTo(graderAppForm);
  $('.form-group .gradeRow .classAddIcon').each(function(){
    $(this).css("display","none");
  })
  $('.form-group .gradeRow .classAddIcon:last').each(function(){
    $(this).css("display","block");
  })

}