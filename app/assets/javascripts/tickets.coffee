# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#$ ->
  #id = $('.right_col').data('ticket-id');
  #$('#responder-ticket-botao').click -> 
    #resposta = $('#resposta-texto').val()
    #$.ajax 
      #url: "/atendimento/#{id}"
      #type: 'POST'
      #dataType: 'script'
      #data: {
        #ticket_resposta: resposta
      #}
      #
$(window).ready ->
  $('html, body').animate scrollTop: $(document).height()

  $('#accordion1').on 'shown.bs.collapse', '.panel', (e) ->
    $('html,body').animate { scrollTop: $(this).offset().top }, 500
