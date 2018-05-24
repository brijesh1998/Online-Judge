/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.test;

import com.oj.domain.Submissions;
import java.io.IOException;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.json.*;

/**
 *
 * @author brizz
 */
public class addprob {
    
    public static void main(String []arg) throws JSONException, IOException, InterruptedException
    {
        Configuration c = new Configuration();
        
        c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                           
        SessionFactory sf=c.buildSessionFactory();
        Session s=sf.openSession();
       DetachedCriteria maxId = DetachedCriteria.forClass(Submissions.class).setProjection( Projections.max("submissionid"));
       
        List<Submissions> l=s.createCriteria(Submissions.class).add( Property.forName("submissionid").eq(maxId)).list();
        System.out.println(l.get(0).getSubmissionid());
    }
   
}
