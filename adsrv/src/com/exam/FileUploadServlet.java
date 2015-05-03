package com.exam;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.Gson;






import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;

import tv.pandora.adsrv.common.Constant;
import tv.pandora.adsrv.common.util.DateUtil;









/**
 * 브라우저로부터 전달받은 파일을 저장.
 * 요청정보 및 파일정보를 JSON형태로 응답.
 */
@WebServlet("/FileUploadServlet") 
public class FileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		//응답콘텐츠타입을 JSON형태로 지정 
		//TODO: Iframe을 통한 JSON형태의 결과를 받을때 다운로드 창이 뜨는 문제. 
		//response.setContentType("application/json; charset=UTF-8"); 
		//response.setContentType("text/plain; charset=UTF-8");
		
		//Iframe 기반으로된 업로드방식은 응답 콘테츠 타입이 application/json일 경우 
		//원하지 않는 다운로드 대화상자를 볼수있습니다.
		//그래서 Content-type 이 text/plain or text/html 형식이어야합니다. 
		//참고: http://javaking75.blog.me/220073311435
		
		//System.out.println(request.getHeader("accept"));
		if (request.getHeader("accept").indexOf("application/json") != -1) {
	        response.setContentType("application/json; charset=UTF-8");
	    } else {
	        // IE workaround
	        response.setContentType("text/plain; charset=UTF-8");
	    }		
		
		PrintWriter out = response.getWriter();
		
		RequestModel model = new RequestModel();
		
		try {
			//디스크상의 실제 경로 얻기
			String contextRootPath = this.getServletContext().getRealPath("/");
			
			//1. 메모리나 파일로 업로드 파일 보관하는 FileItem의 Factory설정
			DiskFileItemFactory diskFactory = new DiskFileItemFactory(); 
System.out.println("contextRootPath-----"+contextRootPath);			
			//임시 저장폴더
			diskFactory.setRepository(new File(contextRootPath + "/WEB-INF/temp"));
			
			//2. 업로드 요청을 처리하는 ServletFileUpload 생성     
			ServletFileUpload upload = new ServletFileUpload(diskFactory); 
			upload.setSizeMax(10 * 1024 * 1024); //10MB : 전체 최대 업로드 파일 크기
			//upload.setFileSizeMax(10 * 1024 * 1024); //10MB : 파일하나당 최대 업로드 파일 크기
			
			//3. 업로드 요청 파싱해서 FileItem 목록 구함
			@SuppressWarnings("unchecked")
			List<FileItem> items = upload.parseRequest(request); 
			Integer fileIdx = 0;
			for(FileItem item : items) {
				System.out.println("item-----"+item);			
				
				//5. FileItem이 폼입력 항목인지 여부에 따라 알맞은 처리
				if (item.isFormField()) { //파일이 아닌경우					
					processFormField(model, item);							
				} else { //파일인 경우
					fileIdx++;
					if(item.getSize()!=0) { //업로드된 파일이 있을경우에만 처리
						processUploadFile(fileIdx, model, item, contextRootPath);	
					}														
				}			
			}
			
			//값 객체(VO,DTO)를 JSON형태로 문자열로 변환하기 위핸 Gson객체 생성.
			Gson gson = new Gson();
			String outString = gson.toJson(model);
			//System.out.println(outString);
			out.print(outString);			
			
		} catch(Exception e) {	
			
			e.printStackTrace();
			
			out.print("{\"result\":\"500\"");
			out.print(",\"msg\":\""+e.getMessage());			
			out.print("\"}");				
		}
	}

	//파일 양식 처리
	private void processUploadFile(
			Integer fileIdx, RequestModel model, FileItem item, String contextRootPath) throws Exception {
		
		String name = item.getFieldName(); //필드 이름 얻기
		String fileName = item.getName(); //파일명 얻기
		String contentType = item.getContentType(); //컨텐츠 타입 얻기
		
		String sep = System.getProperty("file.separator");		

		long fileSize = item.getSize(); //파일의 크기 얻기
	System.out.println("fileName======"+fileName);
	
	
	
	String myFileName = "",
	slashType = (fileName.lastIndexOf("\\") > 0) ? "\\" : "/"; // Windows or UNIX
	
	System.out.println("slashType======"+slashType);
int
	startIndex = fileName.lastIndexOf(slashType);
System.out.println("startIndex======"+startIndex);
// Ignore the path and get the filename
myFileName = fileName.substring(startIndex + 1, fileName.length());
	
	
System.out.println("myFileName======"+myFileName);

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		//업로드 파일명을 현재시간으로 변경후 저장
		//String uploadedFileName = System.currentTimeMillis() + UUID.randomUUID().toString() +fileName.substring(fileName.lastIndexOf("."));
	String uploadedFileName = myFileName;
			//String uploadedFileName = fileName.substring(fileName.lastIndexOf("/"));//+fileName.substring(fileName.lastIndexOf("."));
		//저장할 절대경로로 파일 객체 생성
		//File uploadedFile = new File(contextRootPath + "/upload/" + uploadedFileName); 
				
		String localFilePath = contextRootPath + sep + "upload" +sep+ uploadedFileName;
		
		File uploadedFile = new File(localFilePath); 
				
		
		item.write(uploadedFile); //파일 저장
		
		String remoteFilePath = Constant.FTP_REMOTE_PATH+"/"+DateUtil.curDate().substring(0,6);
System.out.println("remoteFilePath=="+remoteFilePath);		
		//FTP 업로드
		Integer result = ftpUpload(localFilePath, remoteFilePath, uploadedFileName);
		
		System.out.println("remote result =="+result);		
		
		String imgUrl = Constant.IMG_WEB_URL+"/"+DateUtil.curDate().substring(0,6)+"/"+uploadedFileName;
		System.out.println("imgUrl=="+imgUrl);		
						
		FileInfoModel fileInfoModel = new FileInfoModel(fileIdx, name, myFileName, 
				                                       uploadedFileName, fileSize, contentType, imgUrl);
		 
		System.out.println("fileInfoModel=="+fileInfoModel);		
		if("photo".equals(name)) {
			List<FileInfoModel> photoList = model.getPhoto();
			if(photoList == null ) photoList = new ArrayList<FileInfoModel>();
			photoList.add(fileInfoModel);
			model.setPhoto(photoList);
		} else if("file".equals(name)) {
			model.setFile(fileInfoModel);
		}	
		item.delete(); //파일과 관련된 자원을 제거한다.
	}
	
	//일반 양식 처리
	private void processFormField(RequestModel model, FileItem item) throws Exception{
		String name = item.getFieldName();
		String value = item.getString("UTF-8");
		
		//요청파라미터의 이름에 따라 값객체(RequestModel)에 값 할당.
		if("title".equals(name)) {
			model.setTitle(value);
		} else if("description".equals(name)) {
			model.setDescription(value);
		}
	}
	
	private static void ftpCreateDirectoryTree( FTPClient client, String dirTree ) throws IOException {

		  boolean dirExists = true;

		  //tokenize the string and attempt to change into each directory level.  If you cannot, then start creating.
		  String[] directories = dirTree.split("/");
		  for (String dir : directories ) {
		    if (!dir.isEmpty() ) {
		      if (dirExists) {
		        dirExists = client.changeWorkingDirectory(dir);
		      }
		      if (!dirExists) {
		        if (!client.makeDirectory(dir)) {
		          throw new IOException("Unable to create remote directory '" + dir + "'.  error='" + client.getReplyString()+"'");
		        }
		        if (!client.changeWorkingDirectory(dir)) {
		          throw new IOException("Unable to change into newly created remote directory '" + dir + "'.  error='" + client.getReplyString()+"'");
		        }
		      }
		    }
		  }     
		}
	
    /* 일반 FTP 방식으로 파일을 업로드 함
    *
    */
	public int ftpUpload(String localFilePath, String remoteFilePath, String fileName) throws Exception {
	  
	  FTPClient ftp = null; // FTP Client 객체
	  FileInputStream fis = null; // File Input Stream
	  File uploadfile = new File(localFilePath); // File 객체
	  
	  String url  = Constant.REMOTE_HOST_NAME;  
	  String id  = Constant.FTP_USER_NAME;
	  String pwd  = Constant.FTP_PASSWORD;
	  String port = "21";
	 
	 
	  int result = -1;

	  try{   
	      ftp = new FTPClient(); // FTP Client 객체 생성
	      ftp.setControlEncoding("UTF-8"); // 문자 코드를 UTF-8로 인코딩
	      ftp.connect(url, Integer.parseInt(port)); // 서버접속 " "안에 서버 주소 입력 또는 "서버주소", 포트번호
	      ftp.login(id, pwd); // FTP 로그인 ID, PASSWORLD 입력
	      ftp.enterLocalPassiveMode(); // Passive Mode 접속일때 
	      
	      ftpCreateDirectoryTree(ftp, remoteFilePath);
	      ftp.changeWorkingDirectory(remoteFilePath); // 작업 디렉토리 변경
	      ftp.setFileType(FTP.BINARY_FILE_TYPE); // 업로드 파일 타입 셋팅
	      
	      try{
	          fis = new FileInputStream(uploadfile); // 업로드할 File 생성
	          boolean isSuccess = ftp.storeFile(uploadfile.getName(), fis); // File 업로드
	      
System.out.println("isSuccess=================="+isSuccess);	      	      
	          
	          if (isSuccess){
	        	  result = 1; // 성공     
	          }
	          else{
	        	  //throw new CommonException("파일 업로드를 할 수 없습니다.");
	          }
	      } catch(IOException ex){
	    	  System.out.println(ex.getMessage());
	      }finally{
	          if (fis != null){
	              try{
	                  fis.close(); // Stream 닫기
	                  return result;
	                  
	              }
	              catch(IOException ex){
	                  System.out.println("IO Exception : " + ex.getMessage());
	              }
	          }
	      }
	      ftp.logout(); // FTP Log Out
	  }catch(IOException e){
	      System.out.println("IO:"+e.getMessage());
	  }finally{
	      if (ftp != null && ftp.isConnected()){
	          try{
	              ftp.disconnect(); // 접속 끊기
	              return result;
	          }
	          catch (IOException e){
	              System.out.println("IO Exception : " + e.getMessage());
	          }
	      }
	  }
	  return result;  
	 }
	 
	
	
}