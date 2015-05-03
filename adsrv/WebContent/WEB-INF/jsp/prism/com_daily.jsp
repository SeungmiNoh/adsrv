 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>				
<%
	List<PrismReport> day_rptlist = (List<PrismReport>)map.get("day_rptlist"); 	
	PrismReport day_tot = (PrismReport)map.get("day_rpttotal"); 	
%>                
                <!-- list Table Start -->
                <table class="rptTable">
                    <thead>
                        <tr>
                            <th rowspan="2">일자</th>
                            <th rowspan="2">일별
                                <br>보장량</th>
                            <th rowspan="2">일별
                                <br>달성율</th>
                            <th rowspan="2">Imp</th>
                            <th colspan="6">HIT</th>
                            <th rowspan="2">Skip</th>
                            <th rowspan="2">단가</th>
                            <th rowspan="2">무효
                                <br>클릭수</th>
                        </tr>
                        <tr>
                            <th class="thBg">HIT</th>
                            <th class="thBg">HTR(%)</th>
                            <th class="thBg">View</th>
                            <th class="thBg">VTR(%)</th>
                            <th class="thBg">Click</th>
                            <th class="thBg">CTR(%)</th>
                        </tr>
                    </thead>
                    <tbody class="sum" id="tbodySum">
<%

if(day_tot!=null){

 %> <tr>
    <td >Total</td>
	<td class="textRight"><%=StringUtil.addComma(day_tot.getGuarantee())%></td>
	<td class="textRight"><%=day_tot.getBookrate()%>%</td>
     <td class="textRight"><%=StringUtil.addComma(day_tot.getImp())%></td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getHit())%></td>
    <td class="textRight"><%=day_tot.getHtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getViews())%></td>
    <td class="textRight"><%=day_tot.getVtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getClick())%></td>
    <td class="textRight"><%=day_tot.getCtr()%>%</td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getSkip())%></td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getAvg_cost())%></td>
    <td class="textRight"><%=StringUtil.addComma(day_tot.getVoids())%></td>
	</tr> 
<%} %>                     </tbody>
                    <tbody id="tbodyRpt">
<%
Integer wkno = 0;
String wkstyle = "";
String wkname = "";

for(int k=0; k<day_rptlist.size(); k++){
    PrismReport rpt = day_rptlist.get(k);
    
    wkno = Integer.parseInt(rpt.getWeekday())-1;
   	wkstyle = (weekday.get(wkno)).get("text");
    wkname = (weekday.get(wkno)).get("isname"); 
  %>                       
                    
                    
                        <tr>
                            <td><span class="<%=wkstyle%>"><%=DateUtil.getYMD(rpt.getName()) %>   (<%=wkname%>)</span></td>
 						    <td class="textRight"><%=StringUtil.addComma(rpt.getGuarantee())%></td>
						    <td class="textRight"><%=rpt.getBookrate()%>%</td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getImp())%></td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getHit())%></td>
						    <td class="textRight"><%=rpt.getHtr()%>%</td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getViews())%></td>
						    <td class="textRight"><%=rpt.getVtr()%>%</td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getClick())%></td>
						    <td class="textRight"><%=rpt.getCtr()%>%</td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getSkip())%></td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getAvg_cost())%></td>
						    <td class="textRight"><%=StringUtil.addComma(rpt.getVoids())%></td>

                        </tr>
<%} %> 
                    </tbody>
                </table>