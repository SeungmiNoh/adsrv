<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/common.jsp" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.domain.Campaign"%>    
<%@page import="tv.pandora.adsrv.domain.Ads"%>    
<%@page import="tv.pandora.adsrv.domain.Creative"%>    
<%	
try
{
	
	String a = request.getParameter("a");
	String s_siteid = StringUtil.isNull(request.getParameter("s_siteid"));
	String s_secid = StringUtil.isNull(request.getParameter("s_secid"));
	String s_slotid = StringUtil.isNull(request.getParameter("s_slotid"));
	
	Map<String,Object> map = (Map<String,Object>)request.getAttribute("response");

	
	Campaign cp = (Campaign)map.get("cp");
	Ads ads = (Ads)map.get("ads");

	List<Ads> adslist = (List<Ads>)map.get("adslist"); 
	List<Map<String, String>> grouplist = (List<Map<String, String>>)map.get("grouplist");   
	List<Slot> slotlist = (List<Slot>)map.get("slotlist");   
	List<Map<String,String>> sitelist = (List<Map<String,String>>)map.get("sitelist");   
	List<Map<String,String>> seclist = (List<Map<String,String>>)map.get("seclist");   
	List<Slot> adsslotlist = (List<Slot>)map.get("adsslotlist");   
	
	JSONArray sec_data = JSONArray.fromObject(seclist);
	JSONArray slot_data = JSONArray.fromObject(slotlist);

%>  
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Prism Ad Network</title>
    <!-- css start -->
    <link rel="stylesheet" href="<%=web%>/css/bootstrap.css">
    <link rel="stylesheet" href="<%=web%>/css/bootstrap-theme.css">
    <link rel="stylesheet" href="<%=web%>/css/design.css">
   <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- css end -->
    
    
    

  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css">

  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
  
 <script type="text/javascript" src="<%=web%>/dwr/engine.js"></script>
<script type="text/javascript" src="<%=web%>/dwr/util.js"></script>
<script type="text/javascript" src="<%=web%>/dwr/interface/MasDwrService.js"></script>
  <script src="<%=web%>/js/bootstrap.js"></script>
  <script src="<%=web%>/js/basic.js"></script>
 <script src="<%=web%>/js/common.js"></script>
 </head>

<body>
    <div class="container-fluid containerBg">
        <div class="containerBox">
        <%@ include file="../common/header.jsp"  %>
            <section class="sectionBox">
                <div class="boxTitle">
                    <!-- title Start -->
                    <div class="title">애즈 상세 정보</div>
                    <div class="breadcrumbs"><span class="glyIcon"><img src="<%=web%>/img/navIcon.png" alt=""></span> 현재위치 : 캠페인 > 캠페인 정보</div>
                    <!-- title End -->
                </div>      
                <table class="viewTable" style="width:900px">
				<colgroup>
				<col width="10%">
				<col width="23%">
				<col width="10%">
				<col width="23%">
				<col width="10%">
				<col width="">
				</colgroup>
                    <tr>
                        <th>캠페인명</th>
                        <td colspan="3"><%=cp.getCpname() %></td>
                        <th>담당자</th>
                        <td><%=cp.getTcname() %></td>
                    </tr>
                    <tr>
                        <th>광고주</th>
                        <td><%=cp.getClientname() %></td>
                        <th>대행사</th>
                        <td><%=StringUtil.isNull(cp.getAgencyname()) %></td>
                        <th>미디어렙</th>
                        <td><%=StringUtil.isNull(cp.getMedrepname()) %></td>
                    </tr>
                    <tr>
                        <th>보장량</th>
                        <td></td>
                        <th>목표량</th>
                        <td></td>
                        <th>집행금액</th>
                        <td><%=StringUtil.addComma(cp.getBudget()) %></td>
                    </tr>
                    <tr>
                        <th>시작일</th>
                        <td><%=DateUtil.getYMD(cp.getStartdate(), "-") %></td>
                        <th>종료일</th>
                        <td><%=DateUtil.getYMD(cp.getEnddate(), "-") %></td>
                        <th>상태</th>
                        <td></td>
                    </tr>
                </table>
                <br>
                <!-- view Table End -->
                <!-- campaign view End -->
                <!-- select ads Start -->
 	                <form id="frmAds" method="get" action="cpmgr.do">
	                <input type="hidden" name="a" value="<%=a %>"/>  
	                <input type="hidden" name="adsid" value="<%=ads.getAdsid()%>"/>
                <div class="adsBox">
 	                    <select id="moveid" class="form-control input-sm" style="width:300px;">
<%

for(int k=0; k<adslist.size(); k++){
                                        
    Ads mads = adslist.get(k);
    
	 
 %>                     
                        <option value="<%=mads.getAdsid()%>" <%=ads.getAdsid().equals(mads.getAdsid())?"selected":"" %>><%=mads.getAdsname() %></option>
 <%} %>                 </select>
               	</div>

                <!-- select ads End -->
                <!-- ads add title Start -->
                <div class="boxtitle2">
                     <!-- title Start -->
                    <div class="title3">애즈</div>
                    <!-- title End -->
                    <div class="tapBox">
                        <nav class="tapMenu">
                            <ul>
                                <li><a href="cpmgr.do?a=cpAdsList&cpid=<%=ads.getCpid()%>">캠페인 상세 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsInfo&adsid=<%=ads.getAdsid()%>">애즈 정보 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsTarget&adsid=<%=ads.getAdsid()%>" >타겟팅 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsCreative&adsid=<%=ads.getAdsid()%>">광고물 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                                <li><a href="cpmgr.do?a=adsSlot&adsid=<%=ads.getAdsid()%>" class="active">광고지면 <span class="glyphicon glyphicon-menu-right"></span></a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <!-- ads add title End -->
                <!-- ads add Table Start -->
                <input type="hidden" name="cpid" value="<%=cp.getCpid() %>"/>
                    <table class="viewTable">
                        <colgroup>
                        <col width="9%">
                        <col width="22%">
                        <col width="9%">
                        <col width="24%">
                        <col width="9%">
                        <col width="27%">
                        </colgroup>
                        <tr>
                            <th>애즈명</th>
                            <td colspan="3">
                                <%=ads.getAdsname()%>
                                <input type="hidden" id="adsid" value="<%=ads.getAdsid()%>"/>
                            </td>
                            <th>판매방식</th>
                            <td>
                                <%=ads.getSalestypename() %>
                            </td>
                        </tr>
                        <tr>
                            <th>기간</th>
                            <td>
                                <%=ads.getPeriod().equals("0")?"No ":"" %>Period
                            </td>
                            <th>시작일</th>
                            <td>
                                <%=DateUtil.getYMD(ads.getStartdate()) %> (<%=ads.getStart_hour()%>시 <%=ads.getStart_min() %>분)
                            </td>
                            <th>종료일</th>
                            <td>
                                <%=DateUtil.getYMD(ads.getEnddate()) %> (<%=ads.getEnd_hour() %>시 <%=ads.getEnd_min() %>분)
                            </td>
                        </tr>
                       <tr>
                             <th>목표타입</th>
                            <td>
                                <%=ads.getGoaltypename() %>
                            </td>	
                            <th><label id="goalText">노출 목표량</label></th>
                            <td>
                               <%=StringUtil.addComma(ads.getGoal_total()) %>
							</td>
                             <th>일 목표 노출량</th>
                            <td>
                                <%=StringUtil.addComma(ads.getGoal_daily()) %>
                            </td>
   						</tr>
                         
   						<tr>
                             
                           <th>광고상품</th>
                            <td>
                                <%=ads.getPrtypename() %>
                            </td>
                              <th>집행금액</th>
                            <td>
                                <%=StringUtil.addComma(ads.getBudget()) %>
                            </td>
                            <th><label id="goalText">보장량</label></th>
                            <td>
                                <%=StringUtil.addComma(ads.getBook_total()) %>                             
							</td>
                        </tr>  
                        <tr>
                        <th>상태</th>
                            <td>
                                <%=ads.getAds_statename() %>
                            </td>
                                          
                        <th>수정일</th>
                            <td>
                                <%=DateUtil.getYMDHM(ads.getUpdatedate(),".") %>
                            </td>
                                            
                        <th>최종수정</th>
                            <td>
                                <%=DateUtil.getYMD(ads.getUpdateusername()) %>
                            </td>
                        </tr>                      
                    </table>
                <!-- add Table End -->
                <br>
                <!-- creative title -->
                <!-- title Start -->
                <div class="boxtitle3">
                    <h1 class="title4"><span class="glyphicon glyphicon-ok"></span> 광고지면</h1>
                </div>
                <!-- title End -->
                <!-- search form Start -->
                    <div class="form-inline form-group">
                        <select id="s_slgroup" name="" class="form-control input-sm" style="width:180px">
                            <option value="0">위치그룹</option>
                            <%for(int i=0;i<grouplist.size();i++){ 
                                	Map<String,String> group = grouplist.get(i);
                                %>
                               <option value="<%=String.valueOf(group.get("groupid")) %>"><%=group.get("groupname") %></option>                               
                                  <%} %>
							</select>
                    
                            <select id="s_siteid" name="s_siteid" class="form-control input-sm" style="width:140px">
                                <option value="0">사이트</option>
                                <%for(int i=0;i<sitelist.size();i++){ 
                                	Map<String,String> site = sitelist.get(i);
                                %>
                               <option value="<%=String.valueOf(site.get("siteid")) %>"><%=site.get("sitename") %></option>                               
                                  <%} %>
                            </select>
                            <select id="s_secid" name="s_secid" class="form-control input-sm" style="width:140px">
                                <option value="0">섹션</option>                              
								<%
                                if(!s_siteid.equals("")){
	                                for(int i=0;i<seclist.size();i++){ 
	                                	Map<String,String> sec = seclist.get(i);
	                                	if(s_siteid.equals(String.valueOf(sec.get("siteid")))){
	                                %>
	                               <option value="<%=String.valueOf(sec.get("secid")) %>" <%=s_secid.equals(String.valueOf(sec.get("secid")))?"selected":"" %>><%=sec.get("secname") %></option>                               
	                                  <%} 
	                                }
                                } %>                            
                             </select>
                            <select name="s_slotid"  id="s_slotid" class="form-control input-sm" style="width:240px">
                            <option value="0">위치</option>
							<%
                               if(!s_secid.equals("")){
                                for(int i=0;i<slotlist.size();i++){ 
                                	Slot slot = slotlist.get(i);
                                	if(s_secid.equals(slot.getSecid())){
                                %>
                               <option value="<%=slot.getSlotid() %>" <%=s_slotid.equals(slot.getSlotid())?"selected":"" %>><%=slot.getSlotname() %></option>                               
                                  <%} 
                             	} 
                             }%>                            
                             </select>
                        	<button class="btn btn-danger btn-sm" id="btnAdd">추가</button>
                    </div>
                  	</form>                
                
                <!-- search form End -->
                
                <!-- creative Table Start -->
                 <table class="listTable">
                    <colgroup>
                    <col width="4%">
                    <col width="">
                    <col width="10%">
                    <col width="">
                    <col width="10%">
                    <col width="6%">
                    <col width="5%">
   					<col width="10%">
                    <col width="">
                    </colgroup>
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="ckall" name="ckall"/></th>                                            
                            <th>위치</th>
                            <th>사이즈</th>
                            <th>위치 정보</th>
                            <th>상태</th>
                            <th>중지/진행</th>
                            <th>삭제</th>
                            <th>등록자</th>
                            <th>등록일</th>
                        </tr>
                    </thead>

                    <tbody>
 <%

 for(int k=0; k<adsslotlist.size(); k++){
     
		Slot slot = adsslotlist.get(k);
  %>                    
 						<tr id="adsSlot<%=slot.getSlotid()%>">
                            <td>
                                <input type="checkbox" name="ckslot" value="<%=slot.getSlotid()%>"/>
                            </td>
                            <td class="textLeft"><%=slot.getSlottag()%></td>
                            <td><%=slot.getWidth() %> x <%= slot.getHeight()%></td>
                            <td class="textLeft">
                                <%=slot.getSlottag()%>
                            </td>
                            <td><%=String.valueOf(slot.get("slot_state")).equals("1")?"진행":"중지"%>
                            </td>
                            <td class="form-inline">
                            	<button class="btn btn-default btn-xs" name="btnState" state="<%=String.valueOf(slot.get("slot_state")) %>" slotid="<%=slot.getSlotid()%>">
                            	<span class="glyphicon glyphicon-<%=String.valueOf(slot.get("slot_state")).equals("1")?"stop":"play"%>"></span>
                            	</button>
                           </td>
                           <td><a class="btn btn-default btn-xs" href="#none" role="button" name="btnDel" slotid="<%=slot.getSlotid()%>">x</a></td>
                           <td><%=slot.get("insertusername") %></td>
                           <td><%=DateUtil.getYMD(String.valueOf(slot.get("insertdate"))) %></td>
                      </tr>
<%} if(adsslotlist.size()==0){
%>

                        <tr>
                            <td colspan="8"> 위치가 등록되지 않았습니다.</td>                            
                        </tr> 
                        <%} %> 
                        </tbody>
                       </table>
                <!-- targeting Table End -->
                 <div class="buttonGroup">
                 				<button class="btn btn-default btn-sm" name="btnSelState" state="1">
                            	선택 <span class="glyphicon glyphicon-play"></span>
                            	</button>
                 				<button class="btn btn-default btn-sm" name="btnSelState" state="0">
                            	선택 <span class="glyphicon glyphicon-stop"></span>
                            	</button>
                     <a class="btn btn-default btn-sm" href="#" role="button">태그 확인</a>
                </div>
                
                <!-- creative title -->
            </section>



        </div>
    </div>
    
    

<script>

$(function(){
	$(".debug").css("display","none");
	$('.numinput').numberOnly();
	
	var arrSection = <%=sec_data%>;
	var arrSlot = <%=slot_data%>;
	
	$("#s_siteid").change(function(e){		
		$("#s_secid").html('<option value="0">섹션</option>');
		if($("#s_siteid").val()!=0){
		
			for(var i=0;i<arrSection.length;i++){
				if($("#s_siteid").val()==arrSection[i].siteid) {
					$("#s_secid").append('<option value="'+arrSection[i].secid+'">'+arrSection[i].secname+'</option>');
				}
			}			
		}		
	});
	$("#s_secid").change(function(e){		
		$("#s_slotid").html('<option value="0">위치</option>');
		if($("#s_secid").val()!=0){
		
			for(var i=0;i<arrSlot.length;i++){
				if($("#s_secid").val()==arrSlot[i].secid) {
					$("#s_slotid").append('<option value="'+arrSlot[i].slotid+'">'+arrSlot[i].slotname+'</option>');
				}
			}			
		}		
	});	
	$("#s_slgroup").on("change", function(e){
		
		var groupid = $("#s_slgroup").val();
		var slotid = $("#s_slotid").val();

		if(groupid != 0 && slotid!=0) 
		{
			$("#s_slotid").val(0);
		}
		
	});
	
	$("#s_slotid").on("change", function(e){
		var slotid = $("#s_slotid").val();
		var groupid = $("#s_slgroup").val();
		if(groupid != 0 && slotid!=0) 
		{
			$("#s_slgroup").val(0);
		}

		
	});	
	
	$("input:checkbox[name='ckall']").click(function(e){	
		var ischked = $(this).is(':checked');
		var slot_str = "";
		$("input:checkbox[name='ckslot']").prop("checked", ischked);			
	});
	
	$("[name=btnSelState]").click(function(e){	
		var slot_str = "";
		for(var i=0; i<$("input:checkbox[name='ckslot']").length; i++){
			slot_str += $("input:checkbox[name='ckslot']").eq(i).val()+',';		
		}
		var state = $(this).attr("state");
		
		
		slot_str = slot_str.substring(0,slot_str.length-1);
		
		
		MasDwrService.modAdsSlotStr(<%=ads.getAdsid()%>, slot_str, state, <%=userID%>,
		   		function(data) {
					if(data==1){
						$("#frmAds").submit();
					} else{
						alert("오류가 발생했습니다.");
					}
				}
		);
		
	});
	
	$("#btnAdd").on("click", function(e){
		
		var slotid = $("#s_slotid").val();
		var groupid = $("#s_slgroup").val();

		if(groupid != 0) 
		{
			MasDwrService.addAdsSlotByGroup(<%=ads.getAdsid()%>, groupid, <%=userID%>,
			   		function(data) {
						if(data==1){
							//$("#frmAds").submit();
						} else{
							alert("오류가 발생했습니다.");
						}
					}
			);
		}
		else if(slotid != 0 && $("#adsSlot"+slotid).length==0) 
		{

			MasDwrService.addAdsSlot(<%=ads.getAdsid()%>, slotid, <%=userID%>,
			   		function(data) {
						if(data==1){
							$("#frmAds").submit();
						} else{
							alert("오류가 발생했습니다.");
						}
					}
			);
		}
		
	});	
	
	$("[name=btnState]").on("click", function(e){
		var slotid = $(this).attr("slotid");
		var state = $(this).attr("state");
		var new_state = (state==1)?0:1;
			
		MasDwrService.modAdsSlot(<%=ads.getAdsid()%>, slotid, new_state, <%=userID%>,
		   		function(data) {
					if(data==1){
						
						
						
						
						$("#frmAds").submit();
					} else{
						alert("오류가 발생했습니다.");
					}
				}
		);	
	});
	$("[name=btnDel]").on("click", function(e){
		var slotid = $(this).attr("slotid");
			
		MasDwrService.delAdsSlot(<%=ads.getAdsid()%>, slotid, <%=userID%>,
		   		function(data) {
					if(data==1){
						
						
						
						
						$("#frmAds").submit();
					} else{
						alert("오류가 발생했습니다.");
					}
				}
		);	
	});		
	  $("#moveid").on("change", function(e){
			if($("#adsid").val()!= $("#moveid").val()) 
			{
				$("#frmAds input[name=adsid]").val($("#moveid").val());
				$("#frmAds").submit();
			}
			
		});
	});

  
  </script>
  <%
} catch(Exception e) {
    e.getMessage();
}
%> 
</body>

</html>
