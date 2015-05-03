  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                        <td colspan="3">
                        <%if(StringUtil.isNull(cp.getIsprism()).equals("Y")){ %>
                        <a href="rptmgr.do?a=summaryPrism&cpid=<%=cp.getCpid() %>"><span class="label label-warning" style="margin-right:6px">P</span></a>
                        <%}%>
                        <%=cp.getCpname() %>
                        <%-- 
                        <a class="btn btn-warning btn-xs" href="cpmgr.do?a=cpAddForm" role="button" style="float:right;margin-left:5px;">캠페인등록</a>
                        --%><a class="btn btn-primary btn-xs" href="rptmgr.do?a=summary&cpid=<%=cp.getCpid() %>" role="button" style="float:right;margin-left:5px;">리포트</a>
                        <a class="btn btn-success btn-xs" href="cpmgr.do?a=cpEditForm&cpid=<%=cp.getCpid() %>" role="button" style="float:right;margin-left:5px;">수정</a>
                         </td>
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
                        <td><%=StringUtil.addComma(cp.getBook_total()) %></td>
                        <th>목표량</th>
                        <td><%=StringUtil.addComma(cp.getGoal_total()) %></td>
                        <th>집행금액</th>
                        <td><%=StringUtil.addComma(cp.getBudget()) %></td>
                    </tr>
                    <tr>
                        <th>시작일</th>
                        <td><%=DateUtil.getYMD(cp.getStartdate(), "-") %></td>
                        <th>종료일</th>
                        <td><%=DateUtil.getYMD(cp.getEnddate(), "-") %></td>
                        <th>상태</th>
                        <td><span class="<%=cp.getText()%>"><%=StringUtil.isNull(cp.getCp_statename()) %></span></td>
                    </tr>
                </table>