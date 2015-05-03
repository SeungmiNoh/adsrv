	var opened = false;

	function showModalPopup(url, width, height){
	 
		$("body").append("<div id=\"mask\"></div>");	 
		$("body").append("<div id=\"popUp\"><iframe id=\"iframePopUp\" src=\"" + url + "\" frameborder=\"0px\" marginheight=\"0px\" marginwidth=\"0px\" scrolling=\"yes\"></iframe></div>");

		$("#iframePopUp")	 
			.css("width", "100%")	 
			.css("height", "100%")	 
			.css("border", "0px");

		$("#mask")	 
			.css("z-index", "998")	 
			.css("position", "absolute")	 
			.css("top","0px")	 
			.css("background","#4b4b4b")
			.css("display", "none")
			.css("width", $(document).width()) 
			.css("height", $(document).height());
	 		
		$("#popUp")
			.css("z-index", "999")	 
			.css("position", "absolute")
			.css("background","#fff")	 
			.css("border", "1px solid #eee")	 
			.css("display", "none")	 
			.css("width", width + "px")	 
			.css("height", height + "px")	 
			.css("top", ($(window).height()/2 + $(document).scrollTop() - $("#popUp").outerHeight()/2) + "px")	 
			.css("left", ($(window).width()/2 + $(document).scrollLeft() - $("#popUp").outerWidth()/2) + "px");
	 
		$("#mask").fadeIn("fast");	 
		$("#mask").fadeTo("slow", 0.5); 
		$("#popUp").show();
	 
		opened = true;
	 
	}
	 



	function closeModalPopup(){
	 
		$("#mask", parent.document).fadeOut("fast");	 
		$("#popUp", parent.document).hide();
	 
		opened = false;	 
		
		$("#mask", parent.document).remove();	 
		$("#popUp", parent.document).remove(); 
	}
	 

	this.modalPopup = function(){
	 
		$(window).resize(function(){ 
	 
			if(opened){	 
				$("#mask")	 
					.css("width", $(document).width())	 
					.css("height", $(document).height());				

				$("#popUp")	 
					.css("left", ($(window).width()/2 + $(document).scrollLeft() - $("#popUp").outerWidth()/2) + "px")	 
					.css("top", ($(window).height()/2 + $(document).scrollTop() - $("#popUp").outerHeight()/2) + "px");	 
			}	 
		});
	 
		$(window).scroll(function(){ 
	 
			if(opened){	 
				$("#mask")	 
					.css("width", $(document).width())	 
					.css("height", $(document).height());	 				
				$("#popUp")	 
					.css("left", ($(window).width()/2 + $(document).scrollLeft() - $("#popUp").outerWidth()/2) + "px")	 
					.css("top", ($(window).height()/2 + $(document).scrollTop() - $("#popUp").outerHeight()/2) + "px");	 
			}	 
		});
	};
	 
	$(document).ready(function($) {	 
		modalPopup();	 
	});