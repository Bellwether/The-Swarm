(function($) {
  function showValidationErrorMessageDialog() {
    var errors = $('#errors');
    if (errors.length) {
      html = errors.html();
      errors.simpledialog({
        'mode' : 'blank',
        'prompt': false,
        'cleanOnClose': true,
        'forceInput': false,
        'useModal': true,
        'fullHTML' : html,
        'pickPageTheme': 'a'
      })
      errors.html('');
    }	
  }

  $( document ).bind( "pageshow", function( event, data ) {
	showValidationErrorMessageDialog();
  });
})( jQuery );