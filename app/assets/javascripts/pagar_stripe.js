$(document).ready(function() {
  $("#pagar_stripe").submit(function(event) {
    $('#pagar-stripe-botao').attr("disabled", "disabled");
    $('#cc-spinner').show();
 
		Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
		Stripe.card.createToken({
			number: $('#numero_cartao').val(),
			cvc: $('#cvv_cartao').val(),
			exp: $('#validade_cartao').val(),
		}, stripeResponseHandler);

 
    // prevent the form from submitting with the default action
    return false;
  });
});

function stripeResponseHandler(status, response) {

  // Grab the form:
  var $form = $('#pagar_stripe');

  if (response.error) { // Problem!

		 var errorMessages = {
			incorrect_number: "O número do cartão está incorreto.",
			invalid_number: "O número do cartão é inválido.",
			invalid_expiry_month: "O mês de expiração do cartão é inválido.",
			invalid_expiry_year: "O ano de expiração do cartão é inválido.",
			invalid_cvc: "O código de segurança do cartão é inválido.",
			expired_card: "O seu cartão expirou.",
			incorrect_cvc: "O código de segurança do cartão é inválido.",
			incorrect_zip: "O código postal que introduziu está incorreto.",
			card_declined: "O seu cartão de crédito foi rejeitado.",
			missing: "Não foi possível encontrar um cartão associado à sua conta de cliente.",
			processing_error: "Ocorreu um erro aquando do processamento do seu cartão.",
			rate_limit:  "Atingiu o limite de tentivas de pagamento. Por favor aguarde e depois tente novamente."
		};
  
    function show_error (message) {
			$("#stripe_error").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">×</a><div id="flash_alert" style="color: #fefefe;">' + message + '</div></div>');
			$('.alert').delay(6500).fadeOut(3000);
			return false;
    };

    // Show the errors on the form
    $('#cc-spinner').hide();
    show_error(errorMessages[response.error.code]); 
    $('#pagar-stripe-botao').attr("disabled", false); // Re-enable submission

  } else { // Token was created!

    // Get the token ID:
    var token = response.id;


    // Insert the token into the form so it gets submitted to the server:
    $form.append($('<input type="hidden" name="card_token" />').val(token));
      $("[data-stripe=number]").val('');
      $("[data-stripe=cvc]").val('');
      $("[data-stripe=exp]").val('');

    
     
    // Submit the form:
    $form.get(0).submit();

  }
}
