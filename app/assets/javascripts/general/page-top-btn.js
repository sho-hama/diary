$(function() {
    var TopBtn = $('#page-top-btn');
    TopBtn.hide();
    $(window).scroll(function() {
        if ($(this).scrollTop() > 20) {
            TopBtn.fadeIn();
        }
        else {
            TopBtn.fadeOut();
        }
    });
    TopBtn.click(function() {
        $('body,html').animate({
            scrollTop: 0
        }, 300);
        return false;
    });
});
