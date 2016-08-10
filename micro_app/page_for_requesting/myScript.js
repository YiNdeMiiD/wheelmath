$(document).ready(function() {

  $(".lat-input").keyup(function() {
    forceCorrectValue(".lat-input");
  });

  $(".long-input").keyup(function() {
    forceCorrectValue(".long-input");
  });

  function forceCorrectValue(el) {
    if ( !(/^\d+?\.?(\d+)?$/.test($(el).val())) ) {$(el).val( $(el).val().substr(0, $(el).val().length - 1) );};
    if ($(el).val() > 100) { $(el).val(100); };
    if ($(el).val() < 0) { $(el).val(0); };
  };

  $('.request-button').click(function(){
    if ($(".lat-input").val() == "") { $(".lat-input").val(Math.random()*100) }
    if ($(".long-input").val() == "") { $(".long-input").val(Math.random()*100) }
    var path = 'http://localhost:3000/eta.json?lat='+$(".lat-input").val()+'&long='+$(".long-input").val();
    syncRequestJSON(path, showResponce);
  });

  function showResponce( responce_data ){
    $('.сar-number').text('Номер ближайшей машины '+responce_data['car_number']);
    $('.distanse').text('Расстояние до ближайшей машины '+responce_data['distance']);
    $('.eta').text('Ожидаемое время прибытия '+responce_data['eta']);
    $('.result').show();
  };

  function syncRequestJSON( path, callback ) {
    var httpRequest = getXmlHttp();
    httpRequest.onreadystatechange = function() {
      if ( httpRequest.readyState == 4 && httpRequest.status == 200 ) {
        var data = JSON.parse( httpRequest.responseText );
        if ( callback ) callback( data );
      }
    };
    httpRequest.open( 'GET', path, true );
    httpRequest.send();
  };

  function getXmlHttp(){
    var xmlhttp;
    try {
      xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
      try {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      } catch (E) {
        xmlhttp = false;
      }
    }
    if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
      xmlhttp = new XMLHttpRequest();
    }
    return xmlhttp;
  };
});