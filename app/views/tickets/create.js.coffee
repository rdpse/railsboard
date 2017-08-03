erros = $("<%= j render partial: 'shared/erros', object: @ticket %>").hide();
$('#erros-ticket').html(erros);

erros.show('fast');

