$(document).ready(function() {

var show_error, stripeResponseHandler, submitHandler;

submitHandler = function (event) {

var $form = $(event.target);

$form.find("input[type=submit]").prop("disabled", true);

//If Stripe was initialized correctly this will create a token using the credit card info

if(Stripe){

Stripe.card.createToken($form, stripeResponseHandler);

} else {

show_error("Failed to load credit card processing functionality. Please reload this page in your browser.")

}

return false;

};

$(".cc_form").on('submit', submitHandler);

stripeResponseHandler = function (status, response) {

var token, $form;

$form = $('.cc_form');

if (response.error) {
$('#stripe').show();
$('#stripe').text(response.error.message);

$form.find("input[type=submit]").prop("disabled", false);

} else {

token = response.id;

$form.append($("<input type=\"hidden\" name=\"payment[token]\" />").val(token));

$("[data-stripe=number]").remove();

$("[data-stripe=cvv]").remove();

$("[data-stripe=exp-year]").remove();

$("[data-stripe=exp-month]").remove();

$("[data-stripe=label]").remove();

$form.get(0).submit();

}

return false;

};

});