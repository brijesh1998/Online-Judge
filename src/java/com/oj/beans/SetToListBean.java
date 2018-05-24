/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.beans;

import com.oj.domain.Comments;
import com.oj.domain.Submissions;
import com.oj.domain.UserLikesComments;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author brizz
 */
public class SetToListBean {
    
    public List<Comments> doIt(Set<Comments> cmts){
    
        List<Comments> clist=new ArrayList();
        clist.addAll(cmts);
        Collections.sort(clist, (Comments o1, Comments o2) -> {
           
            Long x1 = ((Comments) o1).getId();
            Long x2 = ((Comments) o2).getId();
            return x1.compareTo(x2);
        });
        List<Comments> finalans=new ArrayList();
       
        for(Comments c:clist){
        if(c.isApproved())
            finalans.add(c);
        }
        for(Comments c:clist){
        if(!c.isApproved())
            finalans.add(c);
        }
        
        return finalans;
        
        }
    public int giveCount(Long cid){
    
        Configuration c = new Configuration();
        
        c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                           
        SessionFactory sf=c.buildSessionFactory();
        Session s=sf.openSession();
        
        Criteria cr= s.createCriteria(UserLikesComments.class);
        List<UserLikesComments> ulcs=cr.list();
        int count=0;
        for(UserLikesComments ulc:ulcs)
            if(ulc.getComments().getId() == cid)
            count+=ulc.getUpdown();
        
        s.close();
        return count;
    }
    public int countSub(String id){
        int count=0;
        try{
        Configuration c = new Configuration();
        
        c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                           
        SessionFactory sf=c.buildSessionFactory();
        Session s=sf.openSession();
        
        Criteria cr= s.createCriteria(Submissions.class);
        List<Submissions> ss=cr.list();
        
        for(Submissions sub:ss){
            if(sub.getProblems() != null)
            if(sub.getVerdict().equals("AC") && id.equals(sub.getProblems().getProblemcode()))
                count++;
        }
        }
        catch(Exception e){
        System.out.println("ERROR : "+e);}
       // s.close();
        return count;
    }
    
    public int getVer(String id,String ver){
        Configuration c = new Configuration();
        
        c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                           
        SessionFactory sf=c.buildSessionFactory();
        Session s=sf.openSession();
        
        Criteria cr= s.createCriteria(Submissions.class);
        List<Submissions> ss=cr.list();
        int count=0;
        for(Submissions sub:ss){
            if(sub.getVerdict().equals(ver) && id.equals(sub.getUser().getUsername()))
                count++;
        }
        s.close();
        return count;
    }
    
    
}

