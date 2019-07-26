$(document).ready(function() {
  var html = $('h1').html();
  var ret = "";
  var rando = 0;

  $.each(html.split(''), function(k, v) {
    rando = Math.floor(Math.random() * 7) + 1
    ret += '<span class="lights-' + rando + '">' + v + '</span>';
  });

  $('h1').html(ret);
});