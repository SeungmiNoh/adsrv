<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>    
<%

//String actionPath = request.getParameter("actionPath");

String actionForm = request.getParameter("actionForm");

int nowPage = Integer.valueOf(StringUtil.isNullReplace(request.getParameter("nowPage"), "1"));
int totalCount = Integer.valueOf(StringUtil.isNullZero(request.getParameter("totalCount")));
int countPerPage = Integer.valueOf(StringUtil.isNullReplace(request.getParameter("countPerPage"), "1"));
int countPerBlock = Integer.valueOf(StringUtil.isNullReplace(request.getParameter("blockCount"), "1"));



int totalPage  = totalCount/countPerPage + (totalCount%countPerPage>0?1:0);
int totalBlock = (totalPage /countPerBlock)+(totalPage %countPerBlock>0?1:0);
int nowBlock   = (nowPage/countPerBlock)+(nowPage%countPerBlock>0?1:0);

int firstPage = 1;
int lastPage = 0;

int startPage = (nowBlock-1) * countPerBlock + 1;
int endPage =  nowBlock * countPerBlock;


if(endPage > totalPage) {
	endPage = totalPage;
}

%>
<link type="text/css" rel="stylesheet" href="css/base.css" />
<script type="text/javascript">
var formID = "<%=actionForm%>";

function gotoPage(pageNum) {
    $("#page").val(pageNum);
	$("#"+formID).submit();
}
</script>
<div class="center">
                    <!-- pagination Start -->
                    <nav>
                        <ul class="pagination pagination-sm">
                            <li><%if (nowBlock > 1) { %> 
                                <a href="javascript:gotoPage('<%=startPage-10%>')" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                                <%}%>
                            </li>
                            
<%
	for (int pg = startPage; pg <= endPage; pg++) { 
	
		
	%>
                            
    						<li class="<%=pg == nowPage?"active":""%>" ><a href="javascript:gotoPage('<%=pg%>')"><%=pg %></a>
                            </li>
     <%} %>                       
                            <li><%if (nowBlock < totalBlock) { %>
                                <a href="javascript:gotoPage('<%=endPage+1%>')" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                                <%} %>
                            </li>
                        </ul>
                    </nav>
                    <!-- pagination End -->
                </div>
                
                
                

