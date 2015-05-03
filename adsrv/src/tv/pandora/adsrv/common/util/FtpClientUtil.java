package tv.pandora.adsrv.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPFile;
import org.apache.commons.net.ftp.FTPReply;

import tv.pandora.adsrv.common.Constant;

/**
 * <p>
 * ftp 연결 관리 (apache commons-net-1.4.1 lib 사용)
 * </p>
 * <p>Description: 에서 FTP 위에 다운로드 대한 계산서</p>
 * @author 张军,www.zuidaima.com
 * @version 1.0   20120912
 */
public class FtpClientUtil {
	private FTPClient ftpClient = null;
	private String server;
	private int port;
	private String userName;
	private String userPassword;
	/*
	private FtpClientUtil() {
		FtpClientUtil f = new FtpClientUtil(Constant.IMG_SERVER, 21, Constant.IMG_FTP_USER, Constant.IMG_FTP_PASSWORD);
		try {
			if (f.open()) {
				f.get("/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/qunarlog.txt", "E:/zhangjun.txt");// 원격 경로 위해 상대 경로
				f.close();
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
	 }
	
*/
	public static void main(String[] args) {
		FtpClientUtil f = new FtpClientUtil(Constant.REMOTE_HOST_NAME, 21, Constant.FTP_USER_NAME, Constant.FTP_PASSWORD);
		try {
			if (f.open()) {
				f.get("/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/qunarlog.txt", "E:/zhangjun.txt");// 원격 경로 위해 상대 경로
				f.close();
			}
		} catch (Exception e) {

			e.printStackTrace();
		}
	}
	//home/prismadv/prism_ad/201503
	//http://cdn.pandora.tv/_adv_img/prism_ad/201503/xxxx

	public FtpClientUtil(String server, int port, String userName,String userPassword) {
		this.server = server;
		this.port = port;
		this.userName = userName;
		this.userPassword = userPassword;
	}

