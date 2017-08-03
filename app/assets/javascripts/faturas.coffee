# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  id = $('.right_col').data('fatura-id');
  vias_de_pagamento = $('#fatura_via_de_pagamento').html()
  $('#fatura_via_de_pagamento').change -> 
    via = $('#fatura_via_de_pagamento :selected').val()
    $.ajax 
      url: "/faturas/#{id}/update_via"
      type: 'POST'
      dataType: 'script'
      data: {
        via_de_pagamento: via
      }

