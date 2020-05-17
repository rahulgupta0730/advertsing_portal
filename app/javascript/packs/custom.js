// require("bootstrap/package.json"); // bootstrap is a peer dependency. 

// require("jquery/package.json"); // jquery is a peer dependency. 

// require("moment/package.json"); // moment is a peer dependency. 

// require("moment-timezone/package.json"); // moment-timezone is a peer dependency. 
require("pc-bootstrap4-datetimepicker")

$( document ).ready(function() {
	$(function () {
		console.log(moment().format('DD/MM/YYYY'))
    $("#slot_start_time , #slot_end_time").datetimepicker({
    	format: 'DD-MM-YYYY HH:mm',
   	  'minDate': moment(),
    })
  });

  $('#slot_end_time').on('dp.change', function(e){ 
  	if ($("#slot_start_time").val() === ""){
  		alert ("Please select start time first")
  		$("#slot_end_time").val('')
  		return 
  	}
  })
});