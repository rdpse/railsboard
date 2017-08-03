row = $("<%= j render partial: 'resposta', object: @resposta %>").hide();
$('#respostas').append(row);
row.show('slow');

$('#collapseOne1').removeClass('in');
$('#resposta-texto').val('');
