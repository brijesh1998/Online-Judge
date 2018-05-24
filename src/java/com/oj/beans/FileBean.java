/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.beans;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author brizz
 */
public class FileBean {
    
    
    public String getContent(String fname){
            String file="";
        try(Scanner scanner = new Scanner(new File(fname))) {
    while ( scanner.hasNextLine() ) {
        file += scanner.nextLine()+"\n";
        // process line here.
    }
}       catch (FileNotFoundException ex) {
            Logger.getLogger(FileBean.class.getName()).log(Level.SEVERE, null, ex);
        }
            file=file.replaceAll("<", "&lt;");
            file=file.replaceAll(">", "&gt;");
            file=file.replaceAll("\n", "<br/>");
            //file=file.replaceAll("&", "&amp;");
            System.out.println(file);
        return file;
    }
    
}
