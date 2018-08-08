var $  = require( 'jquery' );

require('datatables.net-bs')()
require('datatables.net-buttons-bs')()
require('datatables.net-buttons/js/buttons.colVis.js')()
require('datatables.net-buttons/js/buttons.html5.js')()
require('datatables.net-buttons/js/buttons.print.js')
require('datatables.net-responsive-bs')()
require('datatables.net-select')()

$(".reset_password").click(function(){
  if($('.password').attr('disabled')){
    $('.password').removeAttr('disabled')
    $('.reset_password').text('Cancel')
  } else {
    $('.password').attr('disabled', 'disabled')
    $('.reset_password').text('Reset Password')
  }
});

$('#employee_role').on('change', function() {
  if(employee.is_admin == false && employee.admin_roles.includes(this.value)){
    $('.password').removeAttr('disabled')
    $('.reset_password').addClass('d-none')
  } else if(employee.is_admin == false && employee.admin_roles.includes(this.value) != true) {
    $('.password').attr('disabled', 'disabled')
    $('.reset_password').removeClass('d-none')
    $('.reset_password').text('Reset Password')
  }
})

jQuery(document).ready(function() {
  $('#employee-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "bSort": true,
    "ajax": $('#employee-datatable').data('source'),
    "pagingType": "full_numbers",
    "columns": [
      {"data": "name"},
      {"data": "role"},
      {"data": "grade"},
      {"data": "location"},
      {"data": "profile"},
      {"data": "engagement"},
      {"data": "experience"},
      {"data": "projects"},
      {"data": "skills"},
      {"data": "lead"},
      {"data": "edit"}

    ],
    "columnDefs": [
       { "orderable": false, "targets": [ -1, -2, -3, -4, -5 ] }
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
});