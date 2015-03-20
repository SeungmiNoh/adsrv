package tv.pandora.adsrv.common.session;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener  {
	@Override
	 public void sessionCreated(HttpSessionEvent event) {
	  HttpSession ss = event.getSession();	  
	  
	  long time = ss.getCreationTime();
	  String sessionID = ss.getId();
	  	 	  
	  System.out.println("["+time+" ] 세션 생성 ID : "+sessionID);
	  System.out.println("세션 COUNT : "+SessionManager.getInstance().count());
	  
	  //SessionManager 세션추가
	  SessionManager.getInstance().add(ss);
	 }
	 
	 @Override
	 public void sessionDestroyed(HttpSessionEvent event) {
	  HttpSession ss = event.getSession();
	 
	  
	  long time = ss.getCreationTime();
	  long ltime = ss.getLastAccessedTime(); // 마지막 접속 시간
	  long ctime = System.currentTimeMillis(); // 현재시간
	  
	  int sscnt = SessionManager.getInstance().count();
	  String sessionID = ss.getId();
	  
	  System.out.println("["+time+" ] 세션 소멸 ID : "+sessionID + "(총 접속시간 : "+(ctime-ltime)+"ms)");
	  System.out.println("세션 COUNT : "+SessionManager.getInstance().count());
	  /*
	 	Connection con = null;
	    PreparedStatement pstmt = null;
	    PreparedStatement pstmt2 = null;
	    ResultSet rs = null;

	    
      try 
      {	            	

    	  Class.forName("com.mysql.jdbc.Driver");
    	  con = DriverManager.getConnection("jdbc:mysql://121.254.176.64/adekorea?autoReconnect=true&maxReconnects=5&initialTimeout=3&useUnicode=true&characterEncoding=utf8", "adekorea", "rhksgnsehd");
    	  pstmt = con.prepareStatement("insert into common.session_end (idx, sessionid, create_time, last_time, curr_time, acess_time, session_cnt, updatedate) values (0, ?, ?, ?, ?, ?, ?, now())");
          pstmt.setString(1, String.valueOf(sessionID));          
          pstmt.setString(2, String.valueOf(time));          
          pstmt.setString(3, String.valueOf(ltime));          
          pstmt.setString(4, String.valueOf(ctime));          
          pstmt.setString(5, String.valueOf((ctime-ltime)));          
          pstmt.setString(6, String.valueOf(sscnt));          
          pstmt.execute();		 


      } catch (Exception ex) {
          System.out.println("DB insert error" + ex);
      } finally {
          try {
              if(pstmt != null) pstmt.close();
              if(pstmt2 != null) pstmt2.close();
              if(con != null) con.close();
          } catch (SQLException ex) { ex.printStackTrace();}
      } 					
	  
	*/  
	  
	  
	  
	  
	  
	  //SessionManager 세션삭제
	  SessionManager.getInstance().remove(ss);

	  
	 }


}
