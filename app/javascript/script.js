import jQuery from 'jquery';

jQuery(document).on('turbolinks:load', function () {
  slideAnime(jQuery);
});

function slideAnime(jQuery){
  jQuery('.leftAnime').each(function(){ 
    var elemPos = jQuery(this).offset().top - 50;
    var scroll = jQuery(window).scrollTop();
    var windowHeight = jQuery(window).height();
    if (scroll >= elemPos - windowHeight){
      jQuery(this).addClass("slideAnimeLeftRight"); 
      jQuery(this).children(".leftAnimeInner").addClass("slideAnimeRightLeft"); 
    } else {
      jQuery(this).removeClass("slideAnimeLeftRight");
      jQuery(this).children(".leftAnimeInner").removeClass("slideAnimeRightLeft");
    }
  });
}

