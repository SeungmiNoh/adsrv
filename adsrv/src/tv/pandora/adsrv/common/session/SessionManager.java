package tv.pandora.adsrv.common.session;

import java.util.Hashtable;

import javax.servlet.http.HttpSession;

public class SessionManager {
 
	private static SessionManager sessionManager;
 	private Hashtable<String, HttpSession> session;
 
	 private SessionManager() {
		 session = new Hashtable<String, HttpSession>();
	 }
	 
	 
	 public static SessionManager getInstance() {
		 if (sessionManager == null) {
			 synchronized (SessionManager.class) {
				 if (sessionManager == null) {
					 sessionManager = new SessionManager();
				 }
			 }
		 }
		 return sessionManager;
	 }
 
 
	 /**
	  * 세션을 Hashtable에 추가
	  * @param httpSession
	  */
	 public void add(HttpSession httpSession) {
		 session.put(httpSession.getId(), httpSession);
	 }

 
	 /**
	  * 세션을 Hashtable에서 삭제
	  * @param httpSession
	  */
	 public void remove(HttpSession httpSession) {
		 session.remove(httpSession.getId());
	 }
 
 
	 /**
	  * 5분내 페이지를 열어본 세션 수
	  * @return
	  */
	 public int count() {
		 int count;
  
		 count = 0;
		 for (String key: session.keySet()) {
			 if (session.get(key) == null) {
				 continue;
			 }
   
			 try {
				 //현재시간 - 마지막접근시간 / 1000 > 300(5분) 
				 //즉 마지막접근시간 5분이 지났을경우는 count하지 않음. 
			    if ((System.currentTimeMillis() - session.get(key).getLastAccessedTime()) / 1000 > 300) {
			     continue;
			    }
			 } catch(IllegalStateException e) {
				 continue;
			 }
   
			 count++;
		 }
		 return count;
	 }
 
  
	 /**
	  * 생성되어 있는 세션갯수
	  * @return
	  */
	 public int totalCount() {
		 return session.size();
	 } 
}
