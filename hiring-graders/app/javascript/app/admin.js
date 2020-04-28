// displayApplicant = function(student){
// 	document.getElementById("Focus").innerHTML = student.section_number;
// }


$( document ).on('turbolinks:load', function() {
  $("#tableFilterText").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    if($(".semesterSelect").val()) {
      $("#courseTable tr").filter(function() {

        if($(this).text().toLowerCase().indexOf(value) > -1 && $(this).text().toLowerCase().indexOf($(".semesterSelect").val().toLowerCase()) > -1  ) {
          $(this).toggle(true);
        }
        else {
          $(this).toggle(false)
        }
      });
    } else {
      $("#courseTable tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    }
    
  });

  $(".semesterSelect").change(function() {
    const elem = $(this);
    const sem = elem.val();
    var value = $("#tableFilterText").val().toLowerCase();
    if(value.length > 0) {
      $("#courseTable tr").filter(function() {

        if($(this).text().toLowerCase().indexOf(value) > -1 && $(this).text().toLowerCase().indexOf(sem.toLowerCase()) > -1  ) {
          $(this).toggle(true);
        }
        else {
          $(this).toggle(false)
        }
      });
    } else {
      $("#courseTable tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(sem.toLowerCase()) > -1)
      });
    }
    
  })

})

getCourses = function () {
  var confirmation = confirm("This will rescrape the course website and clear all currently assgined graders. Are you sure you want to contine?")
  if(confirmation) {
    const semesterData = {
      sem: $(".semesterSelect").val()
    }
    $("#cTable").toggle();
    $("#spinner").toggle();

    $.ajax({ 
      type: 'GET', 
      url: '/admin/get_courses', 
      data: semesterData, 
      success: function(data){
        location.reload();
      } 
    });
  }
  
}