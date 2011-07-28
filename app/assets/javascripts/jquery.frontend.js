
$(document).ready(function() {	
	ppLib.fixLayout();
	ppLib.scrollInspirations('#inspirationsBox .itemsContainer');
	ppLib.scrollGalleryItems('#galleryAndAuthorDesc .itemsContainer');
	ppLib.openBigPhoto('#artThumbs');
	ppLib.openBigPhoto('#relatedBox');
	ppLib.priceSlider('#priceSlider');
});

var ppLib = {
	pAlert: function(str) { str ? alert(str) : alert('Jestem!'); },
	fixLayout: function() {
		var shadow = document.createElement('span');
		$(shadow).addClass('shadow');
		$('.hasShadow').append(shadow);
		
		var sep = document.createElement('em');
		$(sep).text('|');
		$(sep).addClass('sep');
		$('.filterBar a').after(sep);
		var lastSep = $('.filterBar .sep:last').detach();
		$('.paginationBox .pagesCounter a').after(lastSep);
		$('.paginationBox .pagesCounter span').after(lastSep);
			
		$('#categoriesThumbsContainer a:nth-child(3)').css('margin-right','0');
		
		var titleArrow = document.createElement('span');
		$('#descriptionContainer h2').append(titleArrow);
		
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
},
	scrollGalleryItems: function(el) {
		var $scrollables = $(el).scrollable({
			speed: 300,
			vertical: false,
			circular: false,
			next: '.next',
			prev: '.prev',
			items: '.items'
		});
},	
	openBigPhoto: function(container) {
	if($.fancybox) {
		$('a', container).fancybox({
			speedIn				:	300, 
			speedOut			:	100, 
			overlayShow			:	true,
			hideOnContentClick	: true,
			centerOnScroll		: true,
			titleShow			: false,
			cyclic				: false,
			padding				: '1',
			overlayShow			: true,
			overlayColor		: '#000',
			showNavArrows		: true,
			margin				: '10'
		});	
}
},
	priceSlider: function(el) {
		$('.priceValue').attr('disabled','disabled');
		
		//minValInput = $('#minAmount').detach();
		//maxValInput = $('#maxAmount').detach();

		
		
		$(el).slider({
			range: true,
			min: 0,
			max: 1000,
			values: [ 75, 300 ],
			slide: function( event, ui ) {
				$('#minAmount').val(ui.values[ 0 ] + " PLN");
				$('#maxAmount').val(ui.values[ 1 ] + " PLN");				
}
});
		$('#minAmount').val($(el).slider('values', 0) + ' PLN');
		$('#maxAmount').val($(el).slider('values', 1) + ' PLN');
		
}	
}
