package com.oj.domain;
// Generated 11 Mar, 2018 2:08:06 AM by Hibernate Tools 4.3.1


import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * UserLikesComments generated by hbm2java
 */
@Entity
@Table(name="User_likes_Comments"
    ,catalog="OnlineJudge"
)
public class UserLikesComments  implements java.io.Serializable {


     private UserLikesCommentsId id;
     private Comments comments;
     private User user;
     private int updown;

    public UserLikesComments() {
    }

    public UserLikesComments(UserLikesCommentsId id, Comments comments, User user, int updown) {
       this.id = id;
       this.comments = comments;
       this.user = user;
       this.updown = updown;
    }
   
     @EmbeddedId

    
    @AttributeOverrides( {
        @AttributeOverride(name="username", column=@Column(name="username", nullable=false, length=10) ), 
        @AttributeOverride(name="commentsId", column=@Column(name="Comments_id", nullable=false) ) } )
    public UserLikesCommentsId getId() {
        return this.id;
    }
    
    public void setId(UserLikesCommentsId id) {
        this.id = id;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="Comments_id", nullable=false, insertable=false, updatable=false)
    public Comments getComments() {
        return this.comments;
    }
    
    public void setComments(Comments comments) {
        this.comments = comments;
    }

@ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="username", nullable=false, insertable=false, updatable=false)
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }

    
    @Column(name="updown", nullable=false)
    public int getUpdown() {
        return this.updown;
    }
    
    public void setUpdown(int updown) {
        this.updown = updown;
    }




}

