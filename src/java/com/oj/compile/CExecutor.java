/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.compile;

import com.oj.domain.Result;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author brizz
 */
public class CExecutor extends ProcessExecutor {
    
    public CExecutor(String usercode, String testdata, String webpath, String srcpath, ProcessExecutor nextExecutor, String lan) {
        super(usercode, testdata, webpath, srcpath, nextExecutor, lan);
    }

    
    @Override
    public boolean compile() {
        
        boolean done=false;
        try {
            String cmd="gcc "+ webpath+usercode + " -o "+srcpath+"/com/oj/compile/run.out";
            ProcessBuilder pb = new ProcessBuilder("bash" ,"-c",cmd);
            
            File error = new File(srcpath+"/com/oj/compile/error.txt");
            
            pb.redirectError(error);
            Process com=pb.start();
            com.waitFor();
            done=(error.length() == 0);
         //   error.delete();
            
        } catch (IOException ex) {
           System.out.println("cpp IO ERROR......"+ex);
        } catch (InterruptedException ex) {
           System.out.println("cpp TH ERROR......"+ex);
        }
        if(!done)
            System.out.println("c");
        return done;
    }

    @Override
    public List<Result> execute(Float tlimit,String pcode) {
        
        List<Result> res=new ArrayList<Result>();
        String runfile=srcpath+"/com/oj/compile/run.out";
        ProcessBuilder run = new ProcessBuilder("bash","-c",runfile);
        
        File error = new File(srcpath+"/com/oj/compile/error.txt");
        File output = new File(srcpath+"/com/oj/compile/output.txt");
                
        int tot=new File(testdata+"/"+pcode+"/input/").listFiles().length;
       
        for(int i=0;i<tot;i++){
        
            try {
                String tno=String.format("%02d",i);
                String td=testdata+"/"+pcode+"/input/input"+tno+".txt";
                File commands = new File(td);
                System.out.println("Testcase --------> "+tno);
                run.redirectInput(commands);
                run.redirectOutput(output);
                run.redirectError(error);
                
                long stime=System.currentTimeMillis();
                Process time=run.start();
                boolean finished = time.waitFor((long) Math.floor(tlimit), TimeUnit.MILLISECONDS);
                long etime=System.currentTimeMillis();
                long runtime=(etime - stime);
                if(runtime > (long) Math.floor(tlimit))
                    runtime=(long) Math.floor(tlimit) + 1;
                if (!finished ) 
                {
                    time.destroy();
                    time.waitFor();
                    res.add(new Result("TLE",runtime,0));
                    //   continue;
                 }
                else if(time.exitValue() != 0)
                {
                     res.add(new Result("RTE",runtime,0));
                 
                }
                else{
                    
                File expexted = new File(testdata+"/"+pcode+"/output/output"+tno+".txt");
               // System.out.print(expexted.length() + " "+output.length());
               //System.out.println("Testcase --------> "+tno);
                boolean compareResult = FileUtils.contentEquals(output, expexted);
                if(compareResult)
                    res.add(new Result("AC",runtime,0));
                else
                    res.add(new Result("WA",0,0));
                }
                System.out.println(res.get(res.size()-1).result);
               
            } catch (IOException ex) {
                System.out.println("Test case +"+i+"ERROR "+ex);
            } catch (InterruptedException ex) {
                System.out.println("Test case +"+i+"ERROR "+ex);
            }
            
        }
        new File(runfile).delete();
        error.delete();
        output.delete();
        
        return res;
    }
    
}
