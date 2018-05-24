/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.listeners;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * Web application lifecycle listener.
 *
 * @author brizz
 */
public class Listener implements ServletContextListener, HttpSessionListener, HttpSessionAttributeListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
       System.out.print("app started .... :)");
       Configuration c = new Configuration();
        
        c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                           
        SessionFactory sf=c.buildSessionFactory();
       sce.getServletContext().setAttribute("sf",sf);
       sce.getServletContext().setAttribute("webpath","/home/brizz/NetBeansProjects/OnlineJudgeSDP/web");
       sce.getServletContext().setAttribute("srcpath","/home/brizz/NetBeansProjects/OnlineJudgeSDP/src/java");
       
        InetAddress ip=null;
        try {
            ip = InetAddress.getLocalHost();
        } catch (UnknownHostException ex) {
            Logger.getLogger(Listener.class.getName()).log(Level.SEVERE, null, ex);
        }
           
        ExecutorService executor=Executors.newSingleThreadExecutor();
        sce.getServletContext().setAttribute("executor", executor);
       sce.getServletContext().setAttribute("appurl",ip.getHostAddress()+":8084");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        
        SessionFactory sf=(SessionFactory)sce.getServletContext().getAttribute("sf");
        sf.close();
        ExecutorService executor=(ExecutorService)sce.getServletContext().getAttribute("executor");
        executor.shutdown();
        
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        System.out.print("Session started.....");
        se.getSession().setAttribute("role","norole");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
       
    }

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {
       
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {
     
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {
     
    }
}
