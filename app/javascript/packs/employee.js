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