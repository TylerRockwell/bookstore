//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

jQuery(function($) {
  $('#payment-form').submit(function(event) {
    var $form = $(this);
    $form.find('button').prop('disabled', true);
    if ($(".credit-card")[0].style.display != "none"){
      stripeKey = $("#stripe-publishable-key").val();
      Stripe.setPublishableKey(stripeKey);
      Stripe.card.createToken($form, stripeResponseHandler);
      return false;
    }
  });
});

function stripeResponseHandler(status, response) {
  var $form = $('#payment-form');
  if (response.error) {
    $form.find('.payment-errors').text(response.error.message);
    $form.find('button').prop('disabled', false);
  } else {
    var token = response.id;
    // Insert the token into the form so it gets submitted to the server
    $form.append($('<input type="hidden" name="stripeToken" />').val(token));
    $form.get(0).submit();
  }
};

$(document).ready(function() {
  $("#use_saved_card").on("click", toggleCreditCardFields);
});

function toggleCreditCardFields(){
  if ($("#use_saved_card")[0].checked == true) {
    $(".credit-card").hide();
    $(".billing-address").hide();
  }
  else {
    $(".credit-card").show();
    $(".billing-address").show();
  }
}
