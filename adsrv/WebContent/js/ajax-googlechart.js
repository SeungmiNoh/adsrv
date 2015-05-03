google.load('visualization', '1', {packages: ['corechart'],'language':'ko'});       
//google.setOnLoadCallback(drawChart); 
//google.load("visualization", "1", {packages:["imagechart"]});
//google.setOnLoadCallback(drawChart2); 
/*
function drawChart()
{
	var jsonData = $.ajax({
			url : "admgr.do?a=brBudgetChart",
		    dataType:"json",
		    async: false
		}).responseText;
		
		var data = new google.visualization.DataTable(jsonData);
		
		var options = {         
				title: '브랜드 누적 광고비',     
				hAxis: {title: '', titleTextStyle: {color: 'black', fontName: "맑은 고딕, Malgon Gothic"}}    ,
				//width:600, height:480,
				// Allow multiple simultaneous selections.
			    //selectionMode: 'multiple',
			    // Trigger tooltips on selections.
			    tooltip: { trigger: 'selection' },
			    // Group selections by x-value.
			    aggregationTarget: 'category',
			    fontName: "맑은 고딕, Malgon Gothic"

		};     
		
		var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));         
		chart.draw(data, options); 
		
}



function drawChart3() {         
	  var data = google.visualization.arrayToDataTable(
	     [['브랜드', '7월', '8월', '9월'],           
	     ['K2',  11976,      10683, 197248],           
	     ['엠리미티드',  1116,      153, 105650],          
	     ['아이더',  53584,       21605, 27519],         
	     ['더노스페이스',  0,      35593, 65974]]
	     
	  );



		
	   var options = {        
	title: 'Company Performance',  
	isStacked: true,   
	fontName: "맑은 고딕, Malgon Gothic",
	hAxis: {title: 'Year', titleTextStyle: {color: 'red'}}    
	};
	   var chart = new google.visualization.ColumnChart(document.getElementById('chart3'));
	  chart.draw(data, options);
	}   




*/




/*
function drawChart2()
{
	var jsonData = $.ajax({
			url :  "admgr.do?a=monthBudgetChart",
		    dataType:"json",
		    async: false
		}).responseText;
		
		var data = new google.visualization.DataTable(jsonData);
		
		var options = {
		          chxl: '',
		          chxp: '',
		          chxr: '',
		          chxs: '',
		          chxtc: '',
		          chxt: 'y',
		          chbh: 'a,30,0',
		          chs: '480x300',
		          cht: 'bvs',
		          chco: 'FF2A2C,FF9900,3399CC',
		          chd: 's:jQKc,jQKc,MGQK',
		          chdl: '||',
		          chdlp: 'b',
		          chp: '0.05',
		          chma: '|35',
		          chtt: '온라인 광고비',
		          chts: '676767,7.5'
		        };     
		
		var chart = new google.visualization.ColumnChart(document.getElementById('chart'));         
		chart.draw(data, options); 
		
}*/

