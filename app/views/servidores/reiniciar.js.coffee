notificacao = $("<%= j render partial: 'notificacao', locals: { flash: flash } %>").hide();
$(".servidor").before(notificacao);
notificacao.show('slow').delay(8500).fadeOut();
