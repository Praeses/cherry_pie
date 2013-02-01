(function(){

  var offset = 0;

  var animate = function(){
    var value = "-" + offset + "px 0px"; 
    $('#extraDiv2').css('background-position', value);
    offset = offset + 1;
  };



  offset =  Math.floor(Math.random()*999);
  animate();


  setInterval(animate, 100);

})();
