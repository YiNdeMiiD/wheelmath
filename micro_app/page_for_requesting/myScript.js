$(document).ready(function() {

  $('.request-button').click(function(){
    var path = 'http://localhost:3000/eta.json?lat=57&long=36';
    syncRequestJSON(path, showResponce);
  });

  function showResponce( responce_data ){
    console.log('YAY!')
    console.log( responce_data )
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