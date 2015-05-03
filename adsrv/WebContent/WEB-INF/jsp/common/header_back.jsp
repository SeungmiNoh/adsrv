<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="tv.pandora.adsrv.common.util.StringUtil"%>
<%@page import="tv.pandora.adsrv.common.util.DateUtil"%>
<%@page import="tv.pandora.adsrv.common.Constant"%>    
<%@page import="tv.pandora.adsrv.common.session.SessionUtil"%>
<%@page import="tv.pandora.adsrv.common.session.SessionManager"%>
<%@page import="tv.pandora.adsrv.common.util.CookieUtil"%>
<%@page import="tv.pandora.adsrv.domain.Menu"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%
String userID = StringUtil.isNull((String)SessionUtil.getAttribute("userID") );
String userName = StringUtil.isNull((String)SessionUtil.getAttribute("userName") );
String userType = StringUtil.isNull((String)SessionUtil.getAttribute("userType") );
String userPername = StringUtil.isNull((String)SessionUtil.getAttribute("userPername") );

List<Menu> menuList = (List<Menu>)SessionUtil.getAttribute("menuList");
String c_url = javax.servlet.http.HttpUtils.getRequestURL(request).toString(); 

String temp = c_url.substring( c_url.indexOf("jsp")+4);
String webdir = temp.substring( 0,temp.indexOf("/"));
%>
<%-- 
<script>
console.log("c_url=<%=c_url%>");
console.log("temp=<%=temp%>");
console.log("menu=<%=menu%>");
</script>
--%>
               <section class="topMenu">
                <header>
                    <h1><img src="<%=Constant.WEB_ROOT%>/img/logo.gif" alt=""></h1>
                    <!-- top menu Start -->
                    <nav>
                        <ul>
 <%
 
 String cur_menu_id = "";
 
 
 for(int i =0; i<menuList.size(); i++){ 
 	 Menu mu = menuList.get(i);
 	 if(!cur_menu_id.equals(mu.getMenu_id())) {
  		if(!cur_menu_id.equals("")){
%>
                                    </ul>
                                </div>
                            </li>
 			<% 
 		}
 %>
 						<li>
                                <a href="<%=mu.getMainlink() %>" <%=webdir.equals(mu.getWebdir())?"class='active'":"" %>><%=mu.getMenu_name() %></a>
                                <div class="sub">
                                    <ul>		
<% 
		cur_menu_id = mu.getMenu_id();
 	}
  %>                       
                                        <li>
                                        <a href="<%=mu.getLink() %>"><%=mu.getMenu_sname() %></a>
                                        </li>
  <%} %>                                     
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </nav>
                    <!-- top menu End -->
                    <!-- info Start -->
                    <div class="info">
                          <span class="glyphicon glyphicon-user"></span><span>[<%=userPername %>] <%= userName %> 님</span>
                        <strong>
                        <a href="login.do?a=logout"><button type="submit" class="btn infoBtnColor btn-xs"><span class="glyphicon glyphicon-remove"></span> 로그아웃</button></a>
                    </strong>
                    </div>
                    <!-- info End -->
                </header>
            </section>
