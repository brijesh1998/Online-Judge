
package com.oj.beans;

import com.oj.domain.User;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author brizz
 */
public class SendMailBean {
    
    public static void sendMail(String to,String sub,String body)
    {
                Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");

		Session session = Session.getDefaultInstance(props,
			new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("tpp.project123@gmail.com","ddit@123");
				}
			});

		try {

			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("tpp.project123@gmail.com"));
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(to));
			message.setSubject(sub);
			message.setText(body);

			Transport.send(message);

			//System.out.println("Done");

		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}
    }
    private static String generateRandom()
    {
        String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890qwertyuioplkjhgfdsazxcvbnm";
        StringBuilder salt = new StringBuilder();
        Random rnd = new Random();
        while (salt.length() < 20) 
        {  
            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
            salt.append(SALTCHARS.charAt(index));
        }
        String saltStr = salt.toString();
        return saltStr;
    }
    public static String sendMailForChangePWD(String user,String url)
    {
        String ran=generateRandom();
        
        Configuration c = new Configuration();
        
        c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                           
        SessionFactory sf=c.buildSessionFactory();
        org.hibernate.Session s=sf.openSession();
        
        User u=(User)s.get(User.class,user);
        url+="?ch="+ran+"&uid="+u.getUsername();
        
        sendMail(u.getEmail(),"Change Password !","Change Password link is : "+url);
        s.flush();
        s.close();
        sf.close();
        return ran;
    }
}
