/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.compile;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.oj.domain.Result;
import com.oj.domain.Submissions;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author brizz
 */
public abstract class ProcessExecutor {
 
    protected String usercode;
    protected String testdata;
    protected String webpath;
    protected String srcpath;
    protected ProcessExecutor nextExecutor;
    protected String lan;

    public ProcessExecutor(String usercode, String testdata, String webpath, String srcpath, ProcessExecutor nextExecutor, String lan) {
        this.usercode = usercode;
        this.testdata = testdata;
        this.webpath = webpath;
        this.srcpath = srcpath;
        this.nextExecutor = nextExecutor;
        this.lan = lan;
    }

    
    public void setUsercode(String usercode) {
        this.usercode = usercode;
    }

    public void setTestdata(String testdata) {
        this.testdata = testdata;
    }

    public void setWebpath(String webpath) {
        this.webpath = webpath;
    }

    public void setSrcpath(String srcpath) {
        this.srcpath = srcpath;
    }

    public void setLan(String lan) {
        this.lan = lan;
    }
    
    
    public void setNextExecutor(ProcessExecutor nextExecutor) {
        this.nextExecutor = nextExecutor;
    }
    public boolean doTask(String ulan,Long sid,String pcode)
    {
        boolean isSupported=true;
        List<Result> res=null;
        System.out.println(ulan + " "+lan);
        if(ulan.equals(lan))
        {
            Configuration c = new Configuration();
        
            c.configure("/com/oj/cfgs/hibernate.cfg.xml");
                                           
            SessionFactory sf=c.buildSessionFactory();
            Session s=sf.openSession();
            Submissions sub=(Submissions)s.get(Submissions.class,sid);
            Transaction tx=null;
            System.out.println("Undar.....");
            boolean done=compile();
            System.out.println(done);
            if(done){
                
                res=execute(sub.getProblems().getTimelimit()*1000,pcode);
                
                int verdict=0;
                for(Result r:res)
                {
                    
                    sub.setTimetaken(Float.max(sub.getTimetaken(),(r.timetaken/1000.0f)));
                    sub.setMemoryused(Float.max(sub.getMemoryused(),(r.memory)));
                    if(r.result.equals("WA"))
                        verdict=1;
                    else if(r.result.equals("TLE") && (verdict==0 || verdict==3))
                        verdict=2;
                    else if(r.result.equals("RTE") && verdict==0)
                        verdict=3;
                }
                switch (verdict) {
                    case 0:
                        sub.setVerdict("AC");
                        break;
                    case 1:
                        sub.setVerdict("WA");
                        break;
                    case 2:
                        sub.setVerdict("TLE");
                        break;
                    case 3:
                        sub.setVerdict("RTE");
                        break;
                    default:
                        break;
                }
            }
            else{
                res=new ArrayList<>();
                 res.add(new Result("CTE",0,0));
                sub.setVerdict("CTE");
                sub.setMemoryused(0);
                sub.setTimetaken(0);
            }
            sub.setCodepath(webpath+usercode);
            sub.setLan(ulan);
            try{
                
            tx=s.beginTransaction();
            s.update(sub);
            tx.commit();
            s.flush();
            s.close();
            sf.close();
            Gson gson = new Gson();
            Type type = new TypeToken<List<Result>>() {}.getType();
            String json = gson.toJson(res, type);
            JSONParser parser = new JSONParser();
            JSONObject o;
            
                o = (JSONObject) parser.parse(new FileReader(webpath+"/Usercode/Submissions/results.json"));     
                o.put(sid+"",json);

                try (FileWriter file = new FileWriter(webpath+"/Usercode/Submissions/results.json")) {
                    file.write(o.toString());
                }
            }
            catch(HibernateException ex)
            {
                tx.rollback();
                s.flush();
                s.close();
                sf.close();
                System.out.println("ROLLED BACK ...."+ex);
            }
            catch (FileNotFoundException ex) {
                System.out.println("File nahi mili ...."+ex);
            } catch (IOException ex) {
                System.out.println("IO Error ...."+ex);
            } catch (ParseException ex) {
                System.out.println("Json Error ...."+ex);
            }
       
        }
        else if(nextExecutor != null)
        {
            nextExecutor.doTask(ulan,sid,pcode);
        }
        else
            isSupported=false;
        
        return isSupported;
    }
    abstract public  boolean compile();
    abstract public List<Result> execute(Float tlimit,String pcode);
}
