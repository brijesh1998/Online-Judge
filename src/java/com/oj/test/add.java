/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.test;

import com.oj.domain.Admin;
import com.oj.domain.User;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author brizz
 */
public class add {
   public static void main(String[] args) throws Exception
  {                                           // create Configuration class
                                                // Configuration object parses and reads .cfg.xml file
    String uname="uname";
        String name="name";
        String pwd="pwd";
        String email="email";
        String gender="male";
        Configuration c = new Configuration();
        c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                             // SessionFactory holds cfg file properties like
                                             // driver props and hibernate props and mapping file
        SessionFactory sf=c.buildSessionFactory();
                                            // create one session means Connection
        Session s = sf.openSession();
                                            // before starting save(),update(), delete() operation we need to start TX
        User user =  (User) s.get(User.class,uname);
        if(user != null)
        {
            System.out.println("error");
            
        }
        Transaction tx = s.beginTransaction();
 
        try
        {
            User u=new User();
            u.setUsername(uname);
            u.setFullname(name);
            u.setEmail(email);
            u.setPassword(pwd);
             u.setInstitution("-");
            u.setCountry("-");
            u.setState("-");
            u.setCity("-");
            u.setPosition("student");
            
            s.save(u);                              // stmt.addBatch("INSERT INTO school VALUES (....)");
    
 
            s.flush(); // stmt.executeBatch()
            tx.commit(); // con.commit();
            s.close();
            System.out.println("Records inserted");
            
        }
        catch(Exception e)
        {
            tx.rollback();                            // con.rollback();
        }

  } 
    
}
