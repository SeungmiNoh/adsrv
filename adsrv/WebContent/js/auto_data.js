




function auto_corp(objname,corptype)
{
	
	$.ajax({		    
		url : "cpmgr.do?a=auto_corp&corptype="+corptype,
	    datatype:"json",
	    success:function(data, type){	     
	        test = eval("(" + data + ")");	      
			$( '#'+objname).autocomplete({
				source:test,
				focus: function(event, ui) {
					return false;
				},
				select: function(event, ui) {
					$('#'+objname).val(ui.item.label);
					$('#'+objname+'id').val(ui.item.value);
					$('#'+objname+'name').val(ui.item.label);
					$('#'+objname).css("border-color","green").focus();
					return false;
				},					
				change: function(event, ui) {					
					if($('#'+objname+'name').val()!="") {
						if($('#'+objname).val()!=$('#'+objname+'name').val()) {
							$('#'+objname+'id').val("");
							$('#'+objname+'name').val("");
							$('#'+objname).css("border-color","red");						
						}
					} 
					return false;
				}		

			});
		}
	});  	 
}

