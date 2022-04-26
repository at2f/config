$(document).ready(function() {

  var nbPC = [1, 2, 3, 4, 5, 6, 7, 8];
  nbPC.forEach(buttonClick);

  function buttonClick(value) {
    $(".startpc" + value).click(function() {
        $(".timerpc" + value).timer(), $("#pc" + value).css("border", "2px solid #FFBC42")
      }),
      $(".pausepc" + value).click(function() {
        $(".timerpc" + value).timer("pause")
      }),
      $(".resetpc" + value).click(function() {
        $(".timerpc" + value).timer("remove"), $(".timerpc" + value).html("0 sec"), $(".prixpc" + value).html("Prix : 0\u20AC"), $("#pc" + value).css("border", "1.5px solid rgba(29,29,27,0.2)")
      });
  }


  nbPC.forEach(checkPrice);

  function checkPrice(value) {
    setInterval(function() {

        //Si le timer est < 1 seconde, le prix est de 0 euro
        1 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 0\u20AC") :

        //Si le timer est < 450 secondes, le prix est de 0.15 euro
        450 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 0,15\u20AC") :

        //...
        750 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 0,30\u20AC") :
        1050 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 0,50\u20AC") :
        1350 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 0,75\u20AC") :
        1650 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 0,90\u20AC") :
        1950 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 1\u20AC") :
        2250 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 1,15\u20AC") :
        2550 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 1,30\u20AC") :
        2850 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 1,50\u20AC") :
        3150 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 1,65\u20AC") :
        3450 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 1,80\u20AC") :
        3750 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 2\u20AC") :
        4050 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 2,15\u20AC") :
        4350 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 2,30\u20AC") :
        4650 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 2,50\u20AC") :
        4950 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 2,75\u20AC") :
        5250 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 2,90\u20AC") :
        5550 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 3\u20AC") :
        5850 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 3,15\u20AC") :
        6150 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 3,30\u20AC") :
        6450 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 3,50\u20AC") :
        6750 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 3,65\u20AC") :
        7050 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 3,80\u20AC") :
        7350 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 4\u20AC") :
        7650 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 4,15\u20AC") :
        7950 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 4,30\u20AC") :
        8250 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 4,50\u20AC") :
        8550 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 4,75\u20AC") :
        8850 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 4,90\u20AC") :
        9150 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 5\u20AC") :
        9450 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 5,15\u20AC") :
        9750 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 5,30\u20AC") :
        10050 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 5,50\u20AC") :
        10350 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 5,65\u20AC") :
        10650 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 5,80\u20AC") :
        10950 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 6\u20AC") :
        11250 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 6,15\u20AC") :
        11550 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 6,30\u20AC") :
        11850 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 6,50\u20AC") :
        12150 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 6,65\u20AC") :
        12450 >= $(".timerpc" + value).data("seconds") ? $(".prixpc" + value).html("Prix : 6,80\u20AC") :
        12750 >= $(".timerpc" + value).data("seconds") && $(".prixpc" + value).html("Prix : 7\u20AC")

    }, 1e3)
  }

});
