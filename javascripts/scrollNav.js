$(document).ready(function(){

    var $window = $(window);
    var $headcon = $('#head_content')
    var $navi   = $('#nav > .main_content');
    var $con    = $('#body');

    //set navigation height
    var height  = $headcon.height() + $navi.innerHeight();

    $window.scroll (function() {
        if ($window.scrollTop() > 1) {
            $('#fix').addClass('fixed');
            $con.css("margin-top", height);
        } else {
            $('#fix').removeClass('fixed');
            $con.css("margin-top", 0);
        }
    });
});
