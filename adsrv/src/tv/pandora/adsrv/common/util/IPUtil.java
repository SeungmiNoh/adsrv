package tv.pandora.adsrv.common.util;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;

public class IPUtil 
{/*
	public static void main(String[] args) 
	{
		IPUtil ipUtil = new IPUtil();
		System.out.println(ipUtil.getLocalServerIp());
	}*/

	// 현재 서버의 IP 주소를 반환한다.
	public static String getLocalServerIp() 
	{
		try 
		{
			for (Enumeration<NetworkInterface> enumeration = NetworkInterface.getNetworkInterfaces(); 
					enumeration.hasMoreElements();) 
			{
					NetworkInterface networkInterface = enumeration.nextElement();
						for (Enumeration<InetAddress> enumerationIpAddress = networkInterface.getInetAddresses(); 
								enumerationIpAddress.hasMoreElements();) {
								InetAddress iNetAddress = enumerationIpAddress.nextElement();
								if (!iNetAddress.isLoopbackAddress()
										&& !iNetAddress.isLinkLocalAddress()
										&& iNetAddress.isSiteLocalAddress()) {
									return iNetAddress.getHostAddress().toString();
								}
						}
			}
		} catch (SocketException e) {
			e.printStackTrace();
		}
		return null;
	}
}