	/**
	 * 서버에 연결
	 * 
	 * @return
	 * @throws Exception
	 */
	public boolean open() {
		if (ftpClient != null && ftpClient.isConnected()) {
			return true;
		}
		try {
			ftpClient = new FTPClient();
			// 연결
			ftpClient.connect(this.server, this.port);
			ftpClient.login(this.userName, this.userPassword);
			// 재귀적 연결 성공 여부
			int reply = ftpClient.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply)) {
				this.close();
				System.err.println("FTP server refused connection.");
				System.exit(1);
			}
			System.out.println("open FTP success:" + this.server+";port:"+this.port + ";name:"
					+ this.userName + ";pwd:" + this.userPassword);
			ftpClient.setFileType(ftpClient.BINARY_FILE_TYPE); // .binally 업로드 모드 설정
																// or ascii
			return true;
		} catch (Exception ex) {
			// 닫기
			this.close();
			ex.printStackTrace();
			return false;
		}

	}

	private boolean cd(String dir) throws IOException {
		if (ftpClient.changeWorkingDirectory(dir)) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 디렉터리 아래 모든 파일 이름을 얻다
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */

	private FTPFile[] getFileList(String filePath) throws IOException {
		FTPFile[] list = ftpClient.listFiles();
		return list;

	}

	/**
	 * 작업 디렉터리 설정 순환 것이다
	 */
	public boolean changeDir(String ftpPath) {
		if (!ftpClient.isConnected()) {
			return false;
		}
		try {

			// 는 경로 중 슬래시 통일
			char[] chars = ftpPath.toCharArray();
			StringBuffer sbStr = new StringBuffer(256);
			for (int i = 0; i <chars.length; i++) {

				if ('\\' == chars[i]) {
					sbStr.append('/');
				} else {
					sbStr.append(chars[i]);
				}
			}
			ftpPath = sbStr.toString();
			// System.out.println("ftpPath"+ftpPath);

			if (ftpPath.indexOf('/') == -1) {
				// 오직 한 층 목록
				// System.out.println("change"+ftpPath);
				ftpClient.changeWorkingDirectory(new String(ftpPath.getBytes(),
						"iso-8859-1"));
			} else {
				// 다층 목록 반복 만들기
				String[] paths = ftpPath.split("/");
				// String pathTemp = "";
				for (int i = 0; i <paths.length; i++) {
					// System.out.println("change "+paths[i]);
					ftpClient.changeWorkingDirectory(new String(paths[i]
							.getBytes(), "iso-8859-1"));
				}
			}

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 순환 디렉터리 생성, 그리고 다 디렉터리 생성 후 설정 작업 디렉터리를 만들 다음 현재 디렉터리
	 */
	public boolean mkDir(String ftpPath) {
		if (!ftpClient.isConnected()) {
			return false;
		}
		try {

			// 는 경로 중 슬래시 통일
			char[] chars = ftpPath.toCharArray();
			StringBuffer sbStr = new StringBuffer(256);
			for (int i = 0; i <chars.length; i++) {

				if ('\\' == chars[i]) {
					sbStr.append('/');
				} else {
					sbStr.append(chars[i]);
				}
			}
			ftpPath = sbStr.toString();
			System.out.println("ftpPath" + ftpPath);

			if (ftpPath.indexOf('/') == -1) {
				// 오직 한 층 목록
				
				ftpClient.makeDirectory(new String(ftpPath.getBytes(),
						"iso-8859-1"));
				ftpClient.changeWorkingDirectory(new String(ftpPath.getBytes(),
						"iso-8859-1"));
			} else {
				// 다층 목록 반복 만들기
				String[] paths = ftpPath.split("/");
				// String pathTemp = "";
				for (int i = 0; i <paths.length; i++) {
				
					ftpClient.makeDirectory(new String(paths[i].getBytes(),
							"iso-8859-1"));
					ftpClient.changeWorkingDirectory(new String(paths[i]
							.getBytes(), "iso-8859-1"));
				}
			}

			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * 업로드 파일로 FTP 서버
	 * 
	 * @param localPathAndFileName
	 *            로컬 파일 목록 및 파일 이름
	 * @param ftpFileName
	 *            올린 후 파일 이름
	 * @param ftpDirectory
	 *            FTP 디렉터리 예: /path1/pathb2/ 디렉터리가 존재하지 않습니다. 만약 다시 자동 디렉터리 만들기
	 * @throws Exception
	 */
	public boolean put(String localDirectoryAndFileName, String ftpFileName,
			String ftpDirectory) {
		if (!ftpClient.isConnected()) {
			return false;
		}
		boolean flag = false;
		if (ftpClient != null) {	
			File srcFile = new File(localDirectoryAndFileName);
			FileInputStream fis = null;
			try {
				fis = new FileInputStream(srcFile);

				// 디렉터리 만들기

				this.mkDir(ftpDirectory);

				ftpClient.setBufferSize(1024);
				ftpClient.setControlEncoding("UTF-8");

				// 설정 파일 형식 (바이너리)
				ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
				// 업로드
				flag = ftpClient.storeFile(new String(ftpFileName.getBytes(),
						"iso-8859-1"), fis);
			} catch (Exception e) {
				this.close();
				e.printStackTrace();
				return false;
			} finally {
				IOUtils.closeQuietly(fis);
			}
		}

		System.out.println("success put file " + localDirectoryAndFileName
				+ " to " + ftpDirectory + ftpFileName);
		return flag;
	}

	/**
	 * 에서 FTP 서버에서 다운로드 파일 다운로드 파일 길이 결코 복귀
	 * 
	 * @param ftpDirectoryAndFileName
	 * @param localDirectoryAndFileName
	 * @return
	 * @throws Exception
	 */
	public long get(String ftpDirectoryAndFileName,String localDirectoryAndFileName) {

		long result = 0;
		if (!ftpClient.isConnected()) {
			return 0;
		}
		ftpClient.enterLocalPassiveMode(); 
		try {
			// 는 경로 중 슬래시 통일
			char[] chars = ftpDirectoryAndFileName.toCharArray();
			StringBuffer sbStr = new StringBuffer(256);
			for (int i = 0; i <chars.length; i++) {

				if ('\\' == chars[i]) {
					sbStr.append('/');
				} else {
					sbStr.append(chars[i]);
				}
			}
			ftpDirectoryAndFileName = sbStr.toString();
			String filePath = ftpDirectoryAndFileName.substring(0,ftpDirectoryAndFileName.lastIndexOf("/"));
			String fileName = ftpDirectoryAndFileName.substring(ftpDirectoryAndFileName.lastIndexOf("/") + 1);
			this.changeDir(filePath);
			ftpClient.retrieveFile( new String(fileName.getBytes(),"iso-8859-1"), 
			new FileOutputStream(localDirectoryAndFileName)); // download
			System.out.print(ftpClient.getReplyString()); // check result

		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("Success get file" + ftpDirectoryAndFileName + " from " + localDirectoryAndFileName);
		return result;
	}

	/**
	 * FTP 디렉터리를 되돌려줍니다 다음 파일 목록
	 * 
	 * @param ftpDirectory
	 * @return
	 */
	public List getFileNameList(String ftpDirectory) {
		List list = new ArrayList();
		// if (!open())
		// return list;
		// try {
		// DataInputStream dis = new DataInputStream(ftpClient
		// .nameList(ftpDirectory));
		// String filename = "";
		// while ((filename = dis.readLine()) != null) {
		// list.add(filename);
		// }
		// } catch (Exception e) {
		// e.printStackTrace();
		// }
		return list;
	}

	/**
	 * FTP 위의 파일 삭제
	 * 
	 * @param ftpDirAndFileName
	 */
	public boolean deleteFile(String ftpDirAndFileName) {
		if (!ftpClient.isConnected()) {
			return false;
		}
		//Todo
		return true;
	}

	/**
	 * FTP 디렉터리 삭제
	 * 
	 * @param ftpDirectory
	 */
	public boolean deleteDirectory(String ftpDirectory) {
		if (!ftpClient.isConnected()) {
			return false;
		}
		//ToDo
		return true;
	}

	/**
	 * 이 링크
	 */
	public void close() {
		 try {
		 if (ftpClient != null && ftpClient.isConnected())
			 ftpClient.disconnect();
		 } catch (Exception e) {
			 e.printStackTrace();
		 }
		 System.out.println("Close Server Success :"+this.server+";port:"+this.port);
	}

	public FTPClient getFtpClient() {
		return ftpClient;
	}

	public void setFtpClient(FTPClient ftpClient) {

		this.ftpClient = ftpClient;
	}
}