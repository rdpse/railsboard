row = $("<%= j render partial: 'servidor', locals: { host: @host } %>");
$('.servidor').html(row);
