/**
 * 
 */
package tv.pandora.adsrv.common.handler;

import java.util.Locale;
import org.springframework.context.MessageSource;

/**
 * @author Administrator
 *
 */
public class MessageHandler {

	private MessageSource messageSource;
	private Locale codeLocale = new Locale("ko");
	
	public void setMessageSource(MessageSource msgSource) {
		this.messageSource = msgSource;
	}
	
	public String[] getErrMessage(String id) {
		return this.getErrMessage(id, null);
	}
	
	public String[] getErrMessage(String id, Object[] args) {
		String[] result = new String[2];
		
		result[0] = messageSource.getMessage(id, args, this.codeLocale);
		result[1] = messageSource.getMessage(id, args, Locale.KOREAN);
		
		return result;
	}
}
