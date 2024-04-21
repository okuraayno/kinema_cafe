$(document).on('turbolinks:load', function () {
  slideAnime(); // アニメーション用の関数を呼び出す
});

function slideAnime(){
		$('.leftAnime').each(function(){ 
			var elemPos = $(this).offset().top-50;
			var scroll = $(window).scrollTop();
			var windowHeight = $(window).height();
			if (scroll >= elemPos - windowHeight){
				$(this).addClass("slideAnimeLeftRight"); 
				$(this).children(".leftAnimeInner").addClass("slideAnimeRightLeft"); 
			}else{
				$(this).removeClass("slideAnimeLeftRight");
				$(this).children(".leftAnimeInner").removeClass("slideAnimeRightLeft");
				
			}
		});
		
	}
