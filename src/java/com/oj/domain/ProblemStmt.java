/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.oj.domain;

/**
 *
 * @author brizz
 */
public class ProblemStmt {
    private String pcode;
    private String pname;
    private String pstmt;
    private String pinput;
    private String poutput;
    private String pconstrains;
    private String des;
    private String tcin;
    private String tcout;
    private String explain;

    public String getPcode() {
        return pcode;
    }

    public void setPcode(String pcode) {
        this.pcode = pcode;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public String getPstmt() {
        return pstmt;
    }

    public void setPstmt(String pstmt) {
        this.pstmt = pstmt;
    }

    public String getPinput() {
        return pinput;
    }

    public void setPinput(String pinput) {
        this.pinput = pinput;
    }

    public String getPoutput() {
        return poutput;
    }

    public void setPoutput(String poutput) {
        this.poutput = poutput;
    }

    public String getPconstrains() {
        return pconstrains;
    }

    public void setPconstrains(String pconstrains) {
        this.pconstrains = pconstrains;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getTcin() {
        return tcin;
    }

    public void setTcin(String tcin) {
        this.tcin = tcin;
    }

    public String getTcout() {
        return tcout;
    }

    public void setTcout(String tcout) {
        this.tcout = tcout;
    }

    public String getExplain() {
        return explain;
    }

    public void setExplain(String explain) {
        this.explain = explain;
    }

    public ProblemStmt(String pcode, String pname, String pstmt, String pinput, String poutput, String pconstrains, String des, String tcin, String tcout, String explain) {
        this.pcode = pcode;
        this.pname = pname;
        this.pstmt = pstmt;
        this.pinput = pinput;
        this.poutput = poutput;
        this.pconstrains = pconstrains;
        this.des = des;
        this.tcin = tcin;
        this.tcout = tcout;
        this.explain = explain;
    }

    @Override
    public String toString() {
        return "ProblemStmt{" + "pcode=" + pcode + ", pname=" + pname + ", pstmt=" + pstmt + ", pinput=" + pinput + ", poutput=" + poutput + ", pconstrains=" + pconstrains + ", des=" + des + ", tcin=" + tcin + ", tcout=" + tcout + ", explain=" + explain + '}';
    }
    
    
}
