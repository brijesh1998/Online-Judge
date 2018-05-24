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
public class Result {
    
    public String result;
    public long timetaken;
    public long memory;

    public Result(String result, long timetaken, long memory) {
        this.result = result;
        this.timetaken = timetaken;
        this.memory = memory;
    }
    
}
