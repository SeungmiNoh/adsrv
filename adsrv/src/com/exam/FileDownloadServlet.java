package com.exam;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class FileDownServlet
 */
@WebServlet("/FileDownload")
public class FileDownloadServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, UnsupportedEncodingException {
		
		String filename = request.getParameter("f");		
		//String filename = new String(fname.getBytes("iso-8859-1"),"UTF-8");
		String of = request.getParameter("of"); //인코딩 서버 기본값 ("iso-8859-1")
		
		System.out.println("filename="+filename);
		System.out.println("uploadedFilneName="+of);
		
		if(filename==null||filename.trim().equals("")){
			return;
		}
		
		//업로드 디렉토리의 절대경로 얻기
		String uploadPath = null;
		HttpSession ses = request.getSession();
		ServletContext ctx = ses.getServletContext();
		uploadPath = ctx.getRealPath("upload");
		
		//uploadPath = getServletContext().getRealPath("upload");
		//uploadPath = request.getServletContext().getRealPath("upload");
		
		//업로드 경로와 파일이름을 가지고 File인스턴스 생성
		File downloadFile = new File(uploadPath+"/"+filename);
		
		String userAgent = request.getHeader("User-Agent");
		//System.out.println(userAgent);
		
		//boolean ie = userAgent.indexOf("MSIE") > -1;
		//boolean ie = userAgent.indexOf("Trident") > -1; // IE11 문자열 깨짐 방지
		//참고 : http://javaking75.blog.me/220073352593
		boolean ie = (userAgent.indexOf("MSIE") > -1) || (userAgent.indexOf("Trident") > -1); 
		if (ie) of = URLEncoder.encode(of, "iso-8859-1").replaceAll("\\+", "%20");

		//웹브라우저가 파일을 다운로드 받로록 하려면 다음과 같이 컨테츠타입지정
		response.setContentType("application/octet-stream");
		//response.setContentType("application/download; charset=utf-8");		 
		response.setContentLength((int)downloadFile.length());//콘텐트 크기 지정
		//Content-Disposition헤더를 이용해서 전송되는 파일의 이름을 명시
		response.setHeader("Content-Disposition", "attachment; filename=\""+ of +"\"");
		//전송되는 데이터의 인코딩이 바이너리 타입이라는것을 명시
		response.setHeader("Content-Transfer-Encoding","binary");
		response.setHeader("Pragma",  "no-cache;");
		response.setHeader("Expires", "-1;");
		
		
		BufferedOutputStream bos=null;
		BufferedInputStream bis =null;		
		try {
			bos = new BufferedOutputStream(response.getOutputStream());
			bis = new BufferedInputStream(new FileInputStream(downloadFile));
			
			byte[] buffer = new byte[1024];
			int len = -1;
			while((len=bis.read(buffer)) != -1) {
				bos.write(buffer,0,len);			
			}
			//bos.flush();
			
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			
			if( bis!=null)
				try { bis.close(); } catch (IOException e) {}				
			if( bos!= null)
				try { bos.close(); } catch (IOException e) {}					
		}			
	}
}
