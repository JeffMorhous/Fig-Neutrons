// displayApplicant = function(student){
// 	document.getElementById("Focus").innerHTML = student.section_number;
// }


$( document ).on('turbolinks:load', function() {
  $("#tableFilterText").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#courseTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });

})