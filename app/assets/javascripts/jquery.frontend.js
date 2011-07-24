
$(document).ready(function() {	
	ppLib.fixLayout();
	ppLib.scrollInspirations('#inspirationsBox .itemsContainer');
	
});

var ppLib = {
	pAlert: function(str) { str ? alert(str) : alert('Jestem!'); },
	fixLayout: function() {
		var shadow = document.createElement('span');
		$(shadow).addClass('shadow');
		$('.hasShadow').append(shadow);
		
		var counterArrow = document.createElement('span');
		$('#cartsItemCounter').append(counterArrow);
		
		var activeArrow = document.createElement('span');
		$('#productsCategories a.active').append(activeArrow);
		$('#productsCategories a.active span').clone().appendTo('#authorsDetails a.button');

		var hoverMask = document.createElement('span');
		$(hoverMask).addClass('mask');
		var hoverLens = document.createElement('span');
		$(hoverLens).addClass('lens');

		$('#inspirationsBox li a').append(hoverMask);
		$('#inspirationsBox li a span').append(hoverLens);
			
		var crumbSep = document.createElement('li');
		$(crumbSep).text('|');
		$('#crumbsBar li').after(crumbSep);
		/* uwazac na to */
		$('#crumbsBar li:last').detach();
	
		if($(document).width() < 1200) {
			$('.createSticker').css('opacity','0.35').css('z-index','-1');
		}
		$(window).resize(function() {
		if($(document).width() < 1200) {
			$('.createSticker').css('opacity','0.35').css('z-index','-1');
		}
		else {
			$('.createSticker').css('opacity','1').css('z-index','2');
		}
});
},
	scrollInspirations: function(el) {
		var $scrollables = $(el).scrollable({
			speed: 300,
			vertical: false,
			circular: true,
			next: '.next',
			prev: '.prev',
			items: '.items'
		}).autoscroll({ 
			autoplay: true,
			steps: 1,
			interval: 1500
});	
	$scrollables.each(function() {
		var $itemsToClone = $(this).scrollable().getItems().slice(1);
		var $wrap = $(this).scrollable().getItemWrap();
		var clonedClass = $(this).scrollable().getConf().clonedClass;
		$itemsToClone.each(function() {
			$(this).clone(true).appendTo($wrap)
			.addClass(clonedClass + ' hacked-' + clonedClass);
		});
})
}
}
