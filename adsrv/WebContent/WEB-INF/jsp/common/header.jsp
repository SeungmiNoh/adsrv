<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>    
<%@page import="tv.pandora.adsrv.common.session.SessionUtil"%>
<%@page import="tv.pandora.adsrv.common.session.SessionManager"%>
<%@page import="tv.pandora.adsrv.common.util.CookieUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%
String userID = StringUtil.isNull((String)SessionUtil.getAttribute("userID") );
String userName = StringUtil.isNull((String)SessionUtil.getAttribute("userName") );
String userType = StringUtil.isNull((String)SessionUtil.getAttribute("userType") );

String c_url = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 
String temp = c_url.substring( c_url.indexOf("jsp")+4);
String menu = temp.substring( 0,temp.indexOf("/"));

%>
               <section class="topMenu">
                <header>
                    <h1><img src="../img/logo.gif" alt=""></h1>
                    <!-- top menu Start -->
                    <nav>
                        <ul>
                            <li>
                                <a href="cpmgr.do?a=cpList" <%=menu.equals("campaign")?"class='active'":"" %>>캠페인</a>
                                <div class="sub">
                                    <ul>
                                        <li><a href="cpmgr.do?a=cpList" class="active">캠페인</a>
                                        </li>
                                        <li><a href="cpmgr.do?a=adsList">애즈</a>
                                        </li>
                                        <li><a href="cpmgr.do?a=crList">광고물</a>
                                        </li>
                                        <li><a href="cpmgr.do?a=targetList">타켓팅</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li>
                                <a href="" <%=menu.equals("report")?"class='active'":"" %>>리포트</a>
                                <div class="sub">
                                    <ul>
                                        <li><a href="">캠페인</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li>
                                <a href="" <%=menu.equals("prism")?"class='active'":"" %>>프리즘</a>
                                <div class="sub">
                                    <ul>
                                        <li><a href="">마스터 메인</a>
                                        </li>
                                        <li><a href="">캠페인</a>
                                        </li>
                                        <li><a href="">매체</a>
                                        </li>
                                        <li><a href="">타켓팅</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li>
                                <a href="" <%=menu.equals("morniter")?"class='active'":"" %>>광고운영</a>
                                <div class="sub">
                                    <ul>
                                        <li><a href="">위치 모니터링</a>
                                        </li>
                                        <li><a href="">애즈 모니터링</a>
                                        </li>
                                        <li><a href="">수동라이브</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li><a href="" <%=menu.equals("site")?"class='active'":"" %>>사이트</a>
                                <div class="sub">
                                    <ul>
                                        <li><a href="sitemgr.do?a=siteList">사이트</a>
                                        </li>
                                        <li><a href="sitemgr.do?a=secList">섹션</a>
                                        </li>
                                        <li><a href="sitemgr.do?a=slotList">위치</a>
                                        </li>
                                        <li><a href="sitemgr.do?a=slotGroupList">위치 그룹</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                            <li><a href="" <%=menu.equals("user")?"class='active'":"" %>>계정</a>
                                <div class="sub">
                                    <ul>
                                        <li><a href="usermgr.do?a=corpList">업체</a>
                                        </li>
                                        <li><a href="usermgr.do?a=userList">사용자</a>
                                        </li>
                                        <li><a href="">퍼미션</a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </nav>
                    <!-- top menu End -->
                    <!-- info Start -->
                    <div class="info">
                        <span><%= userName %> (전체관리자)님</span>
                        <strong>
                        <a href="login.do?a=logout"><button type="submit" class="btn infoBtnColor btn-xs"><span class="glyphicon glyphicon-remove"></span> 로그아웃</button></a>
                    </strong>
                    </div>
                    <!-- info End -->
                </header>
            </section>
